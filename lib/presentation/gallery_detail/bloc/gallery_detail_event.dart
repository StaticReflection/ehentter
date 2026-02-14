part of 'gallery_detail_bloc.dart';

@immutable
sealed class GalleryDetailEvent {}

final class GalleryDetailInit extends GalleryDetailEvent {
  final EhGallerySummary gallerySummary;

  GalleryDetailInit(this.gallerySummary);
}
