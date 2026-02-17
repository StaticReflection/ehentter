import 'package:ehentter/domain/entities/eh_gallery_detail.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';

abstract class EhGalleryRepository {
  // 获取画廊列表页比如首页，搜索页
  Future<EhGalleryPageInfo> getGalleryPageInfo(String? query, {int? nextGid});

  // 获取画廊详情
  Future<EhGalleryDetail> getGalleryDetail(EhGalleryId id, {int pageIndex});

  // 获取画廊的某个图片
  Future<String> getGalleryImage(String pageUrl);
}
