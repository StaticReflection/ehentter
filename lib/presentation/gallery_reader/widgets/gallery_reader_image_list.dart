import 'package:ehentter/presentation/common/eht/eht_list_view.dart';
import 'package:ehentter/presentation/common/eh/eh_network_image.dart';
import 'package:flutter/material.dart';

class GalleryReaderImageList extends StatelessWidget {
  final List<String> images;
  final VoidCallback onLoadMore;
  final bool hasReachedMax;

  const GalleryReaderImageList({
    required this.images,
    required this.onLoadMore,
    required this.hasReachedMax,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EhtListView(
      itemCount: images.length,
      hasReachedMax: hasReachedMax,
      onLoadMore: onLoadMore,
      itemBuilder: (context, index) {
        return EhNetworkImage(imageUrl: images[index]);
      },
    );
  }
}
