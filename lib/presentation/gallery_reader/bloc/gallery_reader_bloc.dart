import 'package:ehentter/core/bloc/base_bloc.dart';
import 'package:ehentter/domain/entities/eh_gallery_detail.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/domain/usecases/eh/get_gallery_detail_use_case.dart';
import 'package:ehentter/domain/usecases/eh/get_gallery_image_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'gallery_reader_event.dart';
part 'gallery_reader_state.dart';
part 'gallery_reader_effect.dart';

class GalleryReaderBloc
    extends
        BaseBloc<GalleryReaderEvent, GalleryReaderState, GalleryReaderEffect> {
  final GetGalleryDetailUseCase _getGalleryDetailUseCase;
  final GetGalleryImageUseCase _getGalleryImageUseCase;

  GalleryReaderBloc(this._getGalleryDetailUseCase, this._getGalleryImageUseCase)
    : super(GalleryReaderInitial()) {
    on<GalleryReaderInit>(_onInit);
    on<GalleryReaderToggleActionsBar>(_onToggleActionsBar);
    on<GalleryReaderLoadMore>(_onLoadMore);
  }

  void _onToggleActionsBar(
    GalleryReaderToggleActionsBar event,
    Emitter<GalleryReaderState> emit,
  ) {
    final currentState = state;
    if (currentState is GalleryReaderLoaded) {
      emit(currentState.copyWith(showActionsBar: !currentState.showActionsBar));
    }
  }

  Future<void> _onInit(
    GalleryReaderInit event,
    Emitter<GalleryReaderState> emit,
  ) async {
    emit(GalleryReaderLoading());

    try {
      final detail = await _getGalleryDetailUseCase(
        event.galleryId,
        pageIndex: 0,
      );

      final imageFutures = detail.thumbnailSprites.map(
        (thumb) => _getGalleryImageUseCase(thumb.url),
      );

      final images = await Future.wait(imageFutures);

      emit(
        GalleryReaderLoaded(
          images: images,
          galleryDetail: detail,
          currentPageIndex: 0,
          hasReachedMax: detail.thumbnailPageCount <= 1,
          isFetchingMore: false,
        ),
      );
    } catch (e) {
      emit(GalleryReaderLoadFailure(e.toString(), event.galleryId));
    }
  }

  Future<void> _onLoadMore(
    GalleryReaderLoadMore event,
    Emitter<GalleryReaderState> emit,
  ) async {
    final currentState = state;

    if (currentState is! GalleryReaderLoaded ||
        currentState.isFetchingMore ||
        currentState.hasReachedMax) {
      return;
    }

    emit(currentState.copyWith(isFetchingMore: true));

    try {
      final nextPageIndex = currentState.currentPageIndex + 1;

      final nextDetail = await _getGalleryDetailUseCase(
        currentState.galleryDetail.id,
        pageIndex: nextPageIndex,
      );

      final newImageFutures = nextDetail.thumbnailSprites.map(
        (thumb) => _getGalleryImageUseCase(thumb.url),
      );

      final newImages = await Future.wait(newImageFutures);
      final totalPageCount = nextDetail.thumbnailPageCount;
      final reachedMax = nextPageIndex >= totalPageCount - 1;

      emit(
        currentState.copyWith(
          images: [...currentState.images, ...newImages],
          currentPageIndex: nextPageIndex,
          hasReachedMax: reachedMax,
          isFetchingMore: false,
        ),
      );
    } catch (e) {
      emit(currentState.copyWith(isFetchingMore: false));
      emitEffect(GalleryReaderLoadMoreFailure());
    }
  }
}
