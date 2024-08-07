import 'package:flutter/material.dart';

class GamePlayState extends ChangeNotifier {
  late double _tileSize = 0.0;
  double get tileSize => _tileSize;
  void setTileSize(double value) {
    _tileSize = value;
    notifyListeners();
  }  

  late int? _dragStartWheelId = null;
  int? get dragStartWheelId => _dragStartWheelId;
  void setDragStartWheelId(int? value) {
    _dragStartWheelId = value;
    notifyListeners();
  }  

  late double _distanceFromOrigin = 0.0;
  double get distanceFromOrigin => _distanceFromOrigin;
  void setDistanceFromOrigin(double value) {
    _distanceFromOrigin = value;
    notifyListeners();
  }    

  late List<Offset> _dragPath = [];
  List<Offset> get dragPath => _dragPath;
  void setDragPath(List<Offset> value) {
    _dragPath = value;
    notifyListeners();
  }

  late Map<dynamic,dynamic> _words = {
    0: {"key" : 0, "word": "GAINS", "active":true, "clue": "Made lots of progress"},
    1: {"key" : 1, "word": "SAINT", "active":true, "clue": "Would do you no harm"},
    2: {"key" : 2, "word": "THINS", "active":true, "clue": "Looking for a little snack"},
    3: {"key" : 3, "word": "WHORE", "active":true, "clue": "Said of a promiscuous woman"},
    4: {"key" : 4, "word": "WROTE", "active":true, "clue": "transcribed onto paper"},
    5: {"key" : 5, "word": "WHERE", "active":true, "clue": "Who, what, why, ___, when, how"},
    6: {"key" : 6, "word": "SWORE", "active":true, "clue": "we made a promise, we ______"},
    7: {"key" : 7, "word": "SLOTS", "active":true, "clue": "at the casino, I'll lose my money here"},
    8: {"key" : 8, "word": "SLATS", "active":true, "clue": "thin, narrow pieces of wood, plastic, or metal"},
    9: {"key" : 9, "word": "SLANT", "active":true, "clue": "slope, or lean in a direction"},
    10: {"key" : 10, "word": "FRIES", "active":true, "clue": "I'd like this with my burger please"},
    11: {"key" : 11, "word": "SHARK", "active":true, "clue": "I got beat at billiards by someone whom I thought was a novice"},
    12: {"key" : 12, "word": "TWINS", "active":true, "clue": "roomates in the womb, so to speak"},
    13: {"key" : 13, "word": "FLOOR", "active":true, "clue": "facing the ceiling"},
    14: {"key" : 14, "word": "WASTE", "active":true, "clue": "goes onto the curb a couble nights a week"},
    15: {"key" : 15, "word": "GREET", "active":true, "clue": "To make an introduction"},
    16: {"key" : 16, "word": "SHOTS", "active":true, "clue": "I've had 10 of these before I blacked out"},
    17: {"key" : 17, "word": "SHORT", "active":true, "clue": "A man who lis below 5'5 is said to be ___"},
    18: {"key" : 18, "word": "SHIRT", "active":true, "clue": "I got kicked out of a restaurant for refusing to wear this"},
    19: {"key" : 19, "word": "SLEEK", "active":true, "clue": "Looking sharp"},            
  };
  Map<dynamic,dynamic> get words => _words;
  void setWords(Map<dynamic,dynamic> value) {
    _words = value;
    notifyListeners();
  }  


  late Map<dynamic,dynamic> _wheelData = {
    0 : ["S","T","F","W","G",],
    1 : ["W","L","A","R","H",],
    2 : ["O","S","E","A","I",],
    3 : ["T","E","R","N","O",],
    4 : ["T","K","S","R","E",],
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


  late int? _swipedClueStartId = null;
  int? get swipedClueStartId => _swipedClueStartId;
  void setSwipedClueStartId(int? value) {
    _swipedClueStartId = value;
    notifyListeners();
  }
  late List<double> _clueSwipePath = [];
  List<double> get clueSwipePath => _clueSwipePath;
  void setClueSwipePath(List<double> value) {
    _clueSwipePath = value;
    notifyListeners();
  }

}