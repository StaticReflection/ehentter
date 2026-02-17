part of 'gallery_reader_bloc.dart';

@immutable
sealed class GalleryReaderState {}

final class GalleryReaderInitial extends GalleryReaderState {}

final class GalleryReaderLoading extends GalleryReaderState {}

final class GalleryReaderLoaded extends GalleryReaderState {
  final List<String> images;
  final EhGalleryDetail galleryDetail;
  final bool showActionsBar;

  final int nextPageIndex;
  final bool isFetchingMore;
  final bool hasReachedMax;

  GalleryReaderLoaded({
    required this.images,
    required this.galleryDetail,
    this.showActionsBar = false,
    this.nextPageIndex = 1,
    this.isFetchingMore = false,
    this.hasReachedMax = false,
  });

  GalleryReaderLoaded copyWith({
    List<String>? images,
    EhGalleryDetail? galleryDetail,
    bool? showActionsBar,
    int? nextPageIndex,
    bool? isFetchingMore,
    bool? hasReachedMax,
  }) {
    return GalleryReaderLoaded(
      images: images ?? this.images,
      galleryDetail: galleryDetail ?? this.galleryDetail,
      showActionsBar: showActionsBar ?? this.showActionsBar,
      nextPageIndex: nextPageIndex ?? this.nextPageIndex,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class GalleryReaderLoadFailure extends GalleryReaderState {
  final String message;
  final EhGalleryId galleryId;

  GalleryReaderLoadFailure(this.message, this.galleryId);
}
