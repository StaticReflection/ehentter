import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/presentation/common/base/base_widget.dart';
import 'package:ehentter/presentation/common/eht/eht_gallery_list_view.dart';
import 'package:ehentter/presentation/gallery_search/bloc/gallery_search_bloc.dart';
import 'package:ehentter/presentation/gallery_search/widgets/gallery_search_query_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GallerySearchView
    extends BaseWidget<GallerySearchBloc, GallerySearchEffect> {
  const GallerySearchView({super.key});

  @override
  Widget buildWidget(BuildContext context, GallerySearchBloc bloc) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<GallerySearchBloc, GallerySearchState>(
          buildWhen: (previous, current) =>
              current is GallerySearchQueried ||
              current is GallerySearchInitial,
          builder: (context, state) {
            if (state is GallerySearchQueried) {
              return Text(
                '${context.l10n.gallery_search_title} (${state.pageInfo.resultCount})',
                maxLines: 1,
                overflow: .ellipsis,
              );
            }
            return Text(context.l10n.gallery_search_title);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: GallerySearchQueryBar(
            onQuery: (query) => bloc.add(GallerySearchQuery(query)),
          ),
        ),
      ),
      body: BlocBuilder<GallerySearchBloc, GallerySearchState>(
        builder: (context, state) {
          return switch (state) {
            GallerySearchInitial() ||
            GallerySearchQuerying() ||
            GallerySearchLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            GallerySearchUnQuery() => Placeholder(),
            GallerySearchFailure() => SingleChildScrollView(
              child: Center(child: SelectableText(state.message)),
            ),
            GallerySearchQueried() => EhtGalleryView(
              displayMode: .list,
              hasReachedMax: state.hasReachedMax,
              pageInfo: state.pageInfo,
              onLoadMore: () => bloc.add(GallerySearchLoadNextPage()),
            ),
          };
        },
      ),
    );
  }

  @override
  void onEffect(BuildContext context, GallerySearchEffect effect) {
    // TODO: implement onEffect
  }
}
