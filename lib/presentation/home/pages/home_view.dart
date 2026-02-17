import 'package:ehentter/presentation/common/eht/eht_gallery_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/presentation/common/base/base_widget.dart';
import 'package:ehentter/presentation/home/bloc/home_bloc.dart';

class HomeView extends BaseWidget<HomeBloc, HomeEffect> {
  const HomeView({super.key});

  @override
  Widget buildWidget(BuildContext context, HomeBloc bloc) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.app_title)),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() ||
            HomeLoading() => const Center(child: CircularProgressIndicator()),
            HomeLoadFailure() => Center(
              child: SelectableText(state.errorMessage),
            ),
            HomeLoaded() => Center(
              child: EhtGalleryView(
                displayMode: .list,
                pageInfo: state.galleryPageInfo,
                onLoadMore: () => bloc.add(HomeLoadNextPage()),
              ),
            ),
          };
        },
      ),
    );
  }

  @override
  void onEffect(BuildContext context, HomeEffect effect) {
    if (effect is HomeLoadMoreFailure) {
      showSnackBar(context, effect.message);
    }
  }
}
