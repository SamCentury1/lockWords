import 'package:flutter/material.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/game_screen/components/app_bar/coin.dart';
import 'package:lock_words/screens/home_screen/level_info_dialogs/level_info_dialog.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LevelButton extends StatefulWidget {
  final int index;
  final Map<dynamic,dynamic> levelData;
  // final GamePlayState gamePlayState;
  // final SettingsState settingsState;
  const LevelButton({
    super.key,
    required this.index,
    required this.levelData
    // required this.gamePlayState,
    // required this.settingsState
  });

  @override
  State<LevelButton> createState() => _LevelButtonState();
}

class _LevelButtonState extends State<LevelButton> with TickerProviderStateMixin{

  late bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    late ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);

    // late Color clueCardColor = widget.levelData["playedData"].isNotEmpty ? palette.clueCardColor : palette.clueCardFlippedColor;
    late Color buttonColor = getButtonColor(palette,widget.levelData["playedData"]);

    // widget.levelData.forEach((key,value) {
    //   if (key == "levelData") {
    //     print(value);
    //   }
    // });


    return Consumer<GamePlayState>(
      builder: (context,gamePlayState,child) {
        return Consumer<SettingsState>(
          builder: (context,settingsState,child) {

            double sizeFactor = settingsState.screenSizeData["sizeFactor"];      
            double width = settingsState.screenSizeData["width"];
            double buttonTileSize = (width/6) * sizeFactor;
            return GestureDetector(
              onTapDown: (details) {
                setState(() {
                  isPressed = true;
                });
              },

              onTapUp: (details) {
                setState(() {
                  isPressed = false;
                });  
                _openLevelDialog(context, widget.index, widget.levelData);
              },
              onTapCancel: () {
                setState(() {
                  isPressed = false;
                });                 
              },
              child: Container(
                width: buttonTileSize,
                height: buttonTileSize,
                // color: Colors.black,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: isPressed ? buttonTileSize*0.65 : buttonTileSize*0.8,
                    height: isPressed ? buttonTileSize*0.65 : buttonTileSize*0.8,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                    ),
                    child: Center(


                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 100),
                        child: Text((widget.index+1).toString(),),
                        style: TextStyle(
                          fontSize: isPressed ? (20 * sizeFactor) : (22 * sizeFactor),
                          color: palette.clueCardTextColor
                        ),
                      ),

                    ),
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}


// AlertDialog alertDialog() {
//   return AlertDialog(
//     title: Text("level completed"),
//     content: Text("you have completed this level"),
//   );
// }

Color getButtonColor(ColorPalette palette, Map<dynamic,dynamic> playedData) {
  late Color res = Colors.transparent;
  if (playedData.isNotEmpty) {
    if (playedData["completed"]) {
      res = palette.clueCardColor;
    } else {
      res = Colors.blue;
    }
  } else {
    res = palette.clueCardFlippedColor;
  }
  return res;
}

Future<void> _openLevelDialog(BuildContext context, int index, Map<dynamic,dynamic> levelData) {
  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return LevelInfoDialog(index: index, levelData:levelData);
    }
  );
}