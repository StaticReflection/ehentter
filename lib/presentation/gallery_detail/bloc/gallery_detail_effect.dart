part of 'gallery_detail_bloc.dart';

sealed class GalleryDetailEffect {}

final class GalleryDetailNavigateToReader extends GalleryDetailEffect {
  final EhGalleryId galleryId;
  GalleryDetailNavigateToReader(this.galleryId);
}
