import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';

class CryptexLock extends CustomPainter {
  final ColorPalette palette;
  const CryptexLock({required this.palette});

  @override
  void paint(Canvas canvas, Size size) {

    final double w = size.width;
    final double h = size.height;
    Paint blackPaint = Paint();
    blackPaint.color = palette.cryptexAreaColor;

    Paint whitePaint = Paint();
    whitePaint.color = palette.mainTextColor;

    Path lockPath = Path();
    lockPath.moveTo(w/2,h*0.55);
    lockPath.lineTo((w/2)-5, h*0.42);
    lockPath.lineTo((w/2)+5, h*0.42);
    lockPath.close();



    

    canvas.drawCircle( Offset(w/2,h/2), w*0.4 , whitePaint);
    canvas.drawCircle( Offset(w/2,h/2), w*0.35 , blackPaint);
    canvas.drawCircle( Offset(w/2,h*0.55), w*0.1 , whitePaint);
    canvas.drawPath(lockPath, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}