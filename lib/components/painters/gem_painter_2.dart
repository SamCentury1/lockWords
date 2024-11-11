import 'dart:math';

import 'package:flutter/material.dart';

class GemPainter2  extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final double incremenet = size.width/10;
    final double xOrigin = size.width/2;
    final double yOrigin = size.height/2;
    final double starXOrigin = (size.width/2) + (2 * incremenet);
    final double starYOrigin = (size.height/2) - (1 * incremenet);

    Paint paint1 = Paint();
    paint1.color = const Color.fromARGB(255, 39, 59, 238);
    Paint paint2 = Paint();
    paint2.color = const Color.fromARGB(255, 11, 33, 233);
    Paint paint3 = Paint();
    paint3.color = const Color.fromARGB(255, 42, 59, 211);
    Paint paint4 = Paint();
    paint4.color = const Color.fromARGB(255, 49, 60, 156);
    Paint paint5 = Paint();
    paint5.color = const Color.fromARGB(255, 84, 98, 228);
    Paint paint6 = Paint();
    paint6.color = const Color.fromARGB(255, 100, 166, 228);
    Paint paint7 = Paint();
    paint7.color = const Color.fromARGB(255, 107, 176, 223);
    Paint paint8 = Paint();
    paint8.color = const Color.fromARGB(255, 150, 192, 240);        
    List<Paint> paints = [paint1, paint2, paint3, paint4, paint5,paint6,paint7,paint8];

    Paint whitePaint = Paint();
    whitePaint.color = Colors.white;    

    // .lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (0.0 * incremenet));

    Path bottomTriangle1 = Path();
    bottomTriangle1.moveTo(xOrigin + (0.0 * incremenet) , yOrigin + (4.0 * incremenet));
    bottomTriangle1.lineTo(xOrigin - (5.0 * incremenet) , yOrigin - (1.0 * incremenet));
    bottomTriangle1.lineTo(xOrigin - (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    bottomTriangle1.close();
    // bottomTriangle1.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (0.0 * incremenet));    

    Path bottomTriangle2 = Path();
    bottomTriangle2.moveTo(xOrigin + (0.0 * incremenet) , yOrigin + (4.0 * incremenet));
    bottomTriangle2.lineTo(xOrigin - (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    bottomTriangle2.lineTo(xOrigin + (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    bottomTriangle2.close();
    // bottomTriangle2.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (0.0 * incremenet));        
    
    Path bottomTriangle3 = Path();
    bottomTriangle3.moveTo(xOrigin - (0.0 * incremenet) , yOrigin + (4.0 * incremenet));
    bottomTriangle3.lineTo(xOrigin + (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    bottomTriangle3.lineTo(xOrigin + (5.0 * incremenet) , yOrigin - (1.0 * incremenet));
    bottomTriangle3.close();
    // bottomTriangle3.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (0.0 * incremenet));  

    Path triangleUp1 = Path();
    triangleUp1.moveTo(xOrigin - (3.5 * incremenet) , yOrigin - (4.0 * incremenet));
    triangleUp1.lineTo(xOrigin - (5.0 * incremenet) , yOrigin - (1.0 * incremenet));
    triangleUp1.lineTo(xOrigin - (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    bottomTriangle3.close(); // triangleUp1.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (0.0 * incremenet));    
    

    Path triangleDown1 = Path();
    triangleDown1.moveTo(xOrigin - (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    triangleDown1.lineTo(xOrigin - (3.5 * incremenet) , yOrigin - (4.0 * incremenet));
    triangleDown1.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (4.0 * incremenet));
    bottomTriangle3.close(); // triangleDown1.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (0.0 * incremenet));
    

    Path triangleUp2 = Path();
    triangleUp2.moveTo(xOrigin + (0.0 * incremenet) , yOrigin - (4.0 * incremenet));
    triangleUp2.lineTo(xOrigin - (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    triangleUp2.lineTo(xOrigin + (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    bottomTriangle3.close(); // triangleUp2.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (0.0 * incremenet));
    

    Path triangleDown2 = Path();
    triangleDown2.moveTo(xOrigin + (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    triangleDown2.lineTo(xOrigin + (3.5 * incremenet) , yOrigin - (4.0 * incremenet));
    triangleDown2.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (4.0 * incremenet));
    bottomTriangle3.close(); // triangleDown2.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (0.0 * incremenet));
    

    Path triangleUp3 = Path();
    triangleUp3.moveTo(xOrigin + (3.5 * incremenet) , yOrigin - (4.0 * incremenet));
    triangleUp3.lineTo(xOrigin + (5.0 * incremenet) , yOrigin - (1.0 * incremenet));
    triangleUp3.lineTo(xOrigin + (2.0 * incremenet) , yOrigin - (1.0 * incremenet));
    bottomTriangle3.close(); // triangleUp3.lineTo(xOrigin + (0.0 * incremenet) , yOrigin - (0.0 * incremenet));
    


    Path starPath = getStarPath(starXOrigin,starYOrigin,(incremenet*2));

    canvas.drawPath(bottomTriangle1, paints[0]);
    canvas.drawPath(bottomTriangle2, paints[1]);
    canvas.drawPath(bottomTriangle3, paints[2]);
    canvas.drawPath(triangleUp1, paints[3]);
    canvas.drawPath(triangleDown1, paints[4]);
    canvas.drawPath(triangleUp2, paints[5]);
    canvas.drawPath(triangleDown2, paints[6]);
    canvas.drawPath(triangleUp3, paints[7]);
    canvas.drawPath(starPath,whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Path getStarPath(double x, double y, double inc) {
  Path starPath = Path();
  starPath.moveTo(x + (0.0 * inc) , y - (1.0 * inc));
  starPath.lineTo(x - (0.1 * inc) , y - (0.1 * inc));
  starPath.lineTo(x - (1.0 * inc) , y + (0.0 * inc));
  starPath.lineTo(x - (0.1 * inc) , y + (0.1 * inc));
  starPath.lineTo(x + (0.0 * inc) , y + (1.0 * inc));
  starPath.lineTo(x + (0.1 * inc) , y + (0.1 * inc));
  starPath.lineTo(x + (1.0 * inc) , y + (0.0 * inc));
  starPath.lineTo(x + (0.1 * inc) , y - (0.1 * inc));
  starPath.close();
  return starPath;
}