import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';

class Background extends CustomPainter {
  final ColorPalette palette;
  const Background({required this.palette});

  @override
  void paint(Canvas canvas, Size size) {

    final double w = size.width;
    final double h = size.height;

    final double squareSize = w*0.1;
    
    Paint backgroundPaint = Paint();
    backgroundPaint.color = palette.screenBackgroundColor; //Color.fromRGBO(44, 44, 46, 1.0);

    Paint decorativeSquarePaint = Paint();
    decorativeSquarePaint.color = Colors.black.withOpacity(0.1);

    Rect bg = const Offset(0.0,0.0) & Size(w,h);

    Rect decorativeSquare = const Offset(24.0,100.0) & Size(squareSize,squareSize);

    RRect lol = RRect.fromRectXY(
      Rect.fromCenter(center: Offset(200,200), width: squareSize, height: squareSize),
      5.0,
      5.0,
    );
    
    canvas.drawRect(bg, backgroundPaint);
    canvas.drawRect(decorativeSquare, decorativeSquarePaint);
    canvas.drawRRect(lol, decorativeSquarePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


