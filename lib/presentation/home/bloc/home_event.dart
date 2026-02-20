part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInit extends HomeEvent {}

final class HomeLoadNextPage extends HomeEvent {}

final class HomeSearchPressed extends HomeEvent {}
