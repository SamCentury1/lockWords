import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lock_words/functions/game_logic.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/auth_screen/auth_screen.dart';
import 'package:lock_words/screens/game_screen/game_screen.dart';
import 'package:lock_words/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class GameSummaryOverlayWidget extends StatefulWidget {
  const GameSummaryOverlayWidget({super.key});

  @override
  State<GameSummaryOverlayWidget> createState() => _GameSummaryOverlayWidgetState();
}

class _GameSummaryOverlayWidgetState extends State<GameSummaryOverlayWidget> with SingleTickerProviderStateMixin{

  // late bool buttonPressed1 = false;
  // late bool buttonPressed2 = false;
  // late AnimationController buttonPressController;
  // late Animation<double> buttonPressAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // buttonPressController = AnimationController(
    //   duration: const Duration(milliseconds: 500),
    //   vsync: this,
    // );

    // List<TweenSequenceItem<double>> buttonPressAnimationSequence = [
    //   TweenSequenceItem(tween: Tween(begin: 0.00, end: 0.60,), weight: 20),
    //   TweenSequenceItem(tween: Tween(begin: 0.60, end: 0.00,), weight: 20),
    //   TweenSequenceItem(tween: Tween(begin: 0.00, end: 0.00,), weight: 20),
    //   TweenSequenceItem(tween: Tween(begin: 0.00, end: 1.00,), weight: 20),
    //   TweenSequenceItem(tween: Tween(begin: 1.00, end: 0.00,), weight: 20),
    // ];
    // buttonPressAnimation  = TweenSequence<double>(buttonPressAnimationSequence).animate(buttonPressController); 
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // buttonPressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Consumer<GamePlayState>(
        builder: (context, gamePlayState, child) {
          if (gamePlayState.isGameOver) {
          // if (true) {
            
            final SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
            final ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);
            final double screenWidth = settingsState.screenSizeData["width"];
            final double buttonWidth = settingsState.screenSizeData["width"]*0.6;
            final Map<String,dynamic> gameData = gamePlayState.gameData;
            final String completedTimeString = Helpers().formatTime(gameData["time"]);
            final int score = gameData["score"];
            // final Strinformatted

            late double showOverlay = 1.0;
            return Opacity(
              opacity: showOverlay,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY:5),
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultTextStyle(
                              style: getTextStyleBig(),
                              textAlign: TextAlign.center,
                              child: Text("Great Work!"),
                            ),
                            SizedBox(height: 20,),
                            DefaultTextStyle(
                              style: getTextStyleMedium(),
                              textAlign: TextAlign.center,
                              child: Text("You solved the Cryptex"),
                            ),
                            SizedBox(
                              width: settingsState.screenSizeData["width"]*0.66, 
                              height: 50, 
                              child: Divider(thickness: 0.77, color: palette.overlayTextColor,),
                            ),
                            
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: settingsState.screenSizeData["width"]*0.66,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star, size: 28, color: palette.overlayTextColor),
                                    SizedBox(width: 20,),
                                    DefaultTextStyle(
                                      style: getTextStyleMedium(),
                                      textAlign: TextAlign.center,
                                      child: Text("$score points"),
                                    ),                                
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: settingsState.screenSizeData["width"]*0.66,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.timer, size: 28, color: palette.overlayTextColor),
                                      SizedBox(width: 20,),
                                      DefaultTextStyle(
                                        style: getTextStyleMedium(),
                                        textAlign: TextAlign.center,
                                        child: Text(completedTimeString),
                                      ),                                
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: settingsState.screenSizeData["width"]*0.66, 
                              height: 50, 
                              child: Divider(thickness: 0.77, color: palette.overlayTextColor,),
                            ),

                            GestureDetector(
                              onTap: () {
                                gamePlayState.setIsGameOver(false);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const AuthScreen())
                                );                                
                              },                          
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                
                                width: buttonWidth,
                                decoration: BoxDecoration(
                                  color: palette.clueCardFlippedColor ,
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.home, size: 24, color: palette.clueCardTextColor,),
                                      SizedBox(width: 15,),
                                      DefaultTextStyle(
                                        style: getButtonTextStyle(palette),
                                        child: Text("Main Menu")
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),

                            GestureDetector(
                              onTap: () {
                                  String nextLevel = Helpers().getNextLevel(settingsState,gamePlayState);
                                  Helpers().navigateToLevel(nextLevel,context,settingsState,gamePlayState);                                
                              },
                          
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: buttonWidth,
                                decoration: BoxDecoration(
                                  color: palette.clueCardFlippedColor ,
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.trending_up, size: 24, color: palette.clueCardTextColor,),
                                      SizedBox(width: 15,),
                                      DefaultTextStyle(
                                        style: getButtonTextStyle(palette),
                                        child: Text("Next Level")
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                  ),
                )
              ),
            );
          } else {
            return const SizedBox();
          }
        } 
      ),
    );
  }
}

TextStyle getTextStyleBig() {
  return TextStyle(
    color: Colors.white,
    fontSize: 32,
  );
}


TextStyle getTextStyleMedium() {
  return TextStyle(
    color: Colors.white,
    fontSize: 24,
  );  
}

TextStyle getButtonTextStyle(ColorPalette palette) {
  return TextStyle(
    color: palette.clueCardTextColor,
    fontSize: 24
  );
}
