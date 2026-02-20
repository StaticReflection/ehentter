import 'package:bloc/bloc.dart';
import 'package:ehentter/core/bloc/base_bloc.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/usecases/eh/get_gallery_page_info_use_case.dart';
import 'package:meta/meta.dart';

part 'gallery_search_event.dart';
part 'gallery_search_state.dart';
part 'gallery_search_effect.dart';

class GallerySearchBloc
    extends
        BaseBloc<GallerySearchEvent, GallerySearchState, GallerySearchEffect> {
  final GetGalleryPageInfoUseCase _getGalleryPageInfoUseCase;

  GallerySearchBloc(this._getGalleryPageInfoUseCase)
    : super(GallerySearchInitial()) {
    on<GallerySearchInit>(_onInit);
    on<GallerySearchQuery>(_onQuery);
    on<GallerySearchLoadNextPage>(_onLoadNextPage);
  }

  Future<void> _onInit(
    GallerySearchInit event,
    Emitter<GallerySearchState> emit,
  ) async {
    emit(GallerySearchLoading());
    emit(GallerySearchUnQuery());
  }

  Future<void> _onQuery(
    GallerySearchQuery event,
    Emitter<GallerySearchState> emit,
  ) async {
    emit(GallerySearchQuerying());
    try {
      final pageInfo = await _getGalleryPageInfoUseCase(query: event.query);

      emit(
        GallerySearchQueried(
          pageInfo: pageInfo,
          currentPageIndex: 0,
          hasReachedMax: pageInfo.nextGid == null,
        ),
      );
    } catch (e) {
      emit(GallerySearchFailure(e.toString()));
    }
  }

  Future<void> _onLoadNextPage(
    GallerySearchLoadNextPage event,
    Emitter<GallerySearchState> emit,
  ) async {
    final currentState = state;
    if (currentState is GallerySearchQueried &&
        !currentState.isFetchingMore &&
        !currentState.hasReachedMax) {
      emit(currentState.copyWith(isFetchingMore: true));

      try {
        final newPageInfo = await _getGalleryPageInfoUseCase.call(
          nextGid: currentState.pageInfo.nextGid,
        );

        final updatedGalleries = [
          ...currentState.pageInfo.galleries,
          ...newPageInfo.galleries,
        ];

        emit(
          currentState.copyWith(
            isFetchingMore: false,
            hasReachedMax: newPageInfo.nextGid == null,
            pageInfo: newPageInfo.copyWith(galleries: updatedGalleries),
          ),
        );
      } catch (e) {
        emit(GallerySearchFailure(e.toString()));
      }
    }
  }
}
