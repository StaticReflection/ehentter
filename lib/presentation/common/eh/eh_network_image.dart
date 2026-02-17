import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EhNetworkImage extends StatelessWidget {
  const EhNetworkImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.imageBuilder,
    super.key,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ImageWidgetBuilder? imageBuilder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      imageBuilder: imageBuilder,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: Padding(
          padding: .all(16),
          child: CircularProgressIndicator(value: downloadProgress.progress),
        ),
      ),
      errorWidget: (context, url, error) => const Padding(
        padding: .all(16),
        child: Icon(Icons.broken_image_outlined),
      ),
    );
  }
}
