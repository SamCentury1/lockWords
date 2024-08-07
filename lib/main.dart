import 'package:flutter/material.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/game_screen/game_screen.dart';
import 'package:lock_words/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GamePlayState()),
        ChangeNotifierProvider(create: (_) => SettingsState()), 
        ChangeNotifierProvider(create: (_) => AnimationState()),        
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: GameScreen()
      ),
    );
  }
}


