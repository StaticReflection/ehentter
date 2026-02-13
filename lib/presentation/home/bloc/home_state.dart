part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final EhGalleryPageInfo galleryPageInfo;
  final bool isLoadingMore;

  HomeLoaded({required this.galleryPageInfo, this.isLoadingMore = false});

  HomeLoaded copyWith({
    EhGalleryPageInfo? galleryPageInfo,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      galleryPageInfo: galleryPageInfo ?? this.galleryPageInfo,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class HomeLoadFailure extends HomeState {
  final String errorMessage;

  HomeLoadFailure(this.errorMessage);
}
