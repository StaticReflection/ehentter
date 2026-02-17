import 'package:flutter/material.dart';
import 'package:ehentter/l10n/generated/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  AppLocalizations get l10n => AppLocalizations.of(this);

  MediaQueryData get media => MediaQuery.of(this);
}
