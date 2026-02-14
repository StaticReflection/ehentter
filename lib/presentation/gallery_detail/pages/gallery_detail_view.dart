import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/domain/entities/eh_gallery_tag_group.dart';
import 'package:ehentter/domain/entities/eh_thumbnail_sprite.dart';
import 'package:ehentter/presentation/common/base/base_widget.dart';
import 'package:ehentter/presentation/common/eh_gallery_category_card.dart';
import 'package:ehentter/presentation/common/eh_network_image.dart';
import 'package:ehentter/presentation/common/eh_rating_bar.dart';
import 'package:ehentter/presentation/gallery_detail/bloc/gallery_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryDetailView
    extends BaseWidget<GalleryDetailBloc, GalleryDetailEffect> {
  const GalleryDetailView({super.key});

  @override
  Widget buildWidget(BuildContext context, GalleryDetailBloc bloc) {
    return BlocBuilder<GalleryDetailBloc, GalleryDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.gallery_detail_title)),
          body: switch (state) {
            GalleryDetailInitial() => const Center(
              child: CircularProgressIndicator(),
            ),

            GalleryDetailStateWithSummary(:final summary) => Builder(
              builder: (context) {
                final double displayRating = state is GalleryDetailLoaded
                    ? state.detail.rating
                    : summary.rating;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    spacing: 8,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Row(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 160,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: .circular(8),
                                  child: EhNetworkImage(
                                    imageUrl: summary.thumb,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: DefaultTextStyle(
                                style:
                                    context.theme.textTheme.labelMedium ??
                                    const TextStyle(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            summary.title,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: context
                                                .theme
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(summary.uploader),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        EhRatingBar(rating: displayRating),
                                        Text(displayRating.toString()),
                                        const Spacer(),
                                        EhGalleryCategoryCard(summary.category),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(height: 1),

                      if (state is GalleryDetailLoaded) ...[
                        GalleryDetailTagList(state.detail.tags),

                        const Divider(height: 1),
                        GalleryDetailThumbnailSprites(
                          sprites: state.detail.thumbnailSprites,
                          onTap: (index) {},
                        ),
                      ] else if (state is GalleryDetailLoading) ...[
                        const CircularProgressIndicator(),
                      ] else if (state is GalleryDetailLoadFailure) ...[
                        Center(child: Text(state.message)),
                      ],
                    ],
                  ),
                );
              },
            ),
          },
        );
      },
    );
  }

  @override
  void onEffect(BuildContext context, effect) {
    // TODO: implement onEffect
  }
}

class GalleryDetailThumbnailSprites extends StatelessWidget {
  final List<EhThumbnailSprite> sprites;
  final Function(int index) onTap;

  const GalleryDetailThumbnailSprites({
    super.key,
    required this.sprites,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (sprites.isEmpty) return const SizedBox.shrink();

    final double spriteRatio =
        sprites.first.size.width /
        (sprites.first.size.height +
            context.theme.textTheme.bodyMedium!.fontSize!);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: spriteRatio,
      ),
      itemCount: sprites.length,
      itemBuilder: (context, index) {
        final sprite = sprites[index];
        return ClipRRect(
          child: GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              children: [
                Expanded(
                  child: EhNetworkImage(
                    imageUrl: sprite.thumb,
                    imageBuilder: (context, imageProvider) {
                      return FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: sprite.size.width,
                            height: sprite.size.height,
                            child: OverflowBox(
                              alignment: Alignment.topLeft,
                              maxWidth: double.infinity,
                              maxHeight: double.infinity,
                              child: Transform.translate(
                                offset: sprite.offset,
                                child: Image(
                                  image: imageProvider,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Text((index + 1).toString()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GalleryDetailTagList extends StatelessWidget {
  const GalleryDetailTagList(this.tagGroups, {super.key});

  final List<EhGalleryTagGroup> tagGroups;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: tagGroups.length,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        final group = tagGroups[index];

        return Row(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            Card.filled(
              color: context.theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: .all(4),
                child: Text(group.namespace.name),
              ),
            ),
            Expanded(
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: group.name
                    .map(
                      (name) => Card(
                        color: context.theme.colorScheme.surfaceContainer,
                        child: Padding(padding: .all(4), child: Text(name)),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
