import 'package:flutter/material.dart';
import 'package:ehentter/domain/repositores/settings_repository.dart';

class GetThemeModeUseCase {
  final SettingsRepository _settingsRepository;

  GetThemeModeUseCase(this._settingsRepository);

  ThemeMode call() {
    return _settingsRepository.getThemeMode();
  }
}
