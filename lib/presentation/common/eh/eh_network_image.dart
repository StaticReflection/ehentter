import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EhNetworkImage extends StatelessWidget {
  const EhNetworkImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholder = const Center(
      child: Padding(padding: .all(16), child: CircularProgressIndicator()),
    ),
    this.imageBuilder,
    super.key,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget placeholder;
  final ImageWidgetBuilder? imageBuilder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      imageBuilder: imageBuilder,
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => const Padding(
        padding: .all(16),
        child: Icon(Icons.broken_image_outlined),
      ),
    );
  }
}
