import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';

class TrianglePainter extends CustomPainter {
  final bool isLeft;
  final ColorPalette palette;
  const TrianglePainter({
    required this.isLeft,
    required this.palette,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final double w = size.width;
    final double h = size.height;
    Paint paint = Paint();
    paint.color = palette.mainTextColor;

    Path trianglePath = Path();
    if (isLeft) {
      trianglePath.moveTo(w*0.1,h/2);
      trianglePath.lineTo(w*0.5, (h/2) - (w/4));
      trianglePath.lineTo(w*0.5, (h/2) + (w/4));
      trianglePath.close();    
    } else {
      trianglePath.moveTo(w*0.7,h/2);
      trianglePath.lineTo(w*0.3, (h/2) - (w/4));
      trianglePath.lineTo(w*0.3, (h/2) + (w/4));
      trianglePath.close();
    }
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
