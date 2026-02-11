import 'package:flutter/material.dart';
import 'package:ehentter/domain/repositores/settings_repository.dart';

class SetThemeModeUseCase {
  final SettingsRepository _settingsRepository;

  SetThemeModeUseCase(this._settingsRepository);

  Future<void> call(ThemeMode mode) {
    return _settingsRepository.setThemeMode(mode);
  }
}
