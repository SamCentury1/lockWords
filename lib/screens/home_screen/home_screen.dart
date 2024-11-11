import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lock_words/providers/ad_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/home_screen/components/coin_balance_widget.dart';
import 'package:lock_words/screens/home_screen/components/home_drawer.dart';
import 'package:lock_words/screens/home_screen/components/level_button_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  // late AdState _adState;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _adState = Provider.of<AdState>(context, listen: false);
  //   _adState.createRewardedAd();

  // }

  @override
  Widget build(BuildContext context) {
    late GamePlayState gamePlayState = Provider.of<GamePlayState>(context,listen: false);
    late ColorPalette _palette = Provider.of<ColorPalette>(context, listen: false);
    return Consumer<SettingsState>(
      builder: (context,settingsState,child) {
        // final Map<dynamic,dynamic> userData = settingsState.userData;
        // final double sizeFactor = settingsState.screenSizeData["sizeFactor"] ?? 1.0;
        return FutureBuilder(
          future: getSizeFactor(settingsState),
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final double sizeFactor = snapshot.data!;
              return SafeArea(
                child: Scaffold(
                  backgroundColor: _palette.screenBackgroundColor,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(color: _palette.mainTextColor),
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CoinBalanceWidget()               
                      ],
                    ),
                  ),
                  drawer: const HomeDrawer(),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20,),
              
              
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.0 * sizeFactor),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Daily Puzzles",
                              style: TextStyle(
                                fontSize: (28.0 * sizeFactor),
                                color: _palette.mainTextColor
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.0 * sizeFactor),
                          child: Divider(thickness: 1.0, color: _palette.mainTextColor,),
                        ),
                    
                        SizedBox(height: 00,),
                    
                        Container(
                          width: double.infinity,
                          // height: 100.0 * sizeFactor,
                          // color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0 * sizeFactor ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  dailyPuzzleButton(_palette,0,false, sizeFactor),
                                  dailyPuzzleButton(_palette,1,true, sizeFactor),
                                  dailyPuzzleButton(_palette,2,true, sizeFactor),
                                  dailyPuzzleButton(_palette,3,true, sizeFactor),
                                  dailyPuzzleButton(_palette,4,true, sizeFactor),                                                                                                                               
                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                    
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.0 * sizeFactor),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Free Puzzles",
                              style: TextStyle(
                                fontSize: (28.0 * sizeFactor),
                                color: _palette.mainTextColor
                              ),
                            ),
                          ),
                        ),
                    
                        
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.0 * sizeFactor),
                          child: Divider(thickness: 1.0, color: _palette.mainTextColor,),
                        ),
                    
                    
                        SizedBox(height: 20,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Container(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  children: displayLevels(settingsState, gamePlayState)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
      }
    );
  }
}

List<Widget> displayLevels(SettingsState settingsState, GamePlayState gamePlayState) {
  List<Widget> widgets = [];
  List<Map<dynamic,dynamic>> levels = settingsState.levelData;

  levels.sort((a,b) => a["key"].compareTo(b["key"]));

  for (int i=0; i<levels.length; i++) {
    Map<dynamic,dynamic> levelData = levels[i];
    Widget widget = LevelButton(index: i, levelData: levelData );
    widgets.add(widget);
  }

  return widgets;
}


Widget dailyPuzzleButton(ColorPalette palette, int index, bool locked, double sizeFactor) {

  final DateFormat formatter = DateFormat('MMM. dd, yyyy');
  DateTime today = DateTime.now().subtract(Duration(days: index));
  String body = formatter.format(today);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Container(
      width: 200 * sizeFactor,
      height: 60 * sizeFactor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor)),
        color: palette.clueCardColor,
      ),
      child: Center(
        child: Stack(
          children: [
        
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 180 * sizeFactor,
                height: 55 * sizeFactor,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        body,
                        style: TextStyle(
                          color: palette.clueCardTextColor,
                          fontSize: 20 * sizeFactor
                        ),
                      ),
                      Icon(Icons.arrow_circle_right_rounded, size: 24 * sizeFactor, color: palette.clueCardTextColor,)
                    ],
                  ),
                ),
              ),
            ),


            locked 
            ? Container(
              width: 200* sizeFactor,
              height: 60 * sizeFactor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor)),
                color: const Color.fromARGB(151, 0, 0, 0),
              ),
            )
            : SizedBox(),

            locked
            ? Align(
              alignment: Alignment.center,
              child: Icon(Icons.lock, size: 24 * sizeFactor, color: palette.clueCardTextColor,),
            )
            :SizedBox()
          ],
        ),
      ),
    ),
  );
}

Future<double> getSizeFactor(SettingsState settingsState) async {
  final double sizeFactor = settingsState.screenSizeData["sizeFactor"];
  return sizeFactor;
}