import 'package:flutter/material.dart';

class ClapperBoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boardPaint = Paint()..color = Colors.black;
    final clapPaint = Paint()..color = Colors.grey.shade300;
    final stripePaint = Paint()..color = Colors.black;

    final double boardHeight = size.height * 0.8;
    final double clapHeight = size.height * 0.2;

    // Draw the lower board part (main board)
    canvas.drawRect(
      Rect.fromLTWH(0, clapHeight, size.width, boardHeight),
      boardPaint,
    );

    // Draw the play button on the main board
    final playPath = Path();
    playPath.moveTo(size.width * 0.4, clapHeight + boardHeight * 0.3);
    playPath.lineTo(size.width * 0.6, clapHeight + boardHeight * 0.5);
    playPath.lineTo(size.width * 0.4, clapHeight + boardHeight * 0.7);
    playPath.close();
    canvas.drawPath(playPath, Paint()..color = Colors.white);

    // Draw the top clapper part
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, clapHeight),
      clapPaint,
    );

    // Draw diagonal stripes on the clapper part
    final double stripeWidth = size.width / 6;
    for (int i = 0; i < 6; i++) {
      canvas.drawRect(
        Rect.fromLTWH(i * stripeWidth, 0, stripeWidth / 2, clapHeight),
        i % 2 == 0 ? stripePaint : clapPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}