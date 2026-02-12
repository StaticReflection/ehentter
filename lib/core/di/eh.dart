part of 'injection_container.dart';

Future<void> _initEhDI() async {
  sl.registerLazySingleton<EhGalleryRemoteDataSource>(
    () => EhGalleryRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<EhGalleryRepository>(
    () => EhGalleryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetGalleryPageInfoUseCase(sl()));
}
