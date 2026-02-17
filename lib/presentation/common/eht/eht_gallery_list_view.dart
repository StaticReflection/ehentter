import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/core/router/app_router.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/entities/eh_gallery_summary.dart';
import 'package:ehentter/domain/entities/eh_gallery_tag_group.dart';
import 'package:ehentter/presentation/common/eh/eh_gallery_category_card.dart';
import 'package:ehentter/presentation/common/eh/eh_network_image.dart';
import 'package:ehentter/presentation/common/eh/eh_rating_bar.dart';
import 'package:ehentter/presentation/common/eht/eht_list_view.dart';
import 'package:ehentter/presentation/common/eht/eht_waterfall.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

enum EhtGalleryViewLayout { waterfall, list }

class EhtGalleryView extends StatelessWidget {
  const EhtGalleryView({
    required this.displayMode,
    required this.pageInfo,
    required this.onLoadMore,
    this.onRefresh,
    this.hasReachedMax = false,
    super.key,
  });

  final EhtGalleryViewLayout displayMode;
  final EhGalleryPageInfo pageInfo;
  final VoidCallback onLoadMore;
  final RefreshCallback? onRefresh;
  final bool hasReachedMax;

  @override
  Widget build(BuildContext context) {
    final galleries = pageInfo.galleries;

    return switch (displayMode) {
      EhtGalleryViewLayout.waterfall => EhtWaterfall(
        itemCount: galleries.length,
        hasReachedMax: hasReachedMax,
        onLoadMore: onLoadMore,
        onRefresh: onRefresh,
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) => EhtGalleryGridCard(galleries[index]),
      ),
      EhtGalleryViewLayout.list => EhtListView(
        itemCount: galleries.length,
        hasReachedMax: hasReachedMax,
        onLoadMore: onLoadMore,
        onRefresh: onRefresh,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 200,
            child: EhtGalleryListCard(galleries[index]),
          );
        },
      ),
    };
  }
}

// --- Card Components 保持不变 ---

class EhtGalleryGridCard extends StatelessWidget {
  const EhtGalleryGridCard(this.gallery, {super.key});

  final EhGallerySummary gallery;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // 剪裁边缘
      child: InkWell(
        onTap: () => context.push(AppRouter.galleryDetail, extra: gallery),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: context.theme.colorScheme.surfaceContainer,
              width: double.infinity,
              child: EhNetworkImage(imageUrl: gallery.thumb),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gallery.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  DefaultTextStyle(
                    style:
                        context.theme.textTheme.labelMedium ??
                        const TextStyle(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EhGalleryCategoryCard(gallery.category),
                            Text('${gallery.filecount}P'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EhRatingBar(rating: gallery.rating),
                            Text(
                              DateFormat('MM-dd HH:mm').format(gallery.posted),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EhtGalleryListCard extends StatelessWidget {
  const EhtGalleryListCard(this.gallery, {super.key});

  final EhGallerySummary gallery;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRouter.galleryDetail, extra: gallery),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Container(
                color: context.theme.colorScheme.surfaceContainer,
                child: EhNetworkImage(imageUrl: gallery.thumb),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gallery.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      gallery.uploader,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.textTheme.labelSmall,
                    ),
                    const SizedBox(height: 4),
                    Expanded(child: _EhtGalleryTagsList(gallery.tags)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EhGalleryCategoryCard(gallery.category),
                        Text('${gallery.filecount}P'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EhRatingBar(rating: gallery.rating),
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm').format(gallery.posted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EhtGalleryTagsList extends StatelessWidget {
  const _EhtGalleryTagsList(this.tags);

  final List<EhGalleryTagGroup> tags;

  @override
  Widget build(BuildContext context) {
    final flattenedTags = tags.expand((group) => group.name).toList();

    return WaterfallFlow.builder(
      itemCount: flattenedTags.length,
      gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: context.theme.colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Center(
              child: Text(
                flattenedTags[index],
                style: context.theme.textTheme.labelSmall,
              ),
            ),
          ),
        );
      },
    );
  }
}
