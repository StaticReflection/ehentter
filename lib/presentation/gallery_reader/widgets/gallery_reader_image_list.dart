import 'package:ehentter/presentation/common/eh_network_image.dart';
import 'package:flutter/material.dart';

class GalleryReaderImageList extends StatelessWidget {
  final List<String> images;
  final VoidCallback onLoadMore;

  const GalleryReaderImageList({
    required this.images,
    required this.onLoadMore,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length + 1,
      itemBuilder: (context, index) {
        if (index == images.length) {
          onLoadMore();
          return const Center(child: CircularProgressIndicator());
        }
        return EhNetworkImage(imageUrl: images[index]);
      },
    );
  }
}
