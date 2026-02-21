import 'package:ehentter/domain/entities/eh_gallery_comment.dart';
import 'package:ehentter/domain/entities/eh_gallery_summary.dart';
import 'package:ehentter/domain/entities/eh_thumbnail_sprite.dart';

class EhGalleryDetail extends EhGallerySummary {
  final List<EhThumbnailSprite> thumbnailSprites; // 精灵图
  final int thumbnailPageCount; // 缩略图页面总数量
  final List<EhGalleryComment> comments;

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
    required this.thumbnailPageCount,
    required this.comments,
  });
}
