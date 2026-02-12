import 'package:ehentter/domain/entities/eh_gallery_summary.dart';

class EhGalleryPageInfo {
  final List<EhGallerySummary> galleries;
  final int? prevGid;
  final int? nextGid;
  final int resultCount;

  const EhGalleryPageInfo({
    required this.galleries,
    this.prevGid,
    this.nextGid,
    required this.resultCount,
  });
}
