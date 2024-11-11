import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';

class CryptexArea extends CustomPainter {
  final ColorPalette palette;
  const CryptexArea({required this.palette});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = palette.cryptexAreaColor;

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