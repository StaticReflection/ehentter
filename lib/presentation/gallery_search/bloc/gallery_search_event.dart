part of 'gallery_search_bloc.dart';

@immutable
sealed class GallerySearchEvent {}

final class GallerySearchInit extends GallerySearchEvent {}

final class GallerySearchQuery extends GallerySearchEvent {
  final String query;

  GallerySearchQuery(this.query);
}

final class GallerySearchLoadNextPage extends GallerySearchEvent {}
