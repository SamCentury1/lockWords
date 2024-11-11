import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lock_words/audio/audio_controller.dart';
import 'package:lock_words/audio/sounds.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/resources/firestore_methods.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class GameLogic {
  // void executeMoveUp(GamePlayState gamePlayState) {
  //   late int? wheelIndex = gamePlayState.dragStartWheelId;
  //   Map<dynamic,dynamic> wheel = gamePlayState.wheelData;
  //   late List<String> wheelData = wheel[wheelIndex];

  //   String target = wheelData[0];
  //   wheelData.removeAt(0);
  //   wheelData.insert(wheelData.length, target);

  //   gamePlayState.wheelData.update(wheelIndex, (v) => wheelData);

  //   print("execute move in wheel ${gamePlayState.wheelData[wheelIndex]}");

  // }

  // void executeMoveDown(GamePlayState gamePlayState) {
  //   late int? wheelIndex = gamePlayState.dragStartWheelId;
  //   Map<dynamic,dynamic> wheel = gamePlayState.wheelData;
  //   final List<String> wheelData = wheel[wheelIndex];

  //   String target = wheelData[wheelData.length-1];
  //   wheelData.removeLast();
  //   wheelData.insert(0, target);

  //   gamePlayState.wheelData.update(wheelIndex, (v) => wheelData);

  //   print("execute move in wheel ${gamePlayState.wheelData[wheelIndex]}");
  // }

  void executeSelectedItemChanged(
    GamePlayState gamePlayState,
    AnimationState animationState, 
    var details, 
    int index,
    AudioController audioController, 
    SettingsState settingsState
    ) {
    Helpers().getClueTappedId(gamePlayState,animationState,null, audioController,settingsState);
    // List<String> wheel = gamePlayState.wheelData[index];
    // String letter = wheel[details];
    
    gamePlayState.words.forEach((key,value) {
      value.update("hintOpen", (v) => false);
    });
    Map<dynamic,dynamic> activeLetterIndexes = gamePlayState.activeLetterIndexes;
    activeLetterIndexes.update(index, (_) => details);
    gamePlayState.setActiveLetterIndexes(activeLetterIndexes);

    // audioController.playSfx(SfxType.lock_successful);
    // print(letter);
    // print("butt caca $details");
    // print(gamePlayState.activeLetterIndexes);
  }  


  void validateGuess(
    BuildContext context, 
    GamePlayState gamePlayState, 
    ItemScrollController itemScrollController, 
    AnimationState animationState,
    AudioController audioController,
    SettingsState settingsState
    ) {

    String word = "";
    gamePlayState.activeLetterIndexes.forEach((key,value) {
      List<dynamic> wheel = gamePlayState.wheelData[key];
      String letter = wheel[value];
      word = word+letter;
    });

    Map<dynamic,dynamic> validClue = {};
    gamePlayState.words.forEach((key,value) {
      if (value["word"] == word) {
        validClue = value; 
      }
    });


    if (validClue.isEmpty) {
      // no solution
      audioController.playSfx(SfxType.lockUnsuccessful,settingsState);
      animationState.setShouldRunLockQuarterTurn(true);
      Future.delayed(const Duration(milliseconds:300), () {
        animationState.setShouldRunLockQuarterTurn(false);
      });        
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1000),
          content: Text('$word is not a solution.'),
        ),
      );
    } else {

      if (!validClue["active"]) {
        // already found
        animationState.setShouldRunLockQuarterTurn(true);
        audioController.playSfx(SfxType.lockUnsuccessful,settingsState);
        Future.delayed(const Duration(milliseconds:300), () {
          animationState.setShouldRunLockQuarterTurn(false);
        });
        print("already found $word");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 500),
            content: Text('You already found $word.'),
          ),
        );        
      } else {
        // new found - execute anims
        print("you found the word $word");
        Map<dynamic,dynamic> clues = gamePlayState.words; 
        // int wordIndex = words.indexOf(word);
        int wordIndex = validClue["key"];
        Map<dynamic,dynamic>  clue = clues[wordIndex];
        
        clue.update("active", (_) => false );
        audioController.playSfx(SfxType.lockSuccessful,settingsState);
        audioController.playSfx(SfxType.wordFoundWoosh,settingsState);
        gamePlayState.setWords(clues);
        Helpers().scrollDown(itemScrollController,wordIndex);
        List<Map<String,dynamic>> sparks = Helpers().getSparkPaths(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
        bool isGameOver = executeGameOverCheck(gamePlayState);

        animationState.setSparksAnimationDetails(sparks);
        animationState.setShouldRunWordFoundAnimation(true);
        animationState.setWordFoundWheelIndexes(gamePlayState.activeLetterIndexes);
        animationState.setWordFoundClueIndex(wordIndex);
        gamePlayState.timer.cancel();
        Future.delayed(const Duration(milliseconds: 3000), () {
          animationState.setShouldRunWordFoundAnimation(false);
          animationState.setWordFoundWheelIndexes({});
          animationState.setWordFoundClueIndex(null);
          int pointsScored = calculatePointsScored(gamePlayState,clue);

          if (isGameOver) {
            // gamePlayState.setCoins((gamePlayState.coins + clue["value"]) as int);
            gamePlayState.setScore(gamePlayState.score+pointsScored);
            gamePlayState.setIsGameOver(true);
            gamePlayState.setIsGamePaused(true);
            
            audioController.playSfx(SfxType.levelComplete,settingsState);

            final Map<String,dynamic> gameData = {
              "level" : gamePlayState.level, 
              "time": gamePlayState.duration.inSeconds,
              "createdAt": DateTime.now().toIso8601String(),
              "score": gamePlayState.score,
              "endingBalance": gamePlayState.coins,
              "cluesLeft": [],
            };
            gamePlayState.setGameData(gameData);

            FirestoreMethods().saveGame(settingsState,gamePlayState);

            

          } else {
            gamePlayState.startTimer();
            animationState.setShouldRunCoinAnimation(true);
            // int pointsScored = calculatePointsScored(gamePlayState,clue["value"]);
            executeScoreCount(gamePlayState, animationState,pointsScored);
            // executeCoinAnimations(gamePlayState,clue["value"],animationState,"+", audioController,settingsState);
          }
          // animationState.setShouldRunCoinAnimation(true);
        });        
      }

    }
  }

  bool executeGameOverCheck(GamePlayState gamePlayState) {
    late bool res = false;
    int cluesLeft = 0;
    gamePlayState.words.forEach((key,value) {
      if (value["active"]) {
        cluesLeft++;
      }
    });

    if (cluesLeft == 0) {
      res = true;
    }
    return res;
  }

  int calculatePointsScored(GamePlayState gamePlayState, Map<dynamic,dynamic> clueData) {
    int res = 0;
    int clueValue = clueData["value"];
    int maxTime = 1500;
    int secondsElapsed = gamePlayState.duration.inSeconds; 
    int timeNumerator = secondsElapsed > maxTime ? maxTime : secondsElapsed;
    int baseScore = clueValue * 100;
    int hintDeduction = (clueValue * clueData["hints"]).round();
    int timeDeduction = ((timeNumerator/maxTime) * (clueValue * 50)).round();
    
    res = (baseScore-timeDeduction-hintDeduction).round();
    
    return res;
  }


  // void executeCoinAnimations(
  //   GamePlayState gamePlayState, 
  //   int stops, 
  //   AnimationState animationState, 
  //   String sign, 
  //   AudioController audioController, 
  //   SettingsState settingsState
  //   ) {

  //   // int stops = clue["value"];
  //   double interval = 500; // duration/stops;
  //   int counter = 0; // To count the number of times functionA is called
  //   Timer timer = Timer.periodic(Duration(milliseconds: interval.round()), (Timer t) {
  //     executeCoinAnimation(gamePlayState,animationState,sign, audioController,settingsState);
  //     counter++;
  //     if (counter >= stops) {
  //       t.cancel();
  //     }
  //   });    
  // }

  // void executeCoinAnimation(GamePlayState gamePlayState,  AnimationState animationState, String sign, AudioController audioController, SettingsState settingsState) {
    
  //   Map<dynamic,dynamic> path = Helpers().getCoinAnimationPaths();
  //   animationState.setCoinAnimationDetails({"path": path, "sign": sign});
  //   animationState.setShouldRunCoinAnimation(true);
  //   if (sign == "+") { 
  //     gamePlayState.setCoins(gamePlayState.coins + 1);
  //     audioController.playSfx(SfxType.coin,settingsState);
  //   } else {
  //     gamePlayState.setCoins(gamePlayState.coins - 1);
  //     audioController.playSfx(SfxType.charge,settingsState);
  //   }
  //   Future.delayed(const Duration(milliseconds: 490), () {
  //     animationState.setShouldRunCoinAnimation(false);
  //   });
  // }

  void executeChargeForHint(GamePlayState gamePlayState,  AnimationState animationState, AudioController audioController, SettingsState settingsState) {
    
    // Map<dynamic,dynamic> path = Helpers().getCoinAnimationPaths();
    // animationState.setCoinAnimationDetails({"path": path, "sign": sign});
    animationState.setShouldRunCoinAnimation(true);
    // if (sign == "+") { 
      // gamePlayState.setCoins(gamePlayState.coins + 1);
      // audioController.playSfx(SfxType.coin,settingsState);
    // } else {
    gamePlayState.setCoins(gamePlayState.coins - 10);
    audioController.playSfx(SfxType.charge,settingsState);
    // }
    Future.delayed(const Duration(milliseconds: 1000), () {
      animationState.setShouldRunCoinAnimation(false);
      gamePlayState.setClueTappedPosition(null);
    });
  }


  void executeScoreCount(GamePlayState gamePlayState, AnimationState animationState, int pointsScored) {
    double interval = 50; // duration/stops;
    int counter = 0; // To count the number of times functionA is called
    int stops = pointsScored;

    int stopsFloor = (stops / 10).floor();

    print("stops / 10 = ${stops/10}");
    print("stops floor = $stopsFloor");

    double remaining = ((stops/10) - stopsFloor)*10;


    Timer timer = Timer.periodic(Duration(milliseconds: interval.round()), (Timer t) {
      // executeCoinAnimation(gamePlayState,animationState,sign, audioController,settingsState);
      // counter++;
      
      if (counter == stopsFloor) {
        gamePlayState.setScore( gamePlayState.score + remaining.round());

        t.cancel();
        animationState.setShouldRunScoreCountAnimation(true);
        Future.delayed(Duration(milliseconds: 1000), () {
          animationState.setShouldRunScoreCountAnimation(false);
          print("animation has stopped");
        });

      } else {
        counter++;
        gamePlayState.setScore( gamePlayState.score + 10 );


      }

      // counter++;
      // gamePlayState.setScore( gamePlayState.score + 10 );
      
      // if (counter >= stopsFloor) {
      //   t.cancel();
      //   animationState.setShouldRunScoreCountAnimation(false);
      // }

    });       
  }
}

