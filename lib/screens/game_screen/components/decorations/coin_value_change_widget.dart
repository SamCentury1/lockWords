import 'package:flutter/material.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/game_screen/components/decorations/coin_animation_painter.dart';
import 'package:provider/provider.dart';

class CoinValueChangeWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation<double> animationProgress;
  const CoinValueChangeWidget({
    super.key,
    required this.animationController,
    required this.animationProgress,
  });

  @override
  State<CoinValueChangeWidget> createState() => _CoinValueChangeWidgetState();
}

class _CoinValueChangeWidgetState extends State<CoinValueChangeWidget> {
  @override
  Widget build(BuildContext context) {
    final SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    final ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);
    return Consumer<AnimationState>(
      builder: (context,animationState,child) {
        return Positioned(
          top: 50,
          left: (settingsState.screenSizeData["width"]-150)/2,          
          child: IgnorePointer(
            ignoring: true,
            child: Opacity(
              opacity: getOverlayVisibility(animationState),
              child: AnimatedBuilder(
                animation: widget.animationController,
                builder: (context,child) {
                  return SizedBox(
                    width: 150,
                    height: 150,
                    child: CustomPaint(
                      painter: CoinAnimationPainter(
                        coinAnimationDetails: animationState.coinAnimationDetails,
                        animationProgress: widget.animationProgress.value,
                        palette: palette
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        );
      }
    );
  }
}


double getOverlayVisibility(AnimationState animationState) {
  late double res = 0.0;
  if (animationState.shouldRunCoinAnimation) {
    res = 1.0;
  } else {
    res = 0.0;
  }
  return res;
}