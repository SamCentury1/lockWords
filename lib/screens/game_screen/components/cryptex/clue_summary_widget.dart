import 'package:flutter/material.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class ClueSummaryWidget extends StatefulWidget {
  const ClueSummaryWidget({super.key});

  @override
  State<ClueSummaryWidget> createState() => _ClueSummaryWidgetState();
}

class _ClueSummaryWidgetState extends State<ClueSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    SettingsState settingsState = Provider.of<SettingsState>(context, listen: false); 
    final ColorPalette palette = Provider.of<ColorPalette>(context, listen: false); 
    double areaWidth = settingsState.screenSizeData["cryptexExtraWidgetWidth"] +  settingsState.screenSizeData["cryptexTileAreaWidth"];
    final double cluesAreaHeight = settingsState.screenSizeData['cryptexHeight']*0.2;
    final double pillsHeight = cluesAreaHeight*0.7;
    final double underlineHeight = cluesAreaHeight*0.3;
    return Consumer<GamePlayState>(
      builder: (context,gamePlayState,child) {
        // final int active = getClueSummaryData(gamePlayState);
        final String completedCluesString = Helpers().getCompletedCluesString(gamePlayState);
        return Row(
          children: [
            Container(
              width: settingsState.screenSizeData["cryptexExtraWidgetWidth"], //MediaQuery.of(context).size.width * 0.15,
              height: cluesAreaHeight,
              // color: Colors.green,
              child: Center(
                child: Text(
                  // "$active / ${gamePlayState.words.length}",
                  completedCluesString,
                  style: TextStyle(
                    color: palette.mainTextColor
                  ),
                )
              ),
            ),
            Container(
              // color: Colors.blue,
              width: areaWidth,
              height: pillsHeight,
              // color: Colors.orange,
              child: Row(
                children: getCluePills(gamePlayState, areaWidth, palette),
              ),
            ),
          ],
        );
      }
    );
  }
}

List<Widget> getCluePills(GamePlayState gamePlayState, double widgetWidth, ColorPalette palette) {
  List<Widget> res = [];
  Size widgetSize = Size(widgetWidth/gamePlayState.words.length,widgetWidth/gamePlayState.words.length);
  gamePlayState.words.forEach((key,value) {
    Widget widget = SizedBox (
      width: widgetSize.width,
      height: widgetSize.height,
      child: Center(
        child: Container(
          width: widgetSize.width*0.80,
          height: widgetSize.height*0.80,        
          decoration: BoxDecoration(
            color: value["active"] ? palette.clueCardColor: palette.clueCardFlippedColor.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(100.0))
          ),
        ),
      ),
    );
    res.add(widget);
  });
  return res;
}

// int getClueSummaryData(GamePlayState gamePlayState) {
//   late int active = 0;
//   gamePlayState.words.forEach((key,value) {
//     if (!value["active"]) {
//       active++;
//     }
//   });
//   return active;
// }