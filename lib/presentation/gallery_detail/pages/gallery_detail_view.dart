import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/core/router/app_router.dart';
import 'package:ehentter/presentation/common/base/base_widget.dart';
import 'package:ehentter/presentation/gallery_detail/bloc/gallery_detail_bloc.dart';
import 'package:ehentter/presentation/gallery_detail/pages/gallery_detail_comments_tab.dart';
import 'package:ehentter/presentation/gallery_detail/widgets/gallery_detail_header.dart';
import 'package:ehentter/presentation/gallery_detail/pages/gallery_detail_overview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
            GalleryDetailStateWithSummary(:final summary) =>
              DefaultTabController(
                length: 2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GalleryDetailHeader(
                        summary: summary,
                        displayRating: state is GalleryDetailLoaded
                            ? state.detail.rating
                            : summary.rating,
                      ),
                      const SizedBox(height: 8),
                      const Divider(height: 1),
                      if (state is GalleryDetailLoaded) ...[
                        TabBar(
                          tabs: [
                            Tab(text: context.l10n.overview),
                            Tab(text: context.l10n.comment),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Builder(
                          builder: (context) {
                            final tabController = DefaultTabController.of(
                              context,
                            );
                            return ListenableBuilder(
                              listenable: tabController,
                              builder: (context, _) {
                                return switch (tabController.index) {
                                  0 => GalleryDetailOverviewTab(
                                    galleryDetail: state.detail,
                                    onTapRead: () =>
                                        bloc.add(GalleryDetailReadPressed()),
                                  ),
                                  1 => GalleryDetailCommentsTab(
                                    state.detail.comments,
                                  ),
                                  _ => const SizedBox.shrink(),
                                };
                              },
                            );
                          },
                        ),
                      ] else if (state is GalleryDetailLoading) ...[
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ] else if (state is GalleryDetailLoadFailure) ...[
                        Center(child: Text(state.message)),
                      ],
                    ],
                  ),
                ),
              ),
          },
        );
      },
    );
  }

  @override
  void onEffect(BuildContext context, effect) {
    if (effect is GalleryDetailNavigateToReader) {
      context.push(AppRouter.galleryReader, extra: effect.galleryId);
    }
  }
}
