import 'package:ehentter/domain/entities/eh_gallery_detail.dart';
import 'package:ehentter/presentation/gallery_detail/widgets/gallery_detail_actions_bar.dart';
import 'package:ehentter/presentation/gallery_detail/widgets/gallery_detail_tag_list.dart';
import 'package:ehentter/presentation/gallery_detail/widgets/gallery_detail_thumbnail_sprites.dart';
import 'package:flutter/material.dart';

class GalleryDetailOverviewTab extends StatelessWidget {
  const GalleryDetailOverviewTab({
    required this.galleryDetail,
    required this.onTapRead,
    super.key,
  });

  final EhGalleryDetail galleryDetail;
  final VoidCallback onTapRead;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: .start,
      children: [
        GalleryDetailActionsBar(onTapRead: () => onTapRead()),
        const Divider(height: 1),
        GalleryDetailTagList(tagGroups: galleryDetail.tags),
        const Divider(height: 1),
        GalleryDetailThumbnailSprites(
          sprites: galleryDetail.thumbnailSprites,
          onTap: (index) {},
        ),
      ],
    );
  }
}
