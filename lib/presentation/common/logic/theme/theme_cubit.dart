import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehentter/domain/usecases/core/get_theme_mode_use_case.dart';
import 'package:ehentter/domain/usecases/core/set_theme_mode_use_case.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SetThemeModeUseCase _setThemeModeUseCase;

  ThemeCubit(GetThemeModeUseCase getThemeModeUseCase, this._setThemeModeUseCase)
    : super(getThemeModeUseCase.call());

  Future<void> updateTheme(ThemeMode mode) async {
    if (state == mode) return;
    emit(mode);
    await _setThemeModeUseCase.call(mode);
  }
}
