import 'package:ehentter/data/sources/remote/eh_gallery_remote_data_source.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/repositores/eh_gallery_repository.dart';

class EhGalleryRepositoryImpl implements EhGalleryRepository {
  final EhGalleryRemoteDataSource _remoteDataSource;

  EhGalleryRepositoryImpl(this._remoteDataSource);

  @override
  Future<EhGalleryPageInfo> getGalleryPageInfo(String? query) async {
    return _remoteDataSource.getGalleryPageInfo(query);
  }
}
