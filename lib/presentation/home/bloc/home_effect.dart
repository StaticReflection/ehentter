part of 'home_bloc.dart';

sealed class HomeEffect {}

final class HomeLoadMoreFailure extends HomeEffect {
  final String message;

  HomeLoadMoreFailure(this.message);
}

class HomeNavigateToSearch extends HomeEffect {}
