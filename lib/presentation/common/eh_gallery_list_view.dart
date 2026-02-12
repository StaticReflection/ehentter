import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/entities/eh_gallery_summary.dart';
import 'package:ehentter/domain/entities/eh_gallery_tag_group.dart';
import 'package:ehentter/presentation/common/eh_gallery_category_card.dart';
import 'package:ehentter/presentation/common/eh_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

enum EhGalleryLayout { grid, list }

class EhGalleryListView extends StatelessWidget {
  const EhGalleryListView({
    required this.displayMode,
    required this.pageInfo,
    super.key,
  });

  final EhGalleryLayout displayMode;
  final EhGalleryPageInfo pageInfo;

  @override
  Widget build(BuildContext context) {
    return switch (displayMode) {
      EhGalleryLayout.grid => WaterfallFlow.builder(
        padding: .all(8),
        itemCount: pageInfo.galleries.length,
        gridDelegate: SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final gallery = pageInfo.galleries[index];

          return EhGalleryGridCard(gallery);
        },
      ),
      EhGalleryLayout.list => ListView.separated(
        padding: .all(8),
        itemCount: pageInfo.galleries.length,
        separatorBuilder: (_, _) => SizedBox(height: 8),
        itemBuilder: (context, index) {
          final gallery = pageInfo.galleries[index];

          return SizedBox(height: 200, child: EhGalleryListCard(gallery));
        },
      ),
    };
  }
}

class EhGalleryGridCard extends StatelessWidget {
  const EhGalleryGridCard(this.gallery, {super.key});

  final EhGallerySummary gallery;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            color: context.theme.colorScheme.surfaceContainer,
            width: .infinity,
            child: Image.network(
              gallery.thumb,
              fit: .contain,
              width: .infinity,
            ),
          ),
          Padding(
            padding: .all(4),
            child: Column(
              spacing: 4,
              crossAxisAlignment: .start,
              children: [
                Text(gallery.title, maxLines: 2, overflow: .ellipsis),
                DefaultTextStyle(
                  style: context.theme.textTheme.labelMedium ?? TextStyle(),
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          EhGalleryCategoryCard(gallery.category),
                          Text('${gallery.filecount}P'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: .spaceBetween,
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
    );
  }
}

class EhGalleryListCard extends StatelessWidget {
  const EhGalleryListCard(this.gallery, {super.key});

  final EhGallerySummary gallery;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: Container(
              color: context.theme.colorScheme.surfaceContainer,
              width: .infinity,
              child: Image.network(gallery.thumb, width: 200, fit: .contain),
            ),
          ),
          Expanded(
            child: Padding(
              padding: .symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Stack(
                    children: [
                      Text('\n'),
                      Text(gallery.title, maxLines: 2, overflow: .ellipsis),
                    ],
                  ),
                  Expanded(
                    child: DefaultTextStyle(
                      style: context.theme.textTheme.labelMedium ?? TextStyle(),
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            gallery.uploader,
                            maxLines: 1,
                            overflow: .ellipsis,
                          ),
                          Expanded(child: _EhGalleryTagsList(gallery.tags)),
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              EhGalleryCategoryCard(gallery.category),
                              Text('${gallery.filecount}P'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              EhRatingBar(rating: gallery.rating),
                              Text(
                                DateFormat(
                                  'yyyy-MM-dd HH:mm',
                                ).format(gallery.posted),
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
          ),
        ],
      ),
    );
  }
}

class _EhGalleryTagsList extends StatelessWidget {
  const _EhGalleryTagsList(this.tags);

  final List<EhGalleryTagGroup> tags;

  @override
  Widget build(BuildContext context) {
    final flattenedTags = tags
        .expand((group) => group.name.map((tagName) => tagName))
        .toList();

    return WaterfallFlow.builder(
      itemCount: flattenedTags.length,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      scrollDirection: .horizontal,
      itemBuilder: (context, index) {
        final tag = flattenedTags[index];

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: context.theme.colorScheme.surfaceContainerHighest,
          child: Padding(padding: .only(left: 4, right: 4), child: Text(tag)),
        );
      },
    );
  }
}
