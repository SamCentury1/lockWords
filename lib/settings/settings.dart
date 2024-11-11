import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_words/settings/persistence/settings_persistence.dart';

class SettingsController {
  final SettingsPersistence _persistence;

  /// Whether or not the sound is on at all. This overrides both music
  /// and sound.
  ValueNotifier<bool> muted = ValueNotifier(false);

  ValueNotifier<bool> soundsOn = ValueNotifier(false);

  ValueNotifier<String> user = ValueNotifier("User");

  ValueNotifier<String> colorTheme = ValueNotifier('dark');

  ValueNotifier<Object> userData = ValueNotifier({});


  /// Creates a new instance of [SettingsController] backed by [persistence].
  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  /// Asynchronously loads values from the injected persistence store.
  Future<void> loadStateFromPerisitence() async {
    await Future.wait([ // await
      _persistence
          .getMuted(defaultValue: kIsWeb)
          .then((value) => muted.value = value),
          // .then((value) => muted.value = value ?? false),
      _persistence
          .getSoundsOn(defaultValue: kIsWeb)
          .then((value) => soundsOn.value = value),
      _persistence.getUser().then((value) => user.value = value),
      _persistence.getColorTheme().then((value) => colorTheme.value = value),
      _persistence.getUserData().then((value) => userData.value = value),

    ]);
  }

  void toggleMuted() {
    muted.value = !muted.value;
    _persistence.saveMuted(muted.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _persistence.saveSoundsOn(soundsOn.value);
  }

  void setUser(String name) {
    user.value = name;
    _persistence.saveUser(user.value);
  }

  void toggleColorTheme(String value) {
    colorTheme.value = value;
    _persistence.saveColorTheme(colorTheme.value);
  }

  void setUserData(Object userObject) {
    userData.value = userObject;
    _persistence.saveUserData(userData.value);
  }  
}
