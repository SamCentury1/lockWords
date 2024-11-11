
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class GameCompletedDialog extends StatelessWidget {
  final ColorPalette palette;
  final Map<dynamic,dynamic> levelData;
  const GameCompletedDialog({
    super.key,
    required this.palette,
    required this.levelData
  });

  @override
  Widget build(BuildContext context) {

    final DateFormat formatter = DateFormat('MMM. dd, yyyy');
    final DateTime date = DateTime.parse(levelData["playedData"]["createdAt"]);
    final String formatted = formatter.format(date);
    final String completedTimeString = Helpers().formatTime(levelData["playedData"]["time"]);
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


              Divider(thickness: 0.5, color: Colors.grey.shade400,),

              Container(
                height: 100 * sizeFactor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.star, size: 22 * sizeFactor, color: palette.mainTextColor,),
                        SizedBox(width: 50 * sizeFactor, child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.0 * sizeFactor),
                          child: Divider(thickness: 1.0, color: palette.mainTextColor,),
                        ),),
                        Text(
                          "${levelData["playedData"]["score"].toString()} points",
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
                          completedTimeString,
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

              Text(
                "solved on ${formatted}",
                style: TextStyle(
                  fontSize: 18 * sizeFactor,
                  color: palette.mainTextColor
                )
              ),              
            ],
          )
        ),
      ),
    );
  }
}
