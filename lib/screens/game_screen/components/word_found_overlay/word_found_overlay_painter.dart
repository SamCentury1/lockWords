import 'package:flutter/material.dart';

class WordFoundOverlayPainter extends CustomPainter {
  final double overlayOpacity;
  final double progress;
  final List<Map<String,dynamic>> sparks2; 

  const WordFoundOverlayPainter({
    required this.overlayOpacity,
    required this.progress,
    required this.sparks2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Color.fromRGBO(25, 25, 26, (0.655 * overlayOpacity));
    Rect rect = const Offset(0.0,0.0) & size;
    Paint whitePaint = Paint();
    whitePaint.color = Colors.white;
    canvas.drawRect(rect, paint);    


    for (int i=0; i<sparks2.length; i++) {
      Map<String,dynamic> spark = sparks2[i];
      double dx = spark["path"][progress.round()].dx;
      double dy = spark["path"][progress.round()].dy;
      double size = spark["size"];
      double sizeFactor = spark["opacity"][progress.round()];
      whitePaint.strokeWidth = size*sizeFactor;

      Path path = Path();
      path.moveTo(dx, dy-3);
      path.lineTo(dx+3, dy);
      path.lineTo(dx, dy+3);
      path.lineTo(dx-3, dy);
      path.close();
   
      canvas.drawCircle(Offset(dx,dy), size*sizeFactor, whitePaint);
      canvas.drawShadow(path, Colors.white, size*sizeFactor*3, false);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
