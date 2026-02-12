part of 'injection_container.dart';

Future<void> _initEhDI() async {
  sl.registerLazySingleton(() => EhGalleryUrlParser());
  sl.registerLazySingleton(() => EhRatingStyleParser());
  sl.registerLazySingleton(() => EhGalleryPageParser(sl(), sl()));

  sl.registerLazySingleton<EhGalleryRemoteDataSource>(
    () => EhGalleryRemoteDataSourceImpl(sl(), sl()),
  );

  sl.registerLazySingleton<EhGalleryRepository>(
    () => EhGalleryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetGalleryPageInfoUseCase(sl()));
}
