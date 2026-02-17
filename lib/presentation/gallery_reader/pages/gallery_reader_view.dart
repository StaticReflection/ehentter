import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/presentation/common/base/base_widget.dart';
import 'package:ehentter/presentation/gallery_reader/bloc/gallery_reader_bloc.dart';
import 'package:ehentter/presentation/gallery_reader/widgets/gallery_reader_actions_bar.dart';
import 'package:ehentter/presentation/gallery_reader/widgets/gallery_reader_image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GalleryReaderView
    extends BaseWidget<GalleryReaderBloc, GalleryReaderEffect> {
  const GalleryReaderView({super.key});

  @override
  Widget buildWidget(BuildContext context, GalleryReaderBloc bloc) {
    return BlocBuilder<GalleryReaderBloc, GalleryReaderState>(
      builder: (context, state) {
        return Scaffold(
          body: switch (state) {
            GalleryReaderInitial() || GalleryReaderLoading() => Center(
              child: Column(
                spacing: 8,
                crossAxisAlignment: .center,
                mainAxisAlignment: .center,
                children: [
                  CircularProgressIndicator(),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: Text(context.l10n.back),
                  ),
                ],
              ),
            ),
            GalleryReaderLoadFailure() => Center(
              child: Column(
                spacing: 8,
                crossAxisAlignment: .center,
                mainAxisAlignment: .center,
                children: [
                  Text(state.message),
                  Row(
                    spacing: 8,
                    mainAxisAlignment: .center,
                    children: [
                      FilledButton(
                        onPressed: () =>
                            bloc.add(GalleryReaderInit(state.galleryId)),
                        child: Text(context.l10n.retry),
                      ),
                      ElevatedButton(
                        onPressed: () => context.pop(),
                        child: Text(context.l10n.back),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GalleryReaderLoaded() => Stack(
              children: [
                GestureDetector(
                  onTapUp: (details) =>
                      bloc.add(GalleryReaderToggleActionsBar()),
                  child: GalleryReaderImageList(
                    images: state.images,
                    onLoadMore: () => bloc.add(GalleryReaderLoadMore()),
                  ),
                ),
                AnimatedSlide(
                  offset: state.showActionsBar
                      ? Offset.zero
                      : const Offset(0, -1),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: SafeArea(
                    bottom: false,
                    child: GalleryReaderActionsBar(
                      title: state.galleryDetail.title,
                    ),
                  ),
                ),
              ],
            ),
          },
        );
      },
    );
  }

  @override
  void onEffect(BuildContext context, GalleryReaderEffect effect) {
    if (effect is GalleryReaderLoadMoreFailure) {
      showSnackBar(context, context.l10n.gallery_reader_load_more_fail_message);
    }
  }
}
