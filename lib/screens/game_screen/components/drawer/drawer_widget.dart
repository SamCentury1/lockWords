import 'package:flutter/material.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/ad_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/resources/firestore_methods.dart';
import 'package:lock_words/screens/game_screen/components/drawer/components/drawer_item_header.dart';
import 'package:lock_words/screens/game_screen/components/drawer/components/open_quit_game_dialog.dart';
import 'package:lock_words/screens/game_screen/components/drawer/components/open_reward_dialog.dart';
import 'package:lock_words/settings/settings.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {



  @override
  Widget build(BuildContext context,) {
    
    late ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);
    // late GamePlayState gamePlayState = Provider.of<GamePlayState>(context, listen: false);
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    late SettingsController settings = Provider.of<SettingsController>(context, listen: false);  
    late AdState adState = Provider.of<AdState>(context, listen: false);  
    late Map<dynamic,dynamic> userData = settings.userData.value as Map<dynamic,dynamic>;

    final double sizeFactor = settingsState.screenSizeData["sizeFactor"];    
        

    return Consumer<GamePlayState>(
      builder: (context,gamePlayState,child) {
        final String completedCluesString = Helpers().getCompletedCluesString(gamePlayState);
        return Drawer(
          width:  settingsState.screenSizeData["width"]*0.75,
          backgroundColor: palette.cryptexAreaColor,
          shadowColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60 * sizeFactor,),
                Container(
                  width: double.infinity,
                  height: 100 * sizeFactor,
                  // color: Colors.blue,
                  child: Center(
                    child: Text(
                      gamePlayState.level,
                      style: TextStyle(
                        color: palette.mainTextColor,
                        fontSize: 30 * sizeFactor,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ),
        
                drawerItemHeader(palette, "Stats", Icon(Icons.bar_chart_outlined),sizeFactor),                          
                SizedBox(height: 20 * sizeFactor,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                  child: Row(
                    children: [
                      Icon(Icons.timer, color: palette.mainTextColor,),
                      SizedBox(width: 20 * sizeFactor,),
                      Text(
                        // "14:32",
                        Helpers().formatTime(gamePlayState.duration.inSeconds),
                        style: TextStyle(
                          color:  palette.mainTextColor,
                          fontSize: 22 * sizeFactor,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                    ],
                  ),
                ),
        
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                  child: Row(
                    children: [
                      Icon(Icons.checklist_outlined, color: palette.mainTextColor,),
                      SizedBox(width: 20 * sizeFactor,),
                      Text(
                        // "14:32",
                        "$completedCluesString completed",
                        style: TextStyle(
                          color:  palette.mainTextColor,
                          fontSize: 22 * sizeFactor,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                    ],
                  ),
                ), 
        
        
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                  child: Row(
                    children: [
                      Icon(Icons.monetization_on, color: palette.mainTextColor,),
                      SizedBox(width: 20 * sizeFactor,),
                      Text(
                        // "14:32",
                        "${gamePlayState.coins} coins",
                        style: TextStyle(
                          color:  palette.mainTextColor,
                          fontSize: 22 * sizeFactor,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                    ],
                  ),
                ),                                   
        
                SizedBox(height: 50 * sizeFactor,),                 
        
        
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                  child: GestureDetector(
                    onTap: () => openQuitGameDialog(context,palette,settingsState),
                    child: Container(
                      decoration: BoxDecoration(
                        color: palette.clueCardColor,
                        borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor))
                      ),
                      child: Row(
                        children: [
                          SizedBox(width:15 * sizeFactor),
                          Icon(Icons.exit_to_app, color: palette.mainTextColor,),
                          SizedBox(width:15 * sizeFactor),
                          Text(
                            "Quit Game", 
                            style: TextStyle(
                              color: palette.clueCardTextColor,
                              fontSize: 22 * sizeFactor,
                              fontWeight: FontWeight.w300
                            ),
                          )
                        ]
                      ),
                    ),
                  ),
                ),
        
                SizedBox(height: 10 * sizeFactor,),
                
        
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                  child: GestureDetector(
                    onTap: () => openRewardDialog(
                      context,
                      palette,
                      // () => _showRewardedAd(gamePlayState,adState)
                      () => adState.showRewardedAdInGame(gamePlayState)
                    ),
                    // onTap: _showRewardedAd,
                    child: Container(
                      decoration: BoxDecoration(
                        color: palette.clueCardColor,
                        borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor))
                      ),
                      child: Row(
                        children: [
                          SizedBox(width:15 * sizeFactor),
                          Icon(Icons.monetization_on,  color: palette.mainTextColor,),
                          SizedBox(width:15 * sizeFactor),
                          Text(
                            "Get Tokens", 
                            style: TextStyle(
                              color: palette.clueCardTextColor,
                              fontSize: 22 * sizeFactor,
                              fontWeight: FontWeight.w300
                            ),
                          )
                        ]
                      ),
                    ),
                  ),
                ),
        
                
        
                SizedBox(height: 50 * sizeFactor,),
                drawerItemHeader(palette, "Settings",Icon(Icons.settings),sizeFactor),
                SizedBox(height: 20 * sizeFactor,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                  child: Container(
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            gamePlayState.isLockOnLeft
                            ? Text(
                              "Lock Side (Right)",
                              style: TextStyle(
                                color: palette.mainTextColor,
                                fontSize: 22 * sizeFactor,
                                fontWeight: FontWeight.w300
                              ),
                            ) 
                            : Text(
                              "Lock Side (Left)",
                              style: TextStyle(
                                  color: palette.mainTextColor,
                                  fontSize: 22 * sizeFactor,
                                  fontWeight: FontWeight.w300
                              ),                                      
                            ),
                            Transform.scale(
                              scale: 0.7,  // Adjust the scale as needed
                              child: Switch(
                                value: gamePlayState.isLockOnLeft,
                                // activeColor: Colors.red,
                                // inactiveTrackColor: Colors.green,
                                // activeColor:Colors.white,
                                trackColor: MaterialStateProperty.all(Colors.black),
                                onChanged: (bool value) {
                                  setState(() {
                                    gamePlayState.setIsLockOnLeft(value);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              
            
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          settings.soundsOn.value 
                          ? "Sound (On)"
                          : "Sound (Off)",
                          style: TextStyle(
                            fontSize: 22 * sizeFactor,
                            color: palette.mainTextColor,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                  
                        IconButton(
                          onPressed: () async {
                            settings.toggleSoundsOn();
                            FirestoreMethods().updateParameters(userData['uid'], 'soundOn', !userData['parameters']['soundOn']);
                            setState(() {
                              userData['parameters']['soundOn'] = settings.soundsOn.value;
                              settingsState.setUserData(userData);
                            });
                          }, 
                          icon: settings.soundsOn.value
                          ? Icon(Icons.volume_up, color: palette.mainTextColor)
                          : Icon(Icons.volume_off, color: palette.clueCardFlippedColor)
                        )                               
                      ],                              
                    ),
                  ),
                ),
            
                SizedBox(
                  height: 50 * sizeFactor,
                ),
            
        
                drawerItemHeader(palette, "How to Play?", Icon(Icons.question_answer),sizeFactor),
                SizedBox(height: 15 * sizeFactor,),
            
                Container(
                  width: double.infinity,
                  // height: 100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                    child: Text(
                      "Align the letters in each ring to solve the clues listed above.",
                      style: TextStyle(
                        color: palette.mainTextColor,
                        fontSize: 18 * sizeFactor,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15 * sizeFactor,),
                Container(
                  width: double.infinity,
                  // height: 100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                    child: Text(
                      "Each clue has a value, which gets added to your score when you solve it!",
                      style: TextStyle(
                        color: palette.mainTextColor,
                        fontSize: 18 * sizeFactor,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15 * sizeFactor,),
                Container(
                  width: double.infinity,
                  // height: 100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                    child: Text(
                      "To get a hint, tap the clue which will flip it over. The letters currently aligned in the cryptex will be revealed.",
                      style: TextStyle(
                        color: palette.mainTextColor,
                        fontSize: 18 * sizeFactor,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ), 
                SizedBox(height: 15 * sizeFactor,),
                Container(
                  width: double.infinity,
                  // height: 100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
                    child: Text(
                      "Be warned! Each hint will cost you one point!",
                      style: TextStyle(
                        color: palette.mainTextColor,
                        fontSize: 18 * sizeFactor,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ),                                                
              ],
            ),
          ),
        );
      }
    );    
  }
}