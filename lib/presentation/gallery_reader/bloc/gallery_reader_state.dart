part of 'gallery_reader_bloc.dart';

@immutable
sealed class GalleryReaderState {}

final class GalleryReaderInitial extends GalleryReaderState {}

final class GalleryReaderLoading extends GalleryReaderState {}

class GalleryReaderLoaded extends GalleryReaderState {
  final List<String> images;
  final EhGalleryDetail galleryDetail;
  final int currentPageIndex;
  final bool hasReachedMax;
  final bool isFetchingMore;
  final bool showActionsBar;

  GalleryReaderLoaded({
    required this.images,
    required this.galleryDetail,
    required this.currentPageIndex,
    required this.hasReachedMax,
    this.isFetchingMore = false,
    this.showActionsBar = false,
  });

  GalleryReaderLoaded copyWith({
    List<String>? images,
    EhGalleryDetail? galleryDetail,
    int? currentPageIndex,
    bool? hasReachedMax,
    bool? isFetchingMore,
    bool? showActionsBar,
  }) {
    return GalleryReaderLoaded(
      images: images ?? this.images,
      galleryDetail: galleryDetail ?? this.galleryDetail,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      showActionsBar: showActionsBar ?? this.showActionsBar,
    );
  }
}

final class GalleryReaderLoadFailure extends GalleryReaderState {
  final String message;
  final EhGalleryId galleryId;

  GalleryReaderLoadFailure(this.message, this.galleryId);
}
