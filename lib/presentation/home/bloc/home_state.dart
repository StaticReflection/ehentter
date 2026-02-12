part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final EhGalleryPageInfo galleryPageInfo;

  HomeLoaded(this.galleryPageInfo);
}

final class HomeLoadFailure extends HomeState {
  final String errorMessage;

  HomeLoadFailure(this.errorMessage);
}
