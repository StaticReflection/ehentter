import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EhNetworkImage extends StatelessWidget {
  const EhNetworkImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.aspectRatio = 3 / 4,
    super.key,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => AspectRatio(
        aspectRatio: aspectRatio,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => AspectRatio(
        aspectRatio: aspectRatio,
        child: Icon(Icons.broken_image_outlined),
      ),
    );
  }
}
