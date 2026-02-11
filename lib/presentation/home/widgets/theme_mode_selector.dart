import 'package:flutter/material.dart';

class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({
    required this.currentThemeMode,
    required this.onSelected,
    super.key,
  });

  final ThemeMode currentThemeMode;
  final Function(ThemeMode? themeMode) onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<ThemeMode>(
      initialSelection: currentThemeMode,
      onSelected: onSelected,
      label: Text('theme mode'),
      dropdownMenuEntries: ThemeMode.values.map((themeMode) {
        return DropdownMenuEntry(value: themeMode, label: themeMode.name);
      }).toList(),
    );
  }
}
