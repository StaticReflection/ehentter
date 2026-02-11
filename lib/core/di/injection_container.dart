import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:ehentter/presentation/common/logic/locale/locale_cubit.dart';
import 'package:ehentter/data/repositories/settings_repository_impl.dart';
import 'package:ehentter/domain/repositores/settings_repository.dart';
import 'package:ehentter/presentation/common/logic/theme/theme_cubit.dart';
import 'package:ehentter/presentation/home/bloc/home_bloc.dart';
import 'package:ehentter/core/network/dio_client.dart';
import 'package:ehentter/data/sources/local/settings/settings_local_data_source.dart';
import 'package:ehentter/domain/usecases/core/get_locale_use_case.dart';
import 'package:ehentter/domain/usecases/core/get_theme_mode_use_case.dart';
import 'package:ehentter/domain/usecases/core/set_locale_use_case.dart';
import 'package:ehentter/domain/usecases/core/set_theme_mode_use_case.dart';

part 'core.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  _initCoreDI();

  sl.registerFactory(() => HomeBloc());
}
