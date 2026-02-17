part of 'gallery_reader_bloc.dart';

@immutable
sealed class GalleryReaderEvent {}

final class GalleryReaderInit extends GalleryReaderEvent {
  final EhGalleryId galleryId;

  GalleryReaderInit(this.galleryId);
}

final class GalleryReaderToggleActionsBar extends GalleryReaderEvent {}

final class GalleryReaderLoadMore extends GalleryReaderEvent {}
