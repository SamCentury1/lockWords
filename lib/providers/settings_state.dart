import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  late Map<String, dynamic> _screenSizeData = {
    "width": 0.0, 
    "height": 0.0,
    // "cluesWidgetHeight":0.0,
    "cryptexHeight": 0.0,
  };
  Map<String, dynamic> get screenSizeData => _screenSizeData;
  void setScreenSizeData(Map<String, dynamic> value) {
    _screenSizeData = value;
    notifyListeners();
  }


  late double _sizeFactor = 1.0;
  double get sizeFactor => _sizeFactor;
  void setSizeFactor(double value) {
    _sizeFactor = value;
    notifyListeners();
  }



  late Map<dynamic, dynamic> _userData = {};
  Map<dynamic, dynamic> get userData => _userData;
  void setUserData(Map<dynamic, dynamic> value) {
    _userData = value;
    notifyListeners();
  }

  late List<Map<dynamic,dynamic>> _levelData = [];
  List<Map<dynamic,dynamic>> get levelData => _levelData;
  void setLevelData(List<Map<dynamic,dynamic>>  value) {
    _levelData = value;
    notifyListeners();
  }
  
}



















































































