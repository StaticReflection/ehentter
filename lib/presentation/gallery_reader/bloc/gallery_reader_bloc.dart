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
      final galleryDetail = await _getGalleryDetailUseCase(
        event.galleryId,
        pageIndex: 0,
      );

      final imageFutures = galleryDetail.thumbnailSprites.map(
        (thumb) => _getGalleryImageUseCase(thumb.url),
      );
      final List<String> images = await Future.wait(imageFutures);

      emit(
        GalleryReaderLoaded(
          images: images,
          galleryDetail: galleryDetail,
          hasReachedMax: galleryDetail.thumbnailPageCount <= 1,
          nextPageIndex: 1,
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

    try {
      emit(currentState.copyWith(isFetchingMore: true));

      final nextDetail = await _getGalleryDetailUseCase(
        currentState.galleryDetail.id,
        pageIndex: currentState.nextPageIndex,
      );

      final newImageFutures = nextDetail.thumbnailSprites.map(
        (thumb) => _getGalleryImageUseCase(thumb.url),
      );
      final List<String> newImages = await Future.wait(newImageFutures);

      emit(
        currentState.copyWith(
          images: currentState.images + newImages,
          nextPageIndex: currentState.nextPageIndex + 1,
          isFetchingMore: false,
          hasReachedMax:
              currentState.nextPageIndex + 1 >=
              currentState.galleryDetail.thumbnailPageCount,
        ),
      );
    } catch (e) {
      emit(currentState.copyWith(isFetchingMore: false));
      emitEffect(GalleryReaderLoadMoreFailure());
    }
  }
}
