import 'package:flutter/material.dart';

class ClueSummaryUnderlinePainter extends CustomPainter { 
  const ClueSummaryUnderlinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = const Color.fromRGBO(28,28,30,1.0);

    Rect rect = const Offset(0.0,0.0) & size;
    RRect rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: Radius.circular(35.0),
      topRight: Radius.circular(35.0)
    );
    canvas.drawRRect(rrect, paint);
    
   }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}