import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_words/components/painters/token_painter.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class CoinBalanceWidget extends StatelessWidget {

  const CoinBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorPalette palette = Provider.of<ColorPalette>(context, listen:false);
    final SettingsState settingsState = Provider.of<SettingsState>(context, listen:false);
    
    // int balance =  settingsState.userData["balance"];

    // print("balance => $balance");

    return FutureBuilder(
      future: getUserData(settingsState),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final double sizeFactor = settingsState.screenSizeData["sizeFactor"];
          return Container(
            height: 40 * sizeFactor,
            // width: 100,
            decoration: BoxDecoration(
          
              color: palette.cryptexAreaColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0 * sizeFactor),
                bottomLeft: Radius.circular(50.0 * sizeFactor),
          
                topRight: Radius.circular(10.0 * sizeFactor),
                bottomRight: Radius.circular(10.0 * sizeFactor),          
              )
            ),
          
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 5  * sizeFactor,),
                SizedBox(
                  width: 30 * sizeFactor,
                  height: 30 * sizeFactor,
                  child: CustomPaint(
                    painter: TokenPainter(),
                  ),
                ),
          
                SizedBox(width: 10 * sizeFactor,),
          
                SizedBox(
                  child : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2 * sizeFactor),
                    child: Text(
                      // balance.toString(),
                      settingsState.userData["balance"].toString(),
                      style: TextStyle(
                        fontSize: 22 * sizeFactor,
                        color: palette.mainTextColor
                      ),
                    ),
                  )
                ),
          
                Container(
                  // color: Colors.blue,
                  width: 40 * sizeFactor,
                  height: 40 * sizeFactor,
                  child: IconButton(
                    onPressed: () {
                      // print("go to shop");
                      Helpers().openStoreDialog(context);
                    },
                    icon: Icon(Icons.add, color: palette.mainTextColor, size: 22 * sizeFactor),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

Future<Map<dynamic,dynamic>> getUserData(SettingsState settingsState) async {
  final Map<dynamic,dynamic> userData = settingsState.userData;
  return userData;
}