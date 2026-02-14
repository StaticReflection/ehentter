import 'package:ehentter/domain/entities/eh_gallery_detail.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';

abstract class EhGalleryRepository {
  Future<EhGalleryPageInfo> getGalleryPageInfo(String? query, {int? nextGid});

  Future<EhGalleryDetail> getGalleryDetail(EhGalleryId id);
}
