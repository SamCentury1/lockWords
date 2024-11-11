import 'package:flutter/material.dart';

class AnimationState extends ChangeNotifier {

  late bool _shouldRunScrollBackAnimation = false;
  bool get shouldRunScrollBackAnimation => _shouldRunScrollBackAnimation;
  void setShouldRunScrollBackAnimation(bool value) {
    _shouldRunScrollBackAnimation = value;
    notifyListeners();
  } 


  late bool _shouldRunWordFoundAnimation = false;
  bool get shouldRunWordFoundAnimation => _shouldRunWordFoundAnimation;
  void setShouldRunWordFoundAnimation(bool value) {
    _shouldRunWordFoundAnimation = value;
    notifyListeners();
  }

  late bool _shouldRunScoreCountAnimation = false;
  bool get shouldRunScoreCountAnimation => _shouldRunScoreCountAnimation;
  void setShouldRunScoreCountAnimation(bool value) {
    _shouldRunScoreCountAnimation = value;
    notifyListeners();
  }



  late bool _shouldRunLockQuarterTurn = false;
  bool get shouldRunLockQuarterTurn => _shouldRunLockQuarterTurn;
  void setShouldRunLockQuarterTurn(bool value) {
    _shouldRunLockQuarterTurn = value;
    notifyListeners();
  }

  late bool _shouldRunLockQuarterTurnReverse = false;
  bool get shouldRunLockQuarterTurnReverse => _shouldRunLockQuarterTurnReverse;
  void setShouldRunLockQuarterTurnReverse(bool value) {
    _shouldRunLockQuarterTurnReverse = value;
    notifyListeners();
  }  

  late bool _shouldRunLockFullTurn = false;
  bool get shouldRunLockFullTurn => _shouldRunLockFullTurn;
  void setShouldRunLockFullTurn(bool value) {
    _shouldRunLockFullTurn = value;
    notifyListeners();
  }  

  late bool _shouldRunShowHintAnimation = false;
  bool get shouldRunShowHintAnimation => _shouldRunShowHintAnimation;
  void setShouldRunShowHintAnimation(bool value) {
    _shouldRunShowHintAnimation = value;
    notifyListeners();
  }     

  late bool _shouldRunHideHintAnimation = false;
  bool get shouldRunHideHintAnimation => _shouldRunHideHintAnimation;
  void setShouldRunHideHintAnimation(bool value) {
    _shouldRunHideHintAnimation = value;
    notifyListeners();
  }        

  late bool _shouldRunCoinAnimation = false;
  bool get shouldRunCoinAnimation => _shouldRunCoinAnimation;
  void setShouldRunCoinAnimation(bool value) {
    _shouldRunCoinAnimation = value;
    notifyListeners();
  }        

  late Map<dynamic,dynamic> _coinAnimationDetails = {};
  Map<dynamic,dynamic> get coinAnimationDetails => _coinAnimationDetails;
  void setCoinAnimationDetails(Map<dynamic,dynamic> value) {
    _coinAnimationDetails = value;
    notifyListeners();
  }    

  late List<Map<String,dynamic>> _sparksAnimationDetails = [];
  List<Map<String,dynamic>> get sparksAnimationDetails => _sparksAnimationDetails;
  void setSparksAnimationDetails(List<Map<String,dynamic>> value) {
    _sparksAnimationDetails = value;
    notifyListeners();
  }    


  late Map<dynamic,dynamic> _wordFoundWheelIndexes = {};
  Map<dynamic,dynamic> get wordFoundWheelIndexes => _wordFoundWheelIndexes;
  void setWordFoundWheelIndexes(Map<dynamic,dynamic> value) {
    _wordFoundWheelIndexes = value;
    notifyListeners();
  }    

  late int? _wordFoundClueIndex = null;
  int? get wordFoundClueIndex => _wordFoundClueIndex;
  void setWordFoundClueIndex(int? value) {
    _wordFoundClueIndex = value;
    notifyListeners();
  }


  late bool _shouldRunScoreboardScaleAnimation = false;
  bool get shouldRunScoreboardScaleAnimation => _shouldRunScoreboardScaleAnimation;
  void setShouldRunScoreboardScaleAnimation(bool value) {
    _shouldRunScoreboardScaleAnimation = value;
    notifyListeners();
  }   



  // late Map<String,dynamic> _clueTappedIds = {};
  // Map<String,dynamic> get clueTappedIds => _clueTappedIds;
  // void setClueTappedIds(Map<String,dynamic> value) {
  //   _clueTappedIds = value;
  //   notifyListeners();
  // }       
    

}