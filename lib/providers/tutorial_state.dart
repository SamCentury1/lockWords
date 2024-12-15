import 'package:flutter/foundation.dart';

class TutorialState extends ChangeNotifier {
  late Map<dynamic,dynamic> _tutorialData = {
    0 : {"step": 0, "text": "Welcome to the tutorial screen 1!"} 
  };
  Map<dynamic,dynamic> get tutorialData => _tutorialData;

  
  // void settutorialData(Map<String,dynamic> value) {
  //   _tutorialData = value;
  //   notifyListeners();
  // }   
}