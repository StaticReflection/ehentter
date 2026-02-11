import 'package:flutter/material.dart';
import 'package:flutter_template/data/sources/local/settings/settings_local_data_source.dart';
import 'package:flutter_template/domain/repositores/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _dataSource;

  SettingsRepositoryImpl(this._dataSource);

  @override
  ThemeMode getThemeMode() {
    final index = _dataSource.getThemeIndex();

    if (index == null || index < 0 || index >= ThemeMode.values.length) {
      return ThemeMode.system;
    }

    return ThemeMode.values[index];
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    await _dataSource.saveThemeIndex(mode.index);
  }

  @override
  Locale? getLocale() {
    final tag = _dataSource.getLocaleTag();
    if (tag == null || tag.isEmpty) return null;

    final parts = tag.split('-');
    return Locale.fromSubtags(
      languageCode: parts[0],
      scriptCode: parts.length > 2 ? parts[1] : null,
      countryCode: parts.length > 1 ? parts.last : null,
    );
  }

  @override
  Future<void> setLocale(Locale? locale) async {
    final tag = locale?.toLanguageTag();
    await _dataSource.saveLocaleTag(tag);
  }
}
