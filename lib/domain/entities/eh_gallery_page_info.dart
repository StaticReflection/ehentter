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

  EhGalleryPageInfo copyWith({
    List<EhGallerySummary>? galleries,
    int? prevGid,
    int? nextGid,
    int? resultCount,
  }) {
    return EhGalleryPageInfo(
      galleries: galleries ?? this.galleries,
      prevGid: prevGid ?? this.prevGid,
      nextGid: nextGid ?? this.nextGid,
      resultCount: resultCount ?? this.resultCount,
    );
  }
}
