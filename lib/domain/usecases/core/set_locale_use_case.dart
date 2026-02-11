import 'package:flutter/widgets.dart';
import 'package:ehentter/domain/repositores/settings_repository.dart';

class SetLocaleUseCase {
  final SettingsRepository _settingsRepository;

  SetLocaleUseCase(this._settingsRepository);

  Future<void> call(Locale? locale) async {
    return await _settingsRepository.setLocale(locale);
  }
}
