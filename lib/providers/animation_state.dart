import 'package:flutter/material.dart';

class AnimationState extends ChangeNotifier {

  late bool _shouldRunScrollBackAnimation = false;
  bool get shouldRunScrollBackAnimation => _shouldRunScrollBackAnimation;
  void setShouldRunScrollBackAnimation(bool value) {
    _shouldRunScrollBackAnimation = value;
    notifyListeners();
  } 

}