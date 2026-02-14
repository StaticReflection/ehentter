part of 'gallery_detail_bloc.dart';

@immutable
sealed class GalleryDetailState {
  const GalleryDetailState();
}

final class GalleryDetailInitial extends GalleryDetailState {
  const GalleryDetailInitial();
}

sealed class GalleryDetailStateWithSummary extends GalleryDetailState {
  final EhGallerySummary summary;
  const GalleryDetailStateWithSummary(this.summary);
}

final class GalleryDetailLoading extends GalleryDetailStateWithSummary {
  const GalleryDetailLoading(super.summary);
}

final class GalleryDetailLoaded extends GalleryDetailStateWithSummary {
  final EhGalleryDetail detail;
  const GalleryDetailLoaded(super.summary, this.detail);
}

final class GalleryDetailLoadFailure extends GalleryDetailStateWithSummary {
  final String message;
  const GalleryDetailLoadFailure(super.summary, this.message);
}
