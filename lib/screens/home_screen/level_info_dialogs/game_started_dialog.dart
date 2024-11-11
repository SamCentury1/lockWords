
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class GameStartedDialog extends StatelessWidget {
  final ColorPalette palette;
  final Map<dynamic,dynamic> levelData;
  final Function()? navigateToLevel; 
  const GameStartedDialog({
    super.key,
    required this.palette,
    required this.levelData,
    required this.navigateToLevel,
  });

  @override
  Widget build(BuildContext context) {

    // late int values = 0;
    late int cluesLength = 0;
    late int cluesCompleted = 0;
    late int points = levelData["playedData"]["score"];

    levelData["clues"].forEach((key,value){
      // values = values + value["value"] as int;
      cluesLength++;
    });

    cluesCompleted = cluesLength - levelData["playedData"]["cluesLeft"].length as int;


    final DateFormat formatter = DateFormat('MMM. dd, yyyy');
    final DateTime date = DateTime.parse(levelData["playedData"]["createdAt"]);
    final String formatted = formatter.format(date);
    final String timeString = Helpers().formatTime(levelData["playedData"]["time"]);

    final SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    final double sizeFactor = settingsState.screenSizeData["sizeFactor"];


        
    return Dialog(
      insetPadding: EdgeInsets.all(30.0 * sizeFactor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0 * sizeFactor))
      ),
      backgroundColor: palette.cryptexAreaColor,
      child: Padding(
        padding: EdgeInsets.all(18.0 * sizeFactor),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  levelData["level"],
                  style: TextStyle(
                    fontSize: 28 * sizeFactor,
                    color: palette.mainTextColor
                  ),
                ),
              ),
              Divider(thickness: 0.5, color: palette.mainTextColor,),

              Container(
                // height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.question_mark, size: 22, color: palette.mainTextColor,),
                        SizedBox(width: 50 * sizeFactor, child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0 * sizeFactor),
                          child: Divider(thickness: 1.0, color: palette.mainTextColor,),
                        ),),
                        Text(
                          "${cluesCompleted}/${cluesLength} clues completed",
                          style: TextStyle(
                            color: palette.mainTextColor,
                            fontSize: 22 * sizeFactor
                          ),
                        ),
                      ],
                    ),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.star, size: 22 * sizeFactor, color: palette.mainTextColor,),
                        SizedBox(width: 50 * sizeFactor, child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0 * sizeFactor),
                          child: Divider(thickness: 1.0, color: palette.mainTextColor,),
                        ),),
                        Text(
                          "$points points",
                          style: TextStyle(
                            color: palette.mainTextColor,
                            fontSize: 22 * sizeFactor
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.timer, size: 22 * sizeFactor, color: palette.mainTextColor,),
                        SizedBox(width: 50 * sizeFactor, child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0 * sizeFactor),
                          child: Divider(thickness: 1.0, color: palette.mainTextColor,),
                        ),),
                        Text(
                          timeString,
                          style: TextStyle(
                            color: palette.mainTextColor,
                            fontSize: 22 * sizeFactor
                          ),
                        ),
                      ],
                    ),                    
                  ],
                ),
              ),

              Divider(thickness: 0.5, color: palette.mainTextColor,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    // height: 30,r
                    child: Padding(
                      padding: EdgeInsets.all(2.0 * sizeFactor),
                      child: Text(
                        "started ${formatted}",
                        style: TextStyle(
                          color: palette.mainTextColor,
                          fontSize: 18 * sizeFactor
                        ),
                      ),
                    ),
                  ),
                                    
                  GestureDetector(
                    onTap: navigateToLevel,
                    child: Container(
                      width: 100 * sizeFactor,
                      height: 50 * sizeFactor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor)),
                        color: palette.clueCardFlippedColor,
                      ),
                      child: Center(
                        child: Text(
                          "Resume",
                          style: TextStyle(
                            color: palette.clueCardTextColor,
                            fontSize: 20 * sizeFactor
                          ),
                        ),
                      ),
                    
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}