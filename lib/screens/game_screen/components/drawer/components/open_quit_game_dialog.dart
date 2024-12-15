import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/resources/firestore_methods.dart';
import 'package:lock_words/screens/auth_screen/auth_screen.dart';
import 'package:provider/provider.dart';

Future<void> openQuitGameDialog(BuildContext context, ColorPalette palette, double sizeFactor, SettingsState settingsState) {
  return showDialog(
    context: context, 
    builder: (BuildContext context) {

      return Consumer<GamePlayState>(
        builder: (context,gamePlayState,child) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor)),
                color: palette.cryptexAreaColor
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0 * sizeFactor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Quit Game",
                      style: TextStyle(
                        color: palette.mainTextColor,
                        fontSize: 32 * sizeFactor,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0 * sizeFactor),
                      child: Divider(thickness: 1.0, color: palette.mainTextColor,),
                    ),              
                    Text(
                      "Are you sure you would like to quit game?",
                      style: TextStyle(
                        color: palette.mainTextColor,
                        fontSize: 24 * sizeFactor,
                        fontWeight: FontWeight.w300
                      ),
                    ),
          
                    SizedBox(height: 20 * sizeFactor,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pop();
                          },
                          
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor)),
                              color: palette.clueCardFlippedColor
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                12.0 * sizeFactor, 
                                4.0 * sizeFactor, 
                                12.0 * sizeFactor, 
                                4.0 * sizeFactor
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: palette.mainTextColor,
                                  fontSize: 22 * sizeFactor,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            ),
                          ),
                        ), 
          
                        SizedBox(width: 10 * sizeFactor,),
                
                        GestureDetector(
                          onTap: () {
                            print("save game");

                            List<Map<String,dynamic>> cluesLeft = getCluesLeftData(gamePlayState);
          
                            final Map<String,dynamic> gameData = {
                              "level" : gamePlayState.level, 
                              "time": gamePlayState.duration.inSeconds,
                              "createdAt": DateTime.now().toIso8601String(),
                              "score": gamePlayState.score,
                              "endingBalance": gamePlayState.coins,
                              "cluesLeft": cluesLeft,
                            };
                            gamePlayState.setGameData(gameData);

                            FirestoreMethods().saveGame(settingsState,gamePlayState);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const AuthScreen())
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor)),
                              color: palette.clueCardColor
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                12.0  * sizeFactor, 
                                4.0  * sizeFactor, 
                                12.0  * sizeFactor, 
                                4.0 * sizeFactor
                              ),
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: palette.mainTextColor,
                                  fontSize: 22 * sizeFactor,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            ),
                          ),
                        ),                  
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      );
    }
  );
}


List<Map<String,dynamic>> getCluesLeftData(GamePlayState gamePlayState) {
  List<Map<String,dynamic>> res = []; 

  gamePlayState.words.forEach((key,value) {
    if (value["active"]) {
      res.add({"word": value["word"], "hints": value["hints"]});
    }
  });

  return res;
}