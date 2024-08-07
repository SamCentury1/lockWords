import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lock_words/providers/game_play_state.dart';

class Helpers {
  double getDistanceY(GamePlayState gamePlayState) {
    List<Offset> dragPath = gamePlayState.dragPath;
    double current = 0.0;
    double origin = 0.0;      
    if (dragPath.isNotEmpty) {
      origin = dragPath[0].dy;
      current = gamePlayState.dragPath[gamePlayState.dragPath.length-1].dy;
    }
    double distance = (current-origin);    
    return distance;
  }

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

  bool getIsTarget(GamePlayState gamePlayState, int index) {
    bool res = false; 
    if (gamePlayState.dragStartWheelId != null && gamePlayState.dragStartWheelId == index) {
      res = true;
    }
    return res;
  }

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

}