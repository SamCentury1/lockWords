import 'dart:async';

import 'package:flutter/material.dart';

class GamePlayState extends ChangeNotifier {
  
  late String _level = "";
  String get level => _level;
  void setLevel(String value) {
    _level = value;
    notifyListeners();
  }    
  
  late double _tileSize = 0.0;
  double get tileSize => _tileSize;
  void setTileSize(double value) {
    _tileSize = value;
    notifyListeners();
  }  

  // late int? _dragStartWheelId = null;
  // int? get dragStartWheelId => _dragStartWheelId;
  // void setDragStartWheelId(int? value) {
  //   _dragStartWheelId = value;
  //   notifyListeners();
  // }  


  // late double _distanceFromOrigin = 0.0;
  // double get distanceFromOrigin => _distanceFromOrigin;
  // void setDistanceFromOrigin(double value) {
  //   _distanceFromOrigin = value;
  //   notifyListeners();
  // }    

  // late List<Offset> _dragPath = [];
  // List<Offset> get dragPath => _dragPath;
  // void setDragPath(List<Offset> value) {
  //   _dragPath = value;
  //   notifyListeners();
  // }

  late Map<dynamic,dynamic> _words = {
    // 0: {"key" : 0, "word": "GAINS", "active":true, "clue": "Made lots of progress"},
    // 1: {"key" : 1, "word": "SAINT", "active":true, "clue": "Would do you no harm"},
    // 2: {"key" : 2, "word": "THINS", "active":true, "clue": "Looking for a little snack"},
    // 3: {"key" : 3, "word": "WHORE", "active":true, "clue": "Said of a promiscuous woman"},
    // 4: {"key" : 4, "word": "WROTE", "active":true, "clue": "transcribed onto paper"},
    // 5: {"key" : 5, "word": "WHERE", "active":true, "clue": "Who, what, why, ___, when, how"},
    // 6: {"key" : 6, "word": "SWORE", "active":true, "clue": "we made a promise, we ______"},
    // 7: {"key" : 7, "word": "SLOTS", "active":true, "clue": "at the casino, I'll lose my money here"},
    // 8: {"key" : 8, "word": "SLATS", "active":true, "clue": "thin, narrow pieces of wood, plastic, or metal"},
    // 9: {"key" : 9, "word": "SLANT", "active":true, "clue": "slope, or lean in a direction"},
    // 10: {"key" : 10, "word": "FRIES", "active":true, "clue": "I'd like this with my burger please"},
    // 11: {"key" : 11, "word": "SHARK", "active":true, "clue": "I got beat at billiards by someone whom I thought was a novice"},
    // 12: {"key" : 12, "word": "TWINS", "active":true, "clue": "roomates in the womb, so to speak"},
    // 13: {"key" : 13, "word": "FLOOR", "active":true, "clue": "facing the ceiling"},
    // 14: {"key" : 14, "word": "WASTE", "active":true, "clue": "goes onto the curb a couble nights a week"},
    // 15: {"key" : 15, "word": "GREET", "active":true, "clue": "To make an introduction"},
    // 16: {"key" : 16, "word": "SHOTS", "active":true, "clue": "I've had 10 of these before I blacked out"},
    // 17: {"key" : 17, "word": "SHORT", "active":true, "clue": "A man who lis below 5'5 is said to be ___"},
    // 18: {"key" : 18, "word": "SHIRT", "active":true, "clue": "I got kicked out of a restaurant for refusing to wear this"},
    // 19: {"key" : 19, "word": "SLEEK", "active":true, "clue": "Looking sharp"},            
  };
  Map<dynamic,dynamic> get words => _words;
  void setWords(Map<dynamic,dynamic> value) {
    _words = value;
    notifyListeners();
  }  


  late Map<dynamic,dynamic> _wheelData = {
    // 0 : ["S","T","F","W","G",],
    // 1 : ["W","L","A","R","H",],
    // 2 : ["O","S","E","A","I",],
    // 3 : ["T","E","R","N","O",],
    // 4 : ["T","K","S","R","E",],
  };
  Map<dynamic,dynamic> get wheelData => _wheelData;
  void setWheelData(Map<dynamic,dynamic> value) {
    _wheelData = value;
    notifyListeners();
  }


  late double _offsetAtAnimation = 0.0;
  double get offsetAtAnimation => _offsetAtAnimation;
  void setOffsetAtAnimation(double value) {
    _offsetAtAnimation = value;
    notifyListeners();
  }

  late int _score = 0;
  int get score => _score;
  void setScore(int value) {
    _score = value;
    notifyListeners();
  }  


  // late int? _swipedClueStartId = null;
  // int? get swipedClueStartId => _swipedClueStartId;
  // void setSwipedClueStartId(int? value) {
  //   _swipedClueStartId = value;
  //   notifyListeners();
  // }
  // late List<double> _clueSwipePath = [];
  // List<double> get clueSwipePath => _clueSwipePath;
  // void setClueSwipePath(List<double> value) {
  //   _clueSwipePath = value;
  //   notifyListeners();
  // }

  // late int? _swipedWheelId = null;
  // int? get swipedWheelId => _swipedWheelId;
  // void setSwipedWheelId(int? value) {
  //   _swipedWheelId = value;
  //   notifyListeners();
  // }  


  late Map<dynamic,dynamic> _activeLetterIndexes = {
    0 : 3,
    1 : 3,
    2 : 3,
    3 : 3,
    4 : 3,
  };
  Map<dynamic,dynamic> get activeLetterIndexes => _activeLetterIndexes;
  void setActiveLetterIndexes(Map<dynamic,dynamic> value) {
    _activeLetterIndexes = value;
    notifyListeners();
  }

  
  late Map<String,dynamic> _clueTappedIds = {};
  Map<String,dynamic> get clueTappedIds => _clueTappedIds;
  void setClueTappedIds(Map<String,dynamic> value) {
    _clueTappedIds = value;
    notifyListeners();
  }

  // late Map<String,dynamic> _clueSummaryViewData = {};
  // Map<String,dynamic> get clueSummaryViewData => _clueSummaryViewData;
  // void setClueSummaryViewData(Map<String,dynamic> value) {
  //   _clueSummaryViewData = value;
  //   notifyListeners();
  // }  

  // late double _clueOffsetPosition = 0.0;
  // double get clueOffsetPosition => _clueOffsetPosition;
  // void setClueOffsetPosition(double value) {
  //   _clueOffsetPosition = value;
  //   notifyListeners();
  // }
    
  late Offset? _clueTappedPosition = null;
  Offset? get clueTappedPosition => _clueTappedPosition;
  void setClueTappedPosition(Offset? value) {
    _clueTappedPosition = value;
    notifyListeners();
  }

  late int _coins = 0;
  int get coins => _coins;
  void setCoins(int value) {
    _coins = value;
    notifyListeners();
  }

  // late int _startingBalance = 0;
  // int get startingBalance => _startingBalance;
  // void setStartingBalance(int value) {
  //   _startingBalance = value;
  //   notifyListeners();
  // }  

  

  late bool _isLockOnLeft = true;
  bool get isLockOnLeft => _isLockOnLeft;
  void setIsLockOnLeft(bool value) {
    _isLockOnLeft = value;
    notifyListeners();
  }  



  late bool _isGamePaused = false;
  bool get isGamePaused => _isGamePaused;
  void setIsGamePaused(bool value) {
    _isGamePaused = value;
    notifyListeners();
  }  

  late bool _isGameOver = false;
  bool get isGameOver => _isGameOver;
  void setIsGameOver(bool value) {
    _isGameOver = value;
    notifyListeners();
  } 
 
  late Map<String,dynamic> _gameData = {};
  Map<String,dynamic> get gameData => _gameData;
  void setGameData(Map<String,dynamic> value) {
    _gameData = value;
    notifyListeners();
  }   

  Duration _duration = const Duration(seconds: 0);
  Duration get duration => _duration;

  Timer? _timer;
  Timer get timer => _timer!;

  void addTick() {
    if (!_isGamePaused) {
      const int addSeconds = 1;
      final int seconds = _duration.inSeconds + addSeconds;
      _duration = Duration(seconds: seconds);
      notifyListeners();
    }
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => addTick());
  }

  void startTimerFromCustomTime(int time) {
    _timer?.cancel();
    _duration = Duration(seconds: time); 
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => addTick());
  }

  void quitGame() {
    _duration = const Duration();
    _timer?.cancel();
    // _score = 0;
    _coins = 0;
    _words = {};
    _wheelData = {};
    _isGamePaused = false;
    _isGameOver = false; 
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}