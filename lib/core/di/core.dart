part of 'injection_container.dart';

Future<void> _initCoreDI() async {
  final loggerService = LoggerService();
  loggerService.init();
  sl.registerSingleton<ILoggerService>(loggerService);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));

  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetThemeModeUseCase(sl()));
  sl.registerLazySingleton(() => SetThemeModeUseCase(sl()));
  sl.registerLazySingleton(() => GetLocaleUseCase(sl()));
  sl.registerLazySingleton(() => SetLocaleUseCase(sl()));

  sl.registerLazySingleton(() => ThemeCubit(sl(), sl()));
  sl.registerLazySingleton(() => LocaleCubit(sl(), sl()));
}
