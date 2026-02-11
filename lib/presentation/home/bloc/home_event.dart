part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInit extends HomeEvent {}

final class HomeTest extends HomeEvent {}
