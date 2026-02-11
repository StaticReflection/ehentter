import 'package:flutter/material.dart';
import 'package:flutter_template/core/l10n/generated/app_localizations.dart';

class LocaleSelector extends StatelessWidget {
  const LocaleSelector({
    required this.currentLocale,
    required this.onSelected,
    super.key,
  });

  final Locale? currentLocale;
  final Function(Locale? locale) onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Locale?>(
      initialSelection: currentLocale,
      onSelected: onSelected,
      label: Text('language'),
      dropdownMenuEntries: [
        ...AppLocalizations.supportedLocales.map((locale) {
          return DropdownMenuEntry(value: locale, label: locale.languageCode);
        }),
        DropdownMenuEntry(value: null, label: 'system'),
      ],
    );
  }
}
