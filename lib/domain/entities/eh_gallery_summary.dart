import 'package:ehentter/domain/entities/eh_gallery_category.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/domain/entities/eh_gallery_tag_group.dart';

class EhGallerySummary {
  final EhGalleryId id;
  final String title; // 标题
  final EhGalleryCategory category; // 类型
  final String thumb; // 缩略图地址
  final String uploader; // 上传者名称
  final DateTime posted; // 上传时间
  final int filecount; // 文件数
  final double rating; // 评分(1-5)
  final List<EhGalleryTagGroup> tags; // 标签

  EhGallerySummary({
    required this.id,
    required this.title,
    required this.category,
    required this.thumb,
    required this.uploader,
    required this.posted,
    required this.filecount,
    required this.rating,
    required this.tags,
  });
}
