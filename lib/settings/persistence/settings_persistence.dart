abstract class SettingsPersistence {
  /// ========== GET THE DATA ===================
  Future<bool> getSoundsOn({required bool defaultValue});

  Future<bool> getMuted({required bool defaultValue});

  Future<String> getUser();

  Future<String> getColorTheme();

  Future<Object> getUserData();



  /// ========== SAVE THE DATA ===================
  Future<void> saveSoundsOn(bool value);

  Future<void> saveMuted(bool value);

  Future<void> saveUser(String value);

  Future<void> saveColorTheme(String value);

  Future<void> saveUserData(Object value);

}
