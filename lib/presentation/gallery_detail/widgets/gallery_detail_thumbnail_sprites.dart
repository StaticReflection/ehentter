import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/domain/entities/eh_thumbnail_sprite.dart';
import 'package:ehentter/presentation/common/eh/eh_network_image.dart';
import 'package:flutter/material.dart';

class GalleryDetailThumbnailSprites extends StatelessWidget {
  final List<EhThumbnailSprite> sprites;
  final Function(int index) onTap;

  const GalleryDetailThumbnailSprites({
    super.key,
    required this.sprites,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (sprites.isEmpty) return const SizedBox.shrink();

    final double spriteRatio =
        sprites.first.size.width /
        (sprites.first.size.height +
            (context.theme.textTheme.bodyMedium?.fontSize ?? 14));

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: spriteRatio,
      ),
      itemCount: sprites.length,
      itemBuilder: (context, index) {
        final sprite = sprites[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              children: [
                Expanded(
                  child: EhNetworkImage(
                    imageUrl: sprite.thumb,
                    imageBuilder: (context, imageProvider) {
                      return FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: sprite.size.width,
                            height: sprite.size.height,
                            child: OverflowBox(
                              alignment: Alignment.topLeft,
                              maxWidth: double.infinity,
                              maxHeight: double.infinity,
                              child: Transform.translate(
                                offset: sprite.offset,
                                child: Image(
                                  image: imageProvider,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text((index + 1).toString()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
