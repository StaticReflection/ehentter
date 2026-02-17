import 'package:ehentter/domain/entities/eh_gallery_detail.dart';

class EhGalleryDetailModel extends EhGalleryDetail {
  EhGalleryDetailModel({
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
    required super.thumbnailSprites,
  }) : super(thumbnailPageCount: (filecount / 20).ceil());
}
