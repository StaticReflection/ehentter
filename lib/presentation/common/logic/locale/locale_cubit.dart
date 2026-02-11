import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/domain/usecases/core/get_locale_use_case.dart';
import 'package:flutter_template/domain/usecases/core/set_locale_use_case.dart';

class LocaleCubit extends Cubit<Locale?> {
  final SetLocaleUseCase _setLocaleUseCase;

  LocaleCubit(GetLocaleUseCase getLocaleUseCase, this._setLocaleUseCase)
    : super(getLocaleUseCase.call());

  void changeLocale(Locale? locale) {
    emit(locale);
    _setLocaleUseCase.call(locale);
  }

  void useSystemSettings() {
    emit(null);
    _setLocaleUseCase.call(null);
  }
}
