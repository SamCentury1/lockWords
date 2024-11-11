import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_words/components/painters/clapper_board_painter.dart';
import 'package:lock_words/components/painters/gem_painter_1.dart';
import 'package:lock_words/components/painters/gem_painter_2.dart';
import 'package:lock_words/components/painters/no_ads_painter.dart';
import 'package:lock_words/components/painters/token_painter.dart';
import 'package:lock_words/providers/ad_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/game_screen/components/drawer/components/open_reward_dialog.dart';
import 'package:provider/provider.dart';

class StoreItemWidget extends StatelessWidget {
  final Map<dynamic,dynamic> itemData;
  final Function()? onTap;
  const StoreItemWidget({
    super.key,
    required this.itemData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    late ColorPalette palette = Provider.of<ColorPalette>(context, listen:false);
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen:false);
    final double sizeFactor = settingsState.screenSizeData["sizeFactor"];    
    final int itemCount = itemData["itemCount"];
  
    return GestureDetector(
      onTap: onTap != null ? () => onTap!() : null,
      child: Padding(
        padding: EdgeInsets.all(8.0 * sizeFactor),
        child: Container(
          decoration: BoxDecoration(
            color: palette.cryptexAreaColor,
            borderRadius: BorderRadius.all(Radius.circular(12.0 * sizeFactor)),
          ),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(8.0 * sizeFactor),
            child: Row(
              children: [
                Container(
                  width: 45 * sizeFactor,
                  height: 45 * sizeFactor,
                  decoration: BoxDecoration(
                    color: palette.cryptexLetterTileColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor)),
                  ),
                  child: Stack(children: getTokenImage(45 * sizeFactor, 20 * sizeFactor, itemCount, itemData["type"] ,palette ),),
                ),
                SizedBox(width: 22 * sizeFactor,),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    itemData["title"],
                    style: TextStyle(
                      color: palette.mainTextColor,
                      fontSize: 18 * sizeFactor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


List<Widget> getTokenImage(double containerSize, double itemSize, int count, String itemType, ColorPalette palette) {
  double top = (containerSize-itemSize)/2;
  double incrementSize = containerSize/8;
  double totalCoinsWidth = (itemSize + ((count+1) * incrementSize));
  double startingTokenPosition = (containerSize - totalCoinsWidth) / 2;
  List<Widget> items = [];

  for (int i = 1; i <= count ; i++) {
    late Widget item = Positioned(
      top: top,
      left: startingTokenPosition + (i * incrementSize),
      child: Container(
        width: itemSize,
        height: itemSize,
        child: CustomPaint(
          painter: returnCustomPainter(itemType, palette),
        ),
      ),
    );
    items.add(item);
  }

  return items;
}

CustomPainter returnCustomPainter(String itemType, ColorPalette palette) {

  if (itemType == 'coin') {
    return TokenPainter();
  } else if (itemType == 'rubyGem') {
    return GemPainter1();
  } else if (itemType == 'sapphireGem') {
    return GemPainter2();
  } else if (itemType == 'noAds') {
    return NoAdsPainter(palette: palette);
  } else if (itemType == 'watchAd') {
    return ClapperBoardPainter();
  } else {
    return TokenPainter();
  }
}