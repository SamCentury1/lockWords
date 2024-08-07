import 'package:lock_words/providers/game_play_state.dart';

class GameLogic {
  void executeMoveUp(GamePlayState gamePlayState) {
    late int? wheelIndex = gamePlayState.dragStartWheelId;
    Map<dynamic,dynamic> wheel = gamePlayState.wheelData;
    late List<String> wheelData = wheel[wheelIndex];

    String target = wheelData[0];
    wheelData.removeAt(0);
    wheelData.insert(wheelData.length, target);

    gamePlayState.wheelData.update(wheelIndex, (v) => wheelData);

    print("execute move in wheel ${gamePlayState.wheelData[wheelIndex]}");

  }

  void executeMoveDown(GamePlayState gamePlayState) {
    late int? wheelIndex = gamePlayState.dragStartWheelId;
    Map<dynamic,dynamic> wheel = gamePlayState.wheelData;
    final List<String> wheelData = wheel[wheelIndex];

    String target = wheelData[wheelData.length-1];
    wheelData.removeLast();
    wheelData.insert(0, target);

    gamePlayState.wheelData.update(wheelIndex, (v) => wheelData);

    print("execute move in wheel ${gamePlayState.wheelData[wheelIndex]}");
  }


  void validateGuess(GamePlayState gamePlayState, Map<String,dynamic> clueData,) {
    String candidate = "";
    gamePlayState.wheelData.forEach((key,value) {
      candidate = candidate + value[2];
    });

    String targetWord = clueData["word"];

    if (candidate == targetWord) {
      print("we have a match!");
      Map<dynamic,dynamic> wordData = gamePlayState.words;
      wordData[clueData["key"]].update("active", (v) => false);
      gamePlayState.setWords(wordData);
    } else {
      print("mistake!");
    }




  }

  
}