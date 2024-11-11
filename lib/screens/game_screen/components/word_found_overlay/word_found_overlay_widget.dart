import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/screens/game_screen/components/word_found_overlay/word_found_overlay_painter.dart';
import 'package:provider/provider.dart';

class WordFoundOverlayWidget extends StatefulWidget {
  final AnimationController foundWordController;
  final Animation<double> foundWordOverlayAnimation;
  final Animation<double> foundWordProgressAnimation;
  final Animation<double> overlayWordGlowAnimation;
  const WordFoundOverlayWidget({
    super.key,
    required this.foundWordController,
    required this.foundWordOverlayAnimation,
    required this.foundWordProgressAnimation,
    required this.overlayWordGlowAnimation,
  });

  @override
  State<WordFoundOverlayWidget> createState() => _WordFoundOverlayWidgetState();
}

class _WordFoundOverlayWidgetState extends State<WordFoundOverlayWidget> {
  @override
  Widget build(BuildContext context) {
    // animationState.shouldRunWordFoundAnimation ?
    // final AnimationState animationState = Provider.of<AnimationState>(context, listen: false);
    return Positioned(
      top: 0,
      left: 0,
      child: Consumer<GamePlayState>(
        builder: (context,gamePlayState,child) {
          return Consumer<AnimationState>(
            builder: (context,animationState,child) {
              late double showOverlay = isOverlayShowing(animationState);
              return IgnorePointer(
                ignoring: showOverlay > 0 ? false : true,
                child: Opacity(
                  opacity: showOverlay,
                  child: AnimatedBuilder(
                    animation: widget.foundWordController ,
                    builder: (context,child) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY:2),
                          child: CustomPaint(
                            painter: WordFoundOverlayPainter(
                              overlayOpacity: widget.foundWordOverlayAnimation.value,
                              progress: widget.foundWordProgressAnimation.value,
                              sparks2: animationState.sparksAnimationDetails,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(widget.overlayWordGlowAnimation.value),
                                      fontSize: 36,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0 * widget.overlayWordGlowAnimation.value, 
                                          offset: Offset.zero, 
                                          color: Colors.white
                                        ),
                  
                                        Shadow(
                                          blurRadius: 25.0 * widget.overlayWordGlowAnimation.value, 
                                          offset: Offset.zero, 
                                          color: Colors.white
                                        ),                                      
                                      ]
                                    ), 
                                    textAlign: TextAlign.center,
                                    child: Text(
                                      // gamePlayState.words[animationState.wordFoundClueIndex]["word"] ?? "",
                                      getString(animationState, gamePlayState, "word")
                                      // "HELLO"
                                    )
                                  ),
                                  const SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 5.0 * widget.overlayWordGlowAnimation.value, 
                                            offset: Offset.zero, 
                                            color: Colors.white
                                          ),
                  
                                          Shadow(
                                            blurRadius: 15.0 * widget.overlayWordGlowAnimation.value, 
                                            offset: Offset.zero, 
                                            color: Colors.white
                                          ),                                      
                                        ]                                      
                                      ), 
                                      textAlign: TextAlign.center,
                                      child: Text(
                                        // "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla "
                                        // gamePlayState.words[animationState.wordFoundClueIndex]["clue"] ?? "",
                                        getString(animationState, gamePlayState, "clue")
                                      )
                                    ),
                                  ),                       
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}

double isOverlayShowing(AnimationState animationState) {
  late double res = 0.0;
  if (animationState.shouldRunWordFoundAnimation) {
    res = 1.0;
  } else {
    res = 0.0;
  }
  return res;
}

String getString(AnimationState animationState, GamePlayState gamePlayState, String item) {
  late String res = ""; 
  if (animationState.shouldRunWordFoundAnimation) {
    res = gamePlayState.words[animationState.wordFoundClueIndex][item];
  } else {
    res = "";
  }
  return res;
}