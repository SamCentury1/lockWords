import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class GameNotStartedDialog extends StatelessWidget {
  final ColorPalette palette;
  final Map<dynamic,dynamic> levelData;
  final Function()? navigateToLevel; 
  const GameNotStartedDialog({
    super.key,
    required this.palette,
    required this.levelData,
    required this.navigateToLevel,
  });

  @override
  Widget build(BuildContext context) {

    late int values = 0;
    late int cluesLength = 0;

    levelData["clues"].forEach((key,value){
      values = values + value["value"] as int;
      cluesLength++;
    });

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
                height: 100 * sizeFactor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.question_mark, size: 22 * sizeFactor, color: palette.mainTextColor,),
                        SizedBox(width: 50 * sizeFactor, child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0 * sizeFactor),
                          child: Divider(thickness: 1.0, color: palette.mainTextColor,),
                        ),),
                        Text(
                          "$cluesLength clues",
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
                          "$values points available",
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                          "Play",
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