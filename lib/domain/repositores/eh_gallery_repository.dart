import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';

abstract class EhGalleryRepository {
  Future<EhGalleryPageInfo> getGalleryPageInfo(String? query);
}
