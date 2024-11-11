import 'dart:math';

import 'package:flutter/material.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.pink,
          child: CustomPaint(
            painter: CoinPainter(coins: 23),
          ),
        )
      ),
    );
  }
}



class CoinPainter extends CustomPainter {
  final int coins;

  const CoinPainter({
    required this.coins,
  });
  @override
  void paint(Canvas canvas, Size size) {
    
    final double xOrigin = size.width/2;
    final double yOrigin = size.height/2;
    final double inc = size.width/3;

    // Paint bg = Paint();
    // bg.color = const Color.fromARGB(255, 211, 210, 208);    

    Paint paint = Paint();
    paint.color = const Color.fromARGB(255, 255, 198, 43);

    Paint blackPaint = Paint();
    blackPaint.color = const Color.fromARGB(255, 0, 0, 0);    
    blackPaint.style = PaintingStyle.stroke;
    blackPaint.strokeWidth = inc*0.05;

    Paint coinSidePaint = Paint();
    coinSidePaint.color = const Color.fromARGB(255, 194, 147, 18);
    coinSidePaint.style = PaintingStyle.fill;

    Rect rect = Rect.fromCenter(center: Offset(xOrigin,yOrigin), width: size.width, height: size.height);
    // canvas.drawRect(rect, bg);

    
    Rect arcRect2 = Rect.fromCenter(center: Offset(xOrigin +inc*0.2,yOrigin), width: inc, height: inc*2);
    
    // Rect arcRect2 = Rect.fromLTRB( xOrigin-inc, 0, xOrigin+(2*inc), size.height );
    // Rect arcRect3 = Rect


    final double startAngle2 = -900/(180*pi);
    final double sweepAngle2 = 1800 /(180*pi);
    // canvas.drawArc(arcRect2, startAngle2, sweepAngle2, false, coinSidePaint);

    final Path topPath = Path();
    topPath.moveTo(xOrigin, yOrigin-inc);
    topPath.lineTo(xOrigin+(inc*0.3), yOrigin-inc);
    canvas.drawPath(topPath, blackPaint);

    final Path bottomPath = Path();
    bottomPath.moveTo(xOrigin, yOrigin+inc);
    bottomPath.lineTo(xOrigin+(inc*0.3), yOrigin+inc);    

    canvas.drawPath(bottomPath, blackPaint);


    // final Path testPath = Path();
    // testPath.moveTo(xOrigin-inc*0.5, yOrigin-(inc*1));
    // testPath.lineTo(xOrigin, yOrigin-(inc*1));
    // // testPath.arcToPoint(Offset(xOrigin, yOrigin+inc),radius: Radius.circular(inc*0.5), rotation: 1800 /(180*pi), largeArc: false, clockwise: true);
    // // testPath.quadraticBezierTo(xOrigin+inc,yOrigin-inc , xOrigin+inc, yOrigin);
    // // testPath.quadraticBezierTo(xOrigin+inc, yOrigin+inc , xOrigin, yOrigin+inc);
    // testPath.lineTo(xOrigin, yOrigin+inc);
    // testPath.lineTo(xOrigin-inc*0.5, yOrigin+(inc*1));
    // // testPath.arcToPoint(Offset(xOrigin-inc*0.5, yOrigin-(inc*1)) ,radius: Radius.circular(inc*0.5), rotation: 1800 /(180*pi), largeArc: false, clockwise:true);
    // testPath.quadraticBezierTo(xOrigin-inc*0.5-inc, yOrigin, xOrigin-inc*0.5, yOrigin-inc);
    // canvas.drawPath(testPath, paint); 

    // Rect arcRect = Rect.fromCenter(center: Offset(xOrigin,yOrigin), width: inc, height: inc*2);
    // const double startAngle = 200/(180*pi);
    // const double sweepAngle = 3600 /(180*pi);
    // canvas.drawArc(arcRect, startAngle, sweepAngle, false, blackPaint);    
    canvas.drawCircle(Offset(xOrigin+(inc*0.3),yOrigin), inc, coinSidePaint);
    // canvas.drawCircle(Offset(xOrigin+(inc*0.3),yOrigin), inc, blackPaint);
    canvas.drawCircle(Offset(xOrigin,yOrigin), inc, paint);
    canvas.drawCircle(Offset(xOrigin,yOrigin), inc, blackPaint);

    // final Path testPath = Path();
    // testPath.moveTo(xOrigin, yOrigin-(inc*1));
    // testPath.lineTo(xOrigin+(inc*0.3),yOrigin-inc);
    // canvas.drawPath(testPath,blackPaint);


    const double startAngle3 = -900/(180*pi);
    const double sweepAngle3 = 1800 /(180*pi);
    // canvas.drawArc(arcRect2, startAngle2, sweepAngle2, false, coinSidePaint);
    Rect rightSideArc = Rect.fromCenter(center: Offset(xOrigin+inc*0.30, yOrigin),width: inc*2, height: inc*2 );
    canvas.drawArc(rightSideArc, startAngle3, sweepAngle3, false, blackPaint);


  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: inc*1,
  );
  TextSpan textSpan = TextSpan(
    text: coins.toString(),
    style: textStyle,
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(
    minWidth: 0,
    maxWidth: size.width,
  );
  final xCenter = (size.width - textPainter.width) / 2;
  final yCenter = (size.height - textPainter.height) / 2;
  final offset = Offset(xCenter, yCenter);
  textPainter.paint(canvas, offset);


  
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

