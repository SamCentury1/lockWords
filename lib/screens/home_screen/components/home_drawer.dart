import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/resources/auth_service.dart';
import 'package:lock_words/screens/auth_screen/auth_screen.dart';
import 'package:lock_words/screens/profile_screen/profile_screen.dart';
import 'package:lock_words/screens/settings_screen/settings_screen.dart';
import 'package:lock_words/screens/tutorial_flow/tutorial_screen.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    late ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    late GamePlayState gamePlayState = Provider.of<GamePlayState>(context, listen: false);
    final double sizeFactor = settingsState.screenSizeData["sizeFactor"];
    
    return Drawer(
      width: settingsState.screenSizeData["width"] *0.75,
      backgroundColor: palette.cryptexAreaColor,
      shadowColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.all(8.0 * sizeFactor),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            child: Center(
              child: Image.asset('assets/images/temp_logo.png'),
            ),
          ),
          ListTile(
            title: Text(
              'Settings',
              style: TextStyle(
                color: palette.mainTextColor,
                fontSize: (28 * sizeFactor)
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SettingsScreen())
              );
            },
          ),
          ListTile(
            title: Text(
              'Profile',
              style: TextStyle(
                color: palette.mainTextColor,
                fontSize: (28 * sizeFactor)
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ProfileScreen())
              );

            },
          ),

          ListTile(
            title: Text(
              'How To Play',
              style: TextStyle(
                color: palette.mainTextColor,
                fontSize: (28 * sizeFactor)
              ),
            ),
            onTap: () {
              Helpers().navigateToTutorial("Tutorial", context, settingsState, gamePlayState);

            },
          ),

          ListTile(
            title: Text(
              'Store',
              style: TextStyle(
                color: palette.mainTextColor,
                fontSize: (28 * sizeFactor)
              ),
            ),
            onTap: () {
              Helpers().openStoreDialog(context);
            },
          ),          
          // SizedBox(height: 200,),

          ListTile(
            title: Text(
              'Sign Out',
              style: TextStyle(
                color: palette.mainTextColor,
                fontSize:(28 * sizeFactor)
              ),
            ),
            onTap: () {
              AuthService().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthScreen())
              );
            },
          ),  
        ],
      )
    );
  }
}