import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class HintAnimationWidget extends StatefulWidget {
  final int index;
  final AnimationController flipController;
  final Map<String,Animation> flipAnimations;  
  const HintAnimationWidget({
    super.key,
    required this.index,
    required this.flipController,
    required this.flipAnimations,    
  });

  @override
  State<HintAnimationWidget> createState() => _HintAnimationWidgetState();
}

class _HintAnimationWidgetState extends State<HintAnimationWidget> {
  late String hint = "";
  
  @override
  Widget build(BuildContext context) {
    final ColorPalette palette = Provider.of<ColorPalette>(context,listen: false);
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen:false);
    final double sizeFactor = settingsState.screenSizeData["sizeFactor"];

    return Consumer<GamePlayState>(
      builder: (context,gamePlayState,child) {
        Map<dynamic,dynamic> clueData = gamePlayState.words[widget.index];
        double ts = gamePlayState.tileSize;

        hint = Helpers().getClueWordHint(gamePlayState,widget.index);
        return AnimatedBuilder(
          animation: widget.flipController,
          builder: (context,child) {
            // double progress = widget.flipAnimations["progress"]!.value;

            double inVisibility = widget.flipAnimations["inVisibility"]!.value;
            double outVisibility = widget.flipAnimations["outVisibility"]!.value;
            double angle = widget.flipAnimations["angle"]!.value;            
            return Opacity(
              opacity: clueData["active"] ? 1.0 : 0.3,
              child: Padding(
                padding: EdgeInsets.all(6.0 * sizeFactor),
                child: Stack(
                  children:[
                    Transform(
                      transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      // ..rotateX((widget.flipAnimations["angle"]!.value/180.0*pi)),
                      ..rotateX(((angle)/180.0*pi)),
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor))
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.0  * sizeFactor),
                          child: Container(
                            decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //   begin: Alignment.bottomRight,
                              //   end: Alignment.topRight,
                              //   colors: [Colors.green,const Color.fromARGB(255, 59, 145, 61)],
                              //   stops: const [0.5, 0.9]
                              // ),
                              color: palette.clueCardColor.withOpacity(outVisibility),
                              borderRadius: BorderRadius.all(Radius.circular(gamePlayState.tileSize*0.1 * sizeFactor))
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0 * sizeFactor),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      clueData["clue"],
                                      style: TextStyle(
                                        fontSize: ts*0.32 * sizeFactor,
                                        decoration: clueData["active"] ? TextDecoration.none : TextDecoration.lineThrough,
                                        // color: clueData["active"] ? Colors.black : Color.fromARGB(122, 58, 58, 58) 
                                        color:  palette.clueCardTextColor.withOpacity(outVisibility)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              
              
                    Positioned(
                      bottom: 0,
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Transform(
                        transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        // ..rotateX((widget.flipAnimations["angle"]!.value/180.0*pi)),
                        ..rotateX((angle/180.0*pi)),
                        alignment: Alignment.center,
                        child: Transform(
                          transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX((180/180.0*pi)),
                          alignment: Alignment.center,
                          child: Container(
                            // color: Color.fromRGBO(76, 175, 79, 0.99 * flipVisibilityAnimation.value ),
                            decoration: BoxDecoration(
                              color: palette.clueCardFlippedColor.withOpacity(inVisibility),
                              borderRadius: BorderRadius.all(Radius.circular(gamePlayState.tileSize*0.1 * sizeFactor)),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                hint,
                                // "CACA",
                                style: TextStyle(
                                  fontSize: ts*0.32 * sizeFactor,
                                  // color: Colors.white.withOpacity(flipVisibilityAnimation.value),
                                  color: palette.clueCardTextColor.withOpacity(inVisibility),
                                  letterSpacing: 10.0 * sizeFactor
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    )
                  ] 
                ),
              ),
            );
          }
        );
      }
    );
  }
}

