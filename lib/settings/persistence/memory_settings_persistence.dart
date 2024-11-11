import 'package:lock_words/settings/persistence/settings_persistence.dart';
/// An in-memory implementation of [SettingsPersistence].
/// Useful for testing.

class MemoryOnlySettingsPersistence implements SettingsPersistence {
  bool soundsOn = true;
  bool muted = false;
  String user = "User";
  String darkTheme = 'dark';
  Object userData = {};

  /// ============= GET ===================
  @override
  Future<bool> getSoundsOn({required bool defaultValue}) async => soundsOn;

  @override
  Future<bool> getMuted({required bool defaultValue}) async => muted;

  @override
  Future<String> getUser() async => user;

  @override
  Future<String> getColorTheme() async => darkTheme;

  @override
  Future<Object> getUserData() async => userData;


  /// =========== SAVE ========================
  @override
  Future<void> saveSoundsOn(bool value) async => soundsOn = value;

  @override
  Future<void> saveMuted(bool value) async => muted = value;

  @override
  Future<void> saveUser(String value) async => user = value;

  @override
  Future<String> saveColorTheme(String value) async => darkTheme = value;

  @override
  Future<void> saveUserData(Object value) async => userData = value;
}