import 'package:flutter/widgets.dart';
import 'package:ehentter/domain/repositores/settings_repository.dart';

class GetLocaleUseCase {
  final SettingsRepository _settingsRepository;

  GetLocaleUseCase(this._settingsRepository);

  Locale? call() {
    return _settingsRepository.getLocale();
  }
}
