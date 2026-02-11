import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehentter/core/bloc/base_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_effect.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState, HomeEffect> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInit>(_onInit);
    on<HomeTest>(_onTest);

    add(HomeInit());
  }

  void _onInit(HomeInit event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await Future.delayed(Duration(seconds: 2));
    emit(HomeLoaded());
  }

  void _onTest(HomeTest event, Emitter<HomeState> emit) {
    emitEffect(HomeShowTestMessage());
  }
}
