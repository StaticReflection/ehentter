import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/presentation/common/base/base_widget.dart';
import 'package:ehentter/presentation/gallery_detail/bloc/gallery_detail_bloc.dart';
import 'package:ehentter/presentation/gallery_detail/widgets/gallery_detail_header.dart';
import 'package:ehentter/presentation/gallery_detail/widgets/gallery_detail_tag_list.dart';
import 'package:ehentter/presentation/gallery_detail/widgets/gallery_detail_thumbnail_sprites.dart';
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
                      GalleryDetailHeader(
                        summary: summary,
                        displayRating: displayRating,
                      ),

                      const Divider(height: 1),

                      if (state is GalleryDetailLoaded) ...[
                        GalleryDetailTagList(tagGroups: state.detail.tags),
                        const Divider(height: 1),
                        GalleryDetailThumbnailSprites(
                          sprites: state.detail.thumbnailSprites,
                          onTap: (index) {},
                        ),
                      ] else if (state is GalleryDetailLoading) ...[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
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
