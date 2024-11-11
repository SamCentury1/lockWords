import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lock_words/audio/audio_controller.dart';
import 'package:lock_words/functions/game_logic.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/game_screen/components/cryptex/clue_summary_widget.dart';
import 'package:lock_words/screens/game_screen/components/cryptex/cryptex_lock_painter.dart';
import 'package:lock_words/screens/game_screen/components/cryptex/cryptex_painter.dart';
import 'package:lock_words/screens/game_screen/components/cryptex/cryptex_triangle_painter.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CryptexWidget extends StatefulWidget {
  final ItemScrollController itemScrollController;
  final AnimationController foundWordController;
  final AnimationController quarterTurnController;
  final Animation<double> quarterTurnAnimation;
  final Animation<double> fullTurnAnimation;
  const CryptexWidget({
    super.key,
    required this.itemScrollController,
    required this.foundWordController,
    required this.quarterTurnController,
    required this.quarterTurnAnimation,
    required this.fullTurnAnimation,
  });

  @override
  State<CryptexWidget> createState() => _CryptexWidgetState();
}

class _CryptexWidgetState extends State<CryptexWidget> {
  @override
  Widget build(BuildContext context) {

    final SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    final double cryptexAreaHeight = settingsState.screenSizeData['cryptexHeight'];
    final double cryptexAreaWidth = settingsState.screenSizeData['width'];
    final double cryptexExtraWidgetWidth = settingsState.screenSizeData["cryptexExtraWidgetWidth"];
    final double cryptexTileAreaWidth = settingsState.screenSizeData["cryptexTileAreaWidth"];
    final double cryptexHeight = cryptexAreaHeight * 0.8;
    final double clueSummaryHeight = cryptexAreaHeight * 0.2;

    // final AnimationState animationState = Provider.of<AnimationState>(context, listen: false);
    final ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);
    final AudioController audioController = Provider.of<AudioController>(context, listen: false);

    return Consumer<GamePlayState>(
      builder: (context,gamePlayState,child) {
        return Consumer<AnimationState>(
          builder: (context,animationState,child) {


            return Positioned(
              bottom: 0.0,
              child: Container(
                width: cryptexAreaWidth,
                height: cryptexAreaHeight,
              
                child: CustomPaint(
                  painter: CryptexArea(palette: palette),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: cryptexHeight,
                        child: AnimatedBuilder(
                          animation: Listenable.merge([widget.quarterTurnController,widget.foundWordController]),
                          builder: (context,child) {
                            late double angle = getAngle(animationState, widget.quarterTurnAnimation, widget.fullTurnAnimation);
                            if (gamePlayState.isLockOnLeft) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: cryptexExtraWidgetWidth,
                                    height: cryptexHeight,
                                    child: GestureDetector(
                                      onTap: () {
                                        GameLogic().validateGuess(context, gamePlayState,widget.itemScrollController,animationState,audioController,settingsState);                  
                                        // gamePlayState.setSwipedWheelId(null);
                                      },
                                      child: SizedBox(
                                        width: cryptexExtraWidgetWidth, //MediaQuery.of(context).size.width * 0.15,
                                        height: cryptexExtraWidgetWidth, //MediaQuery.of(context).size.width * 0.15,

                                        child: Transform.rotate(
                                          angle: angle, // getAngle(animationState,quarterTurnAnimation,fullTurnAnimation),
                                          child: CustomPaint(
                                            painter: CryptexLock(palette: palette),
                                          ),
                                        ),
                                      ),
                                    )
                                  ),

                                  SizedBox(
                                    width: cryptexTileAreaWidth,
                                    height: cryptexHeight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: Helpers().getCryptexWheel(gamePlayState),
                                    ),
                                  ),

                                  SizedBox(
                                    width: cryptexExtraWidgetWidth,
                                    height: cryptexHeight,
                                    // color: Colors.purple,
                                    child: CustomPaint(
                                      painter: TrianglePainter(isLeft: gamePlayState.isLockOnLeft, palette: palette),
                                    )
                                  ),                                
                                ],
                              );
                            } else {
                              return Row(
                                children: [

                                  SizedBox(
                                    width: cryptexExtraWidgetWidth,
                                    height: cryptexHeight,
                                    // color: Colors.purple,
                                    child: CustomPaint(
                                      painter: TrianglePainter(isLeft: gamePlayState.isLockOnLeft, palette: palette),
                                    )
                                  ),

                                  SizedBox(
                                    width: cryptexTileAreaWidth,
                                    height: cryptexHeight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: Helpers().getCryptexWheel(gamePlayState),
                                    ),
                                  ),

                                  SizedBox(
                                    width: cryptexExtraWidgetWidth,
                                    height: cryptexHeight,
                                    child: GestureDetector(
                                      onTap: () {
                                        GameLogic().validateGuess(context, gamePlayState,widget.itemScrollController,animationState,audioController,settingsState);                  
                                        // gamePlayState.setSwipedWheelId(null);
                                      },
                                      child: SizedBox(
                                        width: cryptexExtraWidgetWidth, //MediaQuery.of(context).size.width * 0.15,
                                        height: cryptexExtraWidgetWidth, //MediaQuery.of(context).size.width * 0.15,

                                        child: Transform.rotate(
                                          angle: angle, // getAngle(animationState,quarterTurnAnimation,fullTurnAnimation),
                                          child: CustomPaint(
                                            painter: CryptexLock(palette: palette),
                                          ),
                                        ),
                                      ),
                                    )
                                  ),                                  
                                ],
                              );                              
                            }
                          }
                        ),
                      ),
            
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: clueSummaryHeight,
                        child: ClueSummaryWidget(),
                      ),                            
                    ],
                  )
                ),
              ),
            );
          }
        );  
      }
    );
  }
}

double getAngle(AnimationState animationState, Animation<double> quarterTurn, Animation<double> fullTurn) {
  late double res = 0.0;
  if (animationState.shouldRunLockQuarterTurn) {
    res = quarterTurn.value;
  } else if (animationState.shouldRunWordFoundAnimation) {
    res = fullTurn.value;
  } else {
    res = 0.0;
  }

  return (pi / 180.0) * res;
}