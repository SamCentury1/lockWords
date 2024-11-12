import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lock_words/audio/audio_controller.dart';
import 'package:lock_words/audio/sounds.dart';
import 'package:lock_words/components/store_dialog/store_dialog.dart';
import 'package:lock_words/functions/game_logic.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/game_screen/components/cryptex/dial_widget.dart';
import 'package:lock_words/screens/game_screen/game_screen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Helpers {
  // double getDistanceY(GamePlayState gamePlayState) {
  //   List<Offset> dragPath = gamePlayState.dragPath;
  //   double current = 0.0;
  //   double origin = 0.0;      
  //   if (dragPath.isNotEmpty) {
  //     origin = dragPath[0].dy;
  //     current = gamePlayState.dragPath[gamePlayState.dragPath.length-1].dy;
  //   }
  //   double distance = (current-origin);    
  //   return distance;
  // }

  // UPPER PIECE 2
  double getUpperPiece2Offset(double val, double ts, bool isTarget) {
    double res = (-ts)*0.7;
    if (isTarget) {
      if (val < 0.0) {
        res = ((-ts)+val)*0.7 - (val*0.7);
      } else if (val > 0.0) {
        res = ((-ts)+val)*0.7 - (val*0.7);
      }
    }
    return res;
  }

  double getUpperPiece2Angle(double val, double ts, bool isTarget) {
    late double res = -1.57080;
    if (isTarget) {
      if (val < 0.0) {
        res = -1.57080;
      } else {
        double factor = val / ts;
        res = -1.57080 - (factor * -0.7854);
      }
    }
    return res;
  }

  Border getUpperPiece2Border(double val, double tileSize, bool isTarget) {
    double res = 0.0;
    Border border = Border(bottom: BorderSide(color: Colors.black, width: 5.0));
    double factor = val/tileSize;
    if (isTarget) {
      if (factor < 0) {
        res = 5.0 + (4.0 * (factor));
      } else {
        res = 5.0 +  (4.0 * (1-factor.abs()));
      }
      border = Border(bottom: BorderSide(color: Colors.black, width: res));
    }
    return border;
  } 

  // UPPER PIECE 1
  double getUpperPiece1Offset(double val, double ts, bool isTarget) {
    double res = (-(ts)+0.0)*0.7;
    if (isTarget) {

      if (val < 0.0) {
        res = (-(ts)+val)*0.7 - (val*0.7);
      } else {
        res = (-(ts)+val)*0.7;
      }
    }
    
    return res;
  }

  double getUpperPiece1Angle(double val, double ts, bool isTarget) {
    late double res = -0.7854;
    if (isTarget) {
      double factor = val / ts;
      res = -0.7854 - (factor * -0.7854);
    }
    
    return res;
  }


  Border getUpperPiece1Border(double val, double tileSize, bool isTarget) {
    Border border = Border(bottom: BorderSide(color: Colors.black, width: 5.0));
    double res = 1.0;
    double factor = val/tileSize;
    if (isTarget) {
      if (factor < 0) {
        res = 5.0 + (4.0 * (factor));
      } else {
        res = 1.0 +  (4.0 * (1-factor.abs()));
      }
      border = Border(bottom: BorderSide(color: Colors.black, width: res));
    }
    return border;
  }    
  // CENTER PIECE
  double getYOffset(double val, bool isTarget) {
    double res = 0.0;
    if (isTarget) {
      if (val < 0) {
        res = val*0.7;
      } else {
        res = val.toDouble();
      }
    }
    return res;
  }    
  
  double getCenterPieceAngle(double val, double size, bool isTarget) {
    late double res = 0.0;
    if (isTarget) {
      double factor = val / size;
      res = factor * 0.7854;
    }

    
    return res;    
  }
  Border getCenterPieceBorder(double val, double tileSize, bool isTarget) {
    Border border = Border.all(color: Colors.transparent, width: 0.0);
    double res = 1.0;
    double factor = val/tileSize;
    if (isTarget) {
      if (val > 0) {
        res = 1.0 + (4.0 * (factor));
        border = Border(top: BorderSide(color: Colors.black, width: res));
      } else if (val < 0) {
        res = 1.0 +  (4.0 * (factor.abs()));
        border = Border(bottom: BorderSide(color: Colors.black, width: res));
      } else {
        border = Border.all(color: Colors.transparent, width: 0.0);
      }
      
    }
    return border;
  }  


  // LOWER PIECE 1
  double getLowerPiece1Offset(double val, double ts, bool isTarget) {
    double res = ts;
    if (isTarget) {
      if (val < 0.0) {
        res = ((ts)+val);
      } else {
        res = ((ts)+val) - (val*0.3);
      }
    }
    return res;    
  }

  double getLowerPiece1Angle(double val, double ts, bool isTarget) {
    late double res = 0.7854;
    if (isTarget) {
      double factor = val / ts;
      res = 0.7854 + (factor * 0.7854);
    }
    
    return res;    
  }

  Border getLowerPiece1Border(double val, double tileSize, bool isTarget) {
    Border border = Border(top: BorderSide(color: Colors.black, width: 5.0));
    double res = 1.0;
    double factor = val/tileSize;
    if (isTarget) {
      if (factor > 0) {
        res = 5.0 + (4.0 * (factor));
      } else {
        res = 1.0 +  (4.0 * (1-factor.abs()));
      }
      border = Border(top: BorderSide(color: Colors.black, width: res));
    }
    return border;
  }  

  // LOWER PIECE 2
  double getLowerPiece2Offset(double val, double ts, bool isTarget) {
    late double res = (ts - (0.3 * (ts + 0.0))) + ((ts)+0.0);
    if (isTarget) {
      res = (ts - (0.3 * (ts + val))) + ((ts)+val); 
    }
    
    return res; 
  }

  double getLowerPiece2Angle(double val, double ts, bool isTarget) {
    double res = 1.57080;
    if (isTarget) {
      if (val < 0.0) {
        double factor = val / ts;
        res = 1.57080 + (factor*0.7854);
      } else {
        res = 1.57080;
      }
    }
    return res;    
  }

  // bool getIsTarget(GamePlayState gamePlayState, int index) {
  //   bool res = false; 
  //   if (gamePlayState.dragStartWheelId != null && gamePlayState.dragStartWheelId == index) {
  //     res = true;
  //   }
  //   return res;
  // }

  Border getLowerPiece2Border(double val, double tileSize, bool isTarget) {
    double res = 0.0;
    Border border = Border(top: BorderSide(color: Colors.black, width: 5.0));
    double factor = val/tileSize;
    if (isTarget) {
      if (factor > 0) {
        res = 5.0 + (4.0 * (factor));
      } else {
        res = 5.0 +  (4.0 * (1-factor.abs()));
      }
      border = Border(top: BorderSide(color: Colors.black, width: res));
    }
    return border;
  } 

  Map<int,dynamic> getUnHashedLetters(GamePlayState gamePlayState) {
    Map<int,dynamic> res = {};
    gamePlayState.wheelData.forEach((key,value) {
      // int keyVal = int.parse(key);
      res[key] = [];
    });
    gamePlayState.words.forEach((key,value) {
      if (!value["active"]) {
        List<String> letters = value["word"].split("");
        for (int i=0;i<letters.length; i++) {
          List<dynamic> lettersSoFar = res[i]; 
          if (!lettersSoFar.contains(letters[i])) {
            lettersSoFar.add(letters[i]);
          }
        }
      }
    });
    return res;
  }

  void navigateToLevel(String level, BuildContext context, SettingsState settingsState,GamePlayState gamePlayState) {
    Map<dynamic,dynamic> levelData = settingsState.levelData.firstWhere((e) => e["level"] == (level));
    // print(levelData);
    print("user data: ${settingsState.userData}");
    int userBalance = settingsState.userData["balance"];
    gamePlayState.setLevel(level);
    // gamePlayState.setStartingBalance(userBalance);
    gamePlayState.setCoins(userBalance);
    Map<dynamic,dynamic> shuffledClues = shuffleCluesList(levelData["clues"]);

    gamePlayState.setWords(shuffledClues);
    gamePlayState.setWheelData(levelData["wheelData"]);
    gamePlayState.setScore(0);
    
    final double tileSize = settingsState.screenSizeData["cryptexTileAreaWidth"]/gamePlayState.wheelData.length;
    gamePlayState.setTileSize(tileSize);
    // gamePlayState.setTileSize(50.0);

    gamePlayState.setIsGamePaused(false);
    gamePlayState.setIsGameOver(false);
    gamePlayState.startTimer();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const GameScreen())
    );
  }


  void navigateToStartedLevel(String level, BuildContext context, SettingsState settingsState,GamePlayState gamePlayState) {
    Map<dynamic,dynamic> levelData = settingsState.levelData.firstWhere((e) => e["level"] == (level));
    int userBalance = settingsState.userData["balance"];

    Map<dynamic,dynamic> updatedClues = getStartedLevelClues(levelData["clues"], levelData["playedData"]["cluesLeft"]);

    // print(updatedClues);
    gamePlayState.setLevel(level);
    gamePlayState.setCoins(userBalance);

    Map<dynamic,dynamic> shuffledClues = shuffleCluesList(updatedClues);

    // print(shuffledClues);
    gamePlayState.setWords(shuffledClues);
    gamePlayState.setWheelData(levelData["wheelData"]);
    
    final double tileSize = settingsState.screenSizeData["cryptexTileAreaWidth"]/gamePlayState.wheelData.length;
    gamePlayState.setScore(levelData["playedData"]["score"]);
    gamePlayState.setTileSize(tileSize);
    // // gamePlayState.setTileSize(50.0);

    gamePlayState.setIsGamePaused(false);
    gamePlayState.setIsGameOver(false);
    gamePlayState.startTimerFromCustomTime(levelData["playedData"]["time"]);
    
    gamePlayState.startTimer();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const GameScreen())
    );
  }  

  Map<dynamic,dynamic> getStartedLevelClues(Map<dynamic,dynamic> clues, List<dynamic> completedClues) {
    Map<dynamic,dynamic> res = {};

    List<String> wordsLeft = [];
    for (Map<String,dynamic> item in completedClues) {
      wordsLeft.add(item["word"]);
    }

    clues.forEach((key,value) {
      Map<dynamic,dynamic> clueCopy = value;
      // for (var entry in value.entries) {
      //   print("entry => $entry");
      //   clueCopy[entry.key] = clueCopy[entry.value];
      // }      
      if (wordsLeft.contains(value["word"])) {
        


        // print(c)
        final Map<dynamic,dynamic> matched = completedClues.firstWhere((v) => v["word"] == value["word"]);

        clueCopy.update("active", (v) => true);
        clueCopy["hints"] = matched["hints"];
      } else {

        clueCopy.update("active", (v) => false);
        clueCopy["hints"] = 0;
      }
      res[key] = clueCopy;
    });

    return res;
  }

  String getNextLevel(SettingsState settingsState, GamePlayState gamePlayState) {
    // print("getNextLevel function: gamePlayState.level => ${gamePlayState.level}");
    String res = "";

    late List<int> completedLevelKeys = <int>[];
    late List<int> availableLevelKeys = <int>[];
    late int? currentLevelKey = null; 

    for (Map<dynamic,dynamic> levelDocument in settingsState.levelData) {


      if (levelDocument["level"] == gamePlayState.level) {
        currentLevelKey = levelDocument["key"];
      }
      if (levelDocument["playedData"].isEmpty) {
        availableLevelKeys.add(levelDocument["key"]);
      } else {
        completedLevelKeys.add(levelDocument["key"]);
      }
    }

    int? nextLevelKey = null;
    if (currentLevelKey != null) {
      List<int> levelsWithHigherKeys = availableLevelKeys.where((v) => v > currentLevelKey!).toList();
      levelsWithHigherKeys.sort();
      nextLevelKey = levelsWithHigherKeys[0];
      Map<dynamic,dynamic> nextLevelDocument = settingsState.levelData.firstWhere((v) => v["key"] == nextLevelKey);
      res = nextLevelDocument["level"];

    }
    
    return res;
  } 

  Map<dynamic,dynamic> shuffleCluesList(Map<dynamic,dynamic> clues) {
    
    Random rand = Random();
    List<int> shuffledOrder = [];
    List<dynamic> originalList = clues.entries.map((v) => v.value["key"]).toList();

    
    late bool valid = true;
    while (valid) {
      int randomIndex = rand.nextInt(originalList.length);
      int item = originalList[randomIndex];
      originalList.removeAt(randomIndex);
      shuffledOrder.add(item);    
      
      if (originalList.isEmpty) {
        valid = false;
      }
    }
    Map<dynamic,dynamic> shuffled = {};
    for (int i=0; i< shuffledOrder.length; i++ ) {
      // int newIndex = shuffledOrder[i];
      // Map<String,dynamic> clue = clues[newIndex];
      // clue.update("key", (v) => newIndex);
      // shuffled[newIndex] = clue;

      int randomObjectIndex = shuffledOrder[i];
      Map<String,dynamic> clue = clues[randomObjectIndex];
      clue.update("key", (v) => i);
      clue["hints"] = 0;
      shuffled[i] = clue;

    }

    // shuffled.entries.toList().sort(((a,b) => a.key.compareTo(b.key)));
    // print(sorted);
    
    return shuffled;
  }  





  void scrollDown(ItemScrollController itemScrollController,int index) {
    itemScrollController.scrollTo(
      index: index, 
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut
    );
    // scrollCluesController.animateTo(
    //   // scrollCluesController.position.maxScrollExtent,
    //   scrollCluesController.,
    //   // 300,
    //   duration: Duration(seconds: 2),
    //   curve: Curves.fastOutSlowIn,
    // );
  } 

  String formatTimeDigit(int digit) {
    String res = "";
    if (digit >= 0 && digit <= 9) {
      res = "0$digit";
    } else {
      res = "$digit";
    }
    return res;
  }

  Map<String, dynamic> getTimeData(int currentSeconds) {
    late double hours = 0;
    late double minutes = 0;
    late double seconds = 0;

    seconds = (currentSeconds % 60);

    late double absoluteMinutes = (currentSeconds - seconds) / 60;

    if (currentSeconds >= 3600) {
      late double secondsExtraFromHour = (currentSeconds % 3600);
      late double hoursInSeconds = currentSeconds - secondsExtraFromHour;

      hours = hoursInSeconds / 3600;
      minutes = (absoluteMinutes % 60);
    } else {
      minutes = (currentSeconds - seconds) / 60;
    }

    final Map<String, dynamic> res = {
      "hours": hours.round(),
      "minutes": minutes.round(),
      "seconds": seconds.round(),
    };
    return res;
  }


  String formatTime(int timeInSeconds) {
    String res = "";

    late Map<String, dynamic> timeData = getTimeData(timeInSeconds);

    String formattedHours = formatTimeDigit(timeData['hours']);
    String formattedMinutes = formatTimeDigit(timeData['minutes']);
    String formattedSeconds = formatTimeDigit(timeData['seconds']);

    if (timeData['hours'] >= 1) {
      res = "$formattedHours:$formattedMinutes:$formattedSeconds";
    } else {
      res = "$formattedMinutes:$formattedSeconds";
    }

    return res;
  }

  String formatDigitForSummary(int unitValue, String unit) {
    String res = "";
    if (unitValue == 0) {
      res = "";
    } else if (unitValue == 1) {
      res = "$unitValue $unit";
    } else if (unitValue > 1) {
      res = "$unitValue ${unit}s";
    }
    return res;

  } 

  String formatTimeSummary(int timeInSeconds) {
    String res = "";

    late Map<String, dynamic> timeData = getTimeData(timeInSeconds);
    String formattedHours = formatDigitForSummary(timeData['hours'],'hour');
    String formattedMinutes = formatDigitForSummary(timeData['minutes'],'minute');
    String formattedSeconds = formatDigitForSummary(timeData['seconds'],'second');
    if (formattedHours == "") {
      res = "$formattedMinutes $formattedSeconds";
    } else {
      res = "$formattedHours $formattedMinutes $formattedSeconds";
    }
    return res;
  }


  // void executeClueTap(GamePlayState gamePlayState, AnimationState animationState, int clueIndex) {
  //   /// check if there is a clue open
  //   List<int> openHints = [];
  //   gamePlayState.words.forEach((key,value) {
  //     if (value["hintOpen"]) {
  //       openHints.add(key);
  //     }
  //   });



  //   if (openHints.isEmpty) {
  //     animationState.setShouldRunShowHintAnimation(true);
  //   } else {
  //     animationState.setShouldRunShowHintAnimation(true);
  //     animationState.setShouldRunHideHintAnimation(true);
  //   }


  //   print(gamePlayState.words);
  //   // gamePlayState.set
  // }


  void getClueTappedId(
    GamePlayState gamePlayState, 
    AnimationState animationState, 
    int? clueTappedId, 
    AudioController? audioController,
    SettingsState settingsState,
  ) {


    late bool chargePoints = false;


    Map<String,dynamic> res = {};
    List<int> openHints = [];
    gamePlayState.words.forEach((key,value) {
      if (value["hintOpen"]) {
        openHints.add(key);
      }
    });

    late int? previous = null;
    if (openHints.length >1 ) {
      print("there is a problem");
    } else if (openHints.length == 1) {
      previous = openHints[0];
    } else {
      previous = null;
    }

    late int? current = clueTappedId;

    if (current == previous) {
      current = null;
    }

    res = {"current": current, "previous" : previous};

    gamePlayState.setClueTappedIds(res);

    

    late bool hintOpen = false;
    late int hints = 0;
    print("hints => $hints");
    if (clueTappedId != null) {
      hintOpen = gamePlayState.words[clueTappedId]["hintOpen"];
      hints = gamePlayState.words[clueTappedId]["hints"];
    }
    gamePlayState.words.forEach((key,value) {
      if (key == current) {
        value.update("hintOpen", (v) => !hintOpen);
        value.update("hints", (v) => hints + 1); 
      } else {
        value.update("hintOpen", (v) => false);
      }
    });

    

    if (current!=null && previous==null) {
      // print("opened a hint with no hints open");
      animationState.setShouldRunShowHintAnimation(true);
      chargePoints = true;
      audioController!.playSfx(SfxType.flip,settingsState);
    }

    if (current != null && previous != null ) {
      // print("opened a hint with a hint open => res: $res");
      animationState.setShouldRunShowHintAnimation(true);
      animationState.setShouldRunHideHintAnimation(true);
      chargePoints = true;
      audioController!.playSfx(SfxType.flip,settingsState);
    }

    if (current == null && previous != null ) {
      // print("only closing an open hint (scrolled cryptex)");
      animationState.setShouldRunHideHintAnimation(true);
      audioController!.playSfx(SfxType.flip,settingsState);
    }

    if (current == null && previous == null) {
      // print('do nothing');
    }


    if (current != null && !gamePlayState.words[current]["active"]) {
      chargePoints = false;
    }

    if (chargePoints) {

      // gamePlayState.setCoins(gamePlayState.coins-1);

      // GameLogic().executeCoinAnimations(gamePlayState,1,animationState,"-", audioController!, settingsState);
      GameLogic().executeChargeForHint(gamePlayState, animationState, audioController!, settingsState);


    }


    // animationState.setShouldRunShowHintAnimation(true);
    // animationState.setShouldRunHideHintAnimation(true);
    Future.delayed(const Duration(milliseconds: 1000), () {
      animationState.setShouldRunShowHintAnimation(false);
      animationState.setShouldRunHideHintAnimation(false);
      animationState.setShouldRunCoinAnimation(false);
    });


    
  }

  String getClueWordHint(GamePlayState gamePlayState, int clueIndex) {
    Map<dynamic,dynamic> wheelData = gamePlayState.wheelData;
    Map<dynamic,dynamic> letterIndexes = gamePlayState.activeLetterIndexes;
    Map<String,dynamic> clue = gamePlayState.words[clueIndex];

    late String res = "";
    for (int i=0; i< wheelData.length; i++) {
      String currentLetter = wheelData[i][letterIndexes[i]];
      String clueLetter = clue["word"][i];
      if (currentLetter == clueLetter) {
        res = res + clueLetter;
      } else {
        res = res + "*";
      }
    
    }
    if (clue["active"]==false) {
      res = clue["word"];
    }

    return res;
  }



  Map<dynamic,dynamic> getRandomCoinAnimationOffsets() {
    late Map<dynamic,dynamic> res = {};
    Random rand = Random();
    for (int i=0; i<1; i++) {
      final double xSign = rand.nextInt(10) > 5 ? -1 : 1;
      final double ySign = rand.nextInt(10) > 5 ? -1 : 1;      
      late double x = rand.nextDouble()*50 ;
      late double y = rand.nextDouble()*50 ;
      res[i] = {"dx":x*xSign, "dy":y*ySign};
    }

    return res;
  }

  Offset getRandomCoinOffset() {
    Random rand = Random();
    final double xSign = rand.nextInt(10) > 5 ? -1 : 1;
    final double ySign = rand.nextInt(10) > 5 ? -1 : 1;      
    late double x = rand.nextDouble()*50 ;
    late double y = rand.nextDouble()*50 ;
    return Offset(x*xSign, y*ySign);
  }


  Map<dynamic,dynamic> getCoinAnimationPaths() {


    final Offset position = getRandomCoinOffset();

    Map<dynamic,dynamic> pathData = {};

    double seconds = 2;
    double fps = 60; 
    // double delayIncrement = 15;
    double animationLength = 60;
  // offsetData.forEach((key,value) {
    // final double delay = delayIncrement ;
    // final double endLength = 100 - (delay + animationLength + outroLength);

    // final int introFrames = ((delay/100) * (seconds*fps)).round();
    final int animationFrames = ((animationLength/100) * (seconds*fps)).round();
    final int outroFrames = (((100-animationLength)/100) * (seconds*fps)).round();
    // final int endFrames = ((endLength/100) * (seconds*fps)).round();
    final double outroIncrement = 1.0 / (outroFrames);
    final double yIncrement = 30 / (seconds*fps);

    // print("intro: $introFrames | animation: $animationFrames | outro: $outroFrames | end: $endFrames");

    List<double> visibilityPath = [];
    List<double> xPath = List.generate(((seconds*fps).round()), (v) => position.dx);
    List<double> yPath = [];

    late double y = 0.0;

    for (int i=0; i<animationFrames; i++) {
      visibilityPath.add(1.0);
      y = y - yIncrement;
      yPath.add(y);
    }

    for (int i=0; i<outroFrames; i++) {
      visibilityPath.add(1.0 - (i*outroIncrement));
      y = y - yIncrement;
      yPath.add(y);      
    }


    pathData = {"dx": xPath, "dy": yPath, "visibility": visibilityPath};

    // print(visibilityPath.length);
    // });
    return pathData;
  }


  List<Offset> getSparks2(double width, double height) {
    late List<Offset> res = [];
    Random rand = Random();
    
    // LEFT WALL
    for (int i=0; i<10; i++) {
      final double x = (width/2) * -1.0;
      late double y = i.isEven ? -1.0 : 1.0;
      y = y * rand.nextDouble() * (height/2);
      final Offset offset1 = Offset(x,y);
      res.add(offset1);  
    }

    /// RIGHT
    for (int i=0; i<10; i++) {
      final double x = (width/2);
      late double y = i.isEven ? -1.0 : 1.0;
      y = y * rand.nextDouble() * (height/2);
      final Offset offset2 = Offset(x,y);
      res.add(offset2);  
    }
    /// TOP
    for (int i=0; i<10; i++) {
      final double y = (height/2) * -1.0;
      late double x = i.isEven ? -1.0 : 1.0;
      x = x * rand.nextDouble() * (width/2);
      final Offset offset3 = Offset(x,y);
      res.add(offset3);  
    }  
    
    /// DOWN
    for (int i=0; i<10; i++) {
      final double y = (height/2);
      late double x = i.isEven ? -1.0 : 1.0;
      x = x * rand.nextDouble() * (width/2);
      final Offset offset4 = Offset(x,y);
      res.add(offset4);  
    }  

    return res;
  }


  List<Map<String,dynamic>> getSparkPaths(double width, double height) {


    List<Offset> sparks = getSparks2(width, height);
    List<Map<String,dynamic>> res = [];
    Random rand = Random();
    const int seconds = 10;
    const int fps = 60;
    final double centerX = width/2;
    final double centerY = height/2; 

    late int inDuration = 0;
    late int mainDuration = 0;
    late int outDuration = 0;
    
    for (int i=0; i<sparks.length; i++) {
      // Offset sparkStart = sparksStart[i];
      Offset sparkEnd = sparks[i];
      // print(spark);
      late double size = rand.nextInt(4)+1;

      inDuration = ((rand.nextInt(30) / 100) * (seconds*fps)).round();
      mainDuration = ((rand.nextInt(50) / 100) * (seconds*fps)).round();
      outDuration = (seconds*fps) - (inDuration+mainDuration);
      

      late double incrementX = (sparkEnd.dx)/mainDuration;
      late double incrementY = (sparkEnd.dy)/mainDuration;

      List<Offset> path = [];
      List<double> opacity = [];

      for (int j=0; j<inDuration; j++) {
        double dx = centerX;
        double dy = centerY;
        Offset point = Offset(dx,dy);
        path.add(point);
        opacity.add(0.0);
      }

      for (int j=0; j<mainDuration; j++) {
        double dx = centerX + (incrementX * j);
        double dy = centerY + (incrementY * j);
        Offset point = Offset(dx,dy);
        path.add(point);
        opacity.add(1.0);
      }

      for (int j=0; j<outDuration; j++) {
        double dx = centerX  + sparkEnd.dx;
        double dy = centerY  + sparkEnd.dy;
        Offset point = Offset(dx,dy);
        path.add(point);
        opacity.add(0.0);
      }

      res.add({"key":i, "size":size, "path": path, "opacity": opacity,});

    }
    return res;
  }

  List<Widget> getCryptexWheel(GamePlayState gamePlayState) {
    List<Widget> res = [];
    
    var sortedEntries = gamePlayState.wheelData.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    
    for (var entry in sortedEntries) {
      Widget wheel = DialWidget(index: entry.key);
      res.add(wheel);
    }

    return res;
  }

  List<int> shuffleList(List<int> items) {
    
    Random rand = Random();
    List<int> shuffled = [];
    List<int> originalList = items;
    
    late bool valid = true;
    while (valid) {
      int randomIndex = rand.nextInt(originalList.length);
      int item = originalList[randomIndex];
      originalList.removeAt(randomIndex);
      shuffled.add(item);    
      
      if (originalList.isEmpty) {
        valid = false;
      }
    }


    return shuffled;
  }

  int getClueSummaryData(GamePlayState gamePlayState) {
    late int active = 0;
    gamePlayState.words.forEach((key,value) {
      if (!value["active"]) {
        active++;
      }
    });
    return active;
  }  


  String getCompletedCluesString(GamePlayState gamePlayState) {
    int completed = getClueSummaryData(gamePlayState);
    return "${completed}/${gamePlayState.words.length}";
  }


  Future<void> openStoreDialog(BuildContext context,) async {
    return showDialog(
      context: context, 
      builder: (context) {
        return StoreDialog();
      }
    );
  }

}

