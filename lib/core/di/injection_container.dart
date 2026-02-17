import 'package:ehentter/core/logger/logger.dart';
import 'package:ehentter/data/parsers/eh_gallery_parsers.dart';
import 'package:ehentter/data/repositories/eh_gallery_repository_impl.dart';
import 'package:ehentter/data/services/logger_service.dart';
import 'package:ehentter/data/sources/remote/eh_gallery_remote_data_source.dart';
import 'package:ehentter/domain/repositores/eh_gallery_repository.dart';
import 'package:ehentter/domain/usecases/eh/get_gallery_detail_use_case.dart';
import 'package:ehentter/domain/usecases/eh/get_gallery_image_use_case.dart';
import 'package:ehentter/domain/usecases/eh/get_gallery_page_info_use_case.dart';
import 'package:ehentter/presentation/gallery_detail/bloc/gallery_detail_bloc.dart';
import 'package:ehentter/presentation/gallery_reader/bloc/gallery_reader_bloc.dart';
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
part 'eh.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  await _initCoreDI();
  await _initEhDI();

  sl.registerFactory(() => HomeBloc(sl()));
  sl.registerFactory(() => GalleryDetailBloc(sl()));
  sl.registerFactory(() => GalleryReaderBloc(sl(), sl()));
}
