import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/domain/entities/eh_gallery_summary.dart';
import 'package:ehentter/presentation/common/eh_gallery_category_card.dart';
import 'package:ehentter/presentation/common/eh_network_image.dart';
import 'package:ehentter/presentation/common/eh_rating_bar.dart';
import 'package:flutter/material.dart';

class GalleryDetailHeader extends StatelessWidget {
  final EhGallerySummary summary;
  final double displayRating;

  const GalleryDetailHeader({
    super.key,
    required this.summary,
    required this.displayRating,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160,
            height: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.antiAlias,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: EhNetworkImage(
                  imageUrl: summary.thumb,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: DefaultTextStyle(
              style: context.theme.textTheme.labelMedium ?? const TextStyle(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          summary.title,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(summary.uploader),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      EhRatingBar(rating: displayRating),
                      Text(displayRating.toString()),
                      const Spacer(),
                      EhGalleryCategoryCard(summary.category),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
