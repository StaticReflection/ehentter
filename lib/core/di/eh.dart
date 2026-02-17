part of 'injection_container.dart';

Future<void> _initEhDI() async {
  sl.registerLazySingleton(() => EhGalleryUrlParser());
  sl.registerLazySingleton(() => EhRatingStyleParser());
  sl.registerLazySingleton(() => EhNextUrlParser());
  sl.registerLazySingleton(() => EhPrevUrlParser());
  sl.registerLazySingleton(() => EhGalleryPageParser(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => EhGalleryDetailParser(sl()));
  sl.registerLazySingleton(() => EhGalleryImageParser());

  sl.registerLazySingleton<EhGalleryRemoteDataSource>(
    () => EhGalleryRemoteDataSourceImpl(sl(), sl(), sl(), sl()),
  );

  sl.registerLazySingleton<EhGalleryRepository>(
    () => EhGalleryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetGalleryPageInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetGalleryDetailUseCase(sl()));
  sl.registerLazySingleton(() => GetGalleryImageUseCase(sl()));
}
