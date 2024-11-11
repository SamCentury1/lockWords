import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';
class NoAdsPainter extends CustomPainter {
  final ColorPalette palette;

  NoAdsPainter({required this.palette});
  @override
  void paint(Canvas canvas, Size size) {
    // Define colors
    final circleColor = Colors.red;
    final textColor = palette.mainTextColor.withOpacity(0.8); // Faded "ADS" text color

    // Draw "ADS" text in the background
    final textStyle = TextStyle(
      color: textColor,
      fontSize: size.width * 0.35,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: 'ADS',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, textOffset);

    // Draw the red circle ring
    final circlePaint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.4,
      circlePaint,
    );

    // Draw the diagonal red bar across the circle
    final barPaint = Paint()
      ..color = circleColor
      ..strokeWidth = size.width * 0.05
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.25),
      Offset(size.width * 0.75, size.height * 0.75),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(NoAdsPainter oldDelegate) {
    return false;
  }
}