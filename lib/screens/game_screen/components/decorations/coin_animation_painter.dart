import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';

class CoinAnimationPainter extends CustomPainter {
  final Map<dynamic,dynamic> coinAnimationDetails;
  final double animationProgress;
  final ColorPalette palette;
  const CoinAnimationPainter({
    required this.coinAnimationDetails,
    required this.animationProgress,
    required this.palette
  });

  @override
  void paint(Canvas canvas, Size size) {

    final double w = size.width;
    final double h = size.height;

    // Paint whitePaint = Paint();
    // whitePaint.color = palette.mainTextColor;    

    double dx = (w/2)+coinAnimationDetails["path"]["dx"][animationProgress.round()];
    double dy = (h/2)+coinAnimationDetails["path"]["dy"][animationProgress.round()];

    double progress = coinAnimationDetails["path"]["visibility"][animationProgress.round()];
    Color color = palette.mainTextColor.withOpacity(progress); 
    TextStyle textStyle = TextStyle(
      color: color,
      fontSize: 32,
      shadows: [
        Shadow(blurRadius: 30, offset: Offset.zero, color: palette.glowColor)
      ]
    );
    TextSpan textSpan = TextSpan(
      text: "${coinAnimationDetails["sign"]}1",
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
    
    final offset = Offset(dx, dy);
    textPainter.paint(canvas, offset);       
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


