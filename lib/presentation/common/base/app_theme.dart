import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _baseTheme(.light);

  static ThemeData get darkTheme => _baseTheme(.dark);

  static ThemeData _baseTheme(Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      cardTheme: CardThemeData(
        clipBehavior: .antiAlias,
        margin: .zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      appBarTheme: AppBarThemeData(actionsPadding: .only(right: 16)),
    );
  }
}
