import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/usecases/eh/get_gallery_page_info_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehentter/core/bloc/base_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_effect.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState, HomeEffect> {
  final GetGalleryPageInfoUseCase _getGalleryPageInfoUseCase;

  HomeBloc(this._getGalleryPageInfoUseCase) : super(HomeInitial()) {
    on<HomeInit>(_onInit);

    add(HomeInit());
  }

  void _onInit(HomeInit event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final pageInfo = await _getGalleryPageInfoUseCase();
      emit(HomeLoaded(pageInfo));
    } catch (e) {
      emit(HomeLoadFailure(e.toString()));
    }
  }
}
