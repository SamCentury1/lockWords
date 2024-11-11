import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lock_words/ads/ads_controller.dart';
import 'package:lock_words/app_lifecycle/app_lifecycle.dart';
import 'package:lock_words/audio/audio_controller.dart';
import 'package:lock_words/firebase_options.dart';
import 'package:lock_words/providers/ad_state.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/auth_screen/auth_screen.dart';
import 'package:lock_words/screens/game_screen/game_screen.dart';
import 'package:lock_words/screens/home_screen/home_screen.dart';
import 'package:lock_words/settings/persistence/local_storage_settings_persistence.dart';
import 'package:lock_words/settings/persistence/settings_persistence.dart';
import 'package:lock_words/settings/settings.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  AdsController? adsController;
  if (kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    adsController = AdsController(MobileAds.instance);
    adsController.initialize();
  }
  
    
  runApp(MyApp(
    settingsPersistence: LocalStorageSettingsPersistence(),
    adsController: adsController,
  ));
}


class MyApp extends StatelessWidget {
  final SettingsPersistence settingsPersistence;
  final AdsController? adsController;
  const MyApp({
    super.key,
    required this.settingsPersistence,
    required this.adsController,
  });


  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GamePlayState()),
          ChangeNotifierProvider(create: (_) => SettingsState()),
          ChangeNotifierProvider(create: (_) => AnimationState()),
          ChangeNotifierProvider(create: (_) => ColorPalette(),),
          ChangeNotifierProvider(create: (_) => AdState(),),
          Provider<AdsController?>.value(value: adsController),
          Provider<SettingsController>(
            lazy: false,
            create: (context) => SettingsController(
              persistence: settingsPersistence,
            )..loadStateFromPerisitence(),
          ),
          ProxyProvider2<SettingsController, ValueNotifier<AppLifecycleState>,AudioController>(
            lazy: false,
            create: (context) => AudioController()..initialize(),
            update: (context, settings, lifecycleNotifier, audio) {
              if (audio == null) throw ArgumentError.notNull();
              // audio.attachSettings(settings);
              audio.attachLifecycleNotifier(lifecycleNotifier);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),        
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              title: 'Cryptex',
              debugShowCheckedModeBanner: false,
              home: AuthScreen()
            );
          }
        ),
      ),
    );
  }
}


