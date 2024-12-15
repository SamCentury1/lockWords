import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {

    late SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    late ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: palette.screenBackgroundColor,
        body: Column(
          children: [
            Text(
              "Tutorial", 
              style: TextStyle(
                color: palette.mainTextColor
              ),
            ),
          ],
        ),
      )
    );
  }
}