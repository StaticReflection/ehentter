import 'package:ehentter/domain/entities/eh_gallery_summary.dart';
import 'package:ehentter/domain/entities/eh_thumbnail_sprite.dart';

class EhGalleryDetail extends EhGallerySummary {
  final List<EhThumbnailSprite> thumbnailSprites; // 精灵图

  EhGalleryDetail({
    // summary
    required super.id,
    required super.title,
    required super.category,
    required super.thumb,
    required super.uploader,
    required super.posted,
    required super.filecount,
    required super.rating,
    required super.tags,

    // detail
    required this.thumbnailSprites,
  });
}
