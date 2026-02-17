import 'package:ehentter/data/sources/remote/eh_gallery_remote_data_source.dart';
import 'package:ehentter/domain/entities/eh_gallery_detail.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/repositores/eh_gallery_repository.dart';

class EhGalleryRepositoryImpl implements EhGalleryRepository {
  final EhGalleryRemoteDataSource _remoteDataSource;

  EhGalleryRepositoryImpl(this._remoteDataSource);

  @override
  Future<EhGalleryPageInfo> getGalleryPageInfo(
    String? query, {
    int? nextGid,
  }) async {
    return await _remoteDataSource.getGalleryPageInfo(query, nextGid: nextGid);
  }

  @override
  Future<EhGalleryDetail> getGalleryDetail(
    EhGalleryId id, {
    int pageIndex = 0,
  }) async {
    return await _remoteDataSource.getGalleryDetail(id, pageIndex: pageIndex);
  }

  @override
  Future<String> getGalleryImage(String pageUrl) async {
    return await _remoteDataSource.getGalleryImage(pageUrl);
  }
}
