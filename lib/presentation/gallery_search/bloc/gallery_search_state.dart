part of 'gallery_search_bloc.dart';

@immutable
sealed class GallerySearchState {}

final class GallerySearchInitial extends GallerySearchState {}

// 页面加载比如获取本地的搜索历史记录
final class GallerySearchLoading extends GallerySearchState {}

// 点进来就没搜索过
final class GallerySearchUnQuery extends GallerySearchState {}

// 正在搜索
final class GallerySearchQuerying extends GallerySearchState {}

// 搜索完成
final class GallerySearchQueried extends GallerySearchState {
  final EhGalleryPageInfo pageInfo;
  final int currentPageIndex;
  final bool hasReachedMax;
  final bool isFetchingMore;

  GallerySearchQueried({
    required this.pageInfo,
    required this.currentPageIndex,
    this.isFetchingMore = false,
    this.hasReachedMax = false,
  });

  GallerySearchQueried copyWith({
    EhGalleryPageInfo? pageInfo,
    int? currentPageIndex,
    bool? isFetchingMore,
    bool? hasReachedMax,
  }) {
    return GallerySearchQueried(
      pageInfo: pageInfo ?? this.pageInfo,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class GallerySearchFailure extends GallerySearchState {
  final String message;

  GallerySearchFailure(this.message);
}
