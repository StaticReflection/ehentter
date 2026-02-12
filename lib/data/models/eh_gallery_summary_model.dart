import 'package:ehentter/data/models/eh_gallery_tag_model.dart';
import 'package:ehentter/domain/entities/eh_gallery_summary.dart';

class EhGallerySummaryModel extends EhGallerySummary {
  EhGallerySummaryModel({
    required List<EhGalleryTagGroupModel> tags,
    required super.id,
    required super.title,
    required super.category,
    required super.thumb,
    required super.uploader,
    required super.posted,
    required super.filecount,
    required super.rating,
  }) : super(tags: tags);
}
