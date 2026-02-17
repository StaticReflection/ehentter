import 'package:ehentter/core/bloc/base_bloc.dart';
import 'package:ehentter/domain/entities/eh_gallery_detail.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/domain/entities/eh_gallery_summary.dart';
import 'package:ehentter/domain/usecases/eh/get_gallery_detail_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'gallery_detail_event.dart';
part 'gallery_detail_state.dart';
part 'gallery_detail_effect.dart';

class GalleryDetailBloc
    extends
        BaseBloc<GalleryDetailEvent, GalleryDetailState, GalleryDetailEffect> {
  final GetGalleryDetailUseCase _getGalleryDetailUseCase;

  GalleryDetailBloc(this._getGalleryDetailUseCase)
    : super(GalleryDetailInitial()) {
    on<GalleryDetailInit>(_onInit);
    on<GalleryDetailReadPressed>(_onReadPressed);
  }

  Future<void> _onInit(
    GalleryDetailInit event,
    Emitter<GalleryDetailState> emit,
  ) async {
    emit(GalleryDetailLoading(event.gallerySummary));
    final currentState = state;
    if (currentState is GalleryDetailStateWithSummary) {
      try {
        final detail = await _getGalleryDetailUseCase(currentState.summary.id);
        emit(GalleryDetailLoaded(currentState.summary, detail));
      } catch (e) {
        emit(GalleryDetailLoadFailure(currentState.summary, e.toString()));
      }
    }
  }

  void _onReadPressed(
    GalleryDetailReadPressed event,
    Emitter<GalleryDetailState> emit,
  ) {
    if (state is GalleryDetailLoaded) {
      final loadedState = state as GalleryDetailLoaded;
      emitEffect(GalleryDetailNavigateToReader(loadedState.detail.id));
    }
  }
}
