import 'package:ehentter/data/constants/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  int? getThemeIndex();

  Future<void> saveThemeIndex(int index);

  String? getLocaleTag();
  
  Future<void> saveLocaleTag(String? tag);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences _prefs;
  SettingsLocalDataSourceImpl(this._prefs);

  @override
  int? getThemeIndex() => _prefs.getInt(StorageKeys.themeMode);

  @override
  Future<void> saveThemeIndex(int index) =>
      _prefs.setInt(StorageKeys.themeMode, index);

  @override
  String? getLocaleTag() => _prefs.getString(StorageKeys.locale);

  @override
  Future<void> saveLocaleTag(String? tag) async {
    if (tag == null) {
      await _prefs.remove(StorageKeys.locale);
    } else {
      await _prefs.setString(StorageKeys.locale, tag);
    }
  }
}
