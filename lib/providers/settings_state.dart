import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  late Map<String, dynamic> _screenSizeData = {
    "width": 0.0, 
    "height": 0.0,
    "lockWidgetHeight": 0.0,
    "cluesWidgetHeight":0.0,
    "topWidgetHeight":0.0,
  };
  Map<String, dynamic> get screenSizeData => _screenSizeData;
  void setScreenSizeData(Map<String, dynamic> value) {
    _screenSizeData = value;
    notifyListeners();
  }

}