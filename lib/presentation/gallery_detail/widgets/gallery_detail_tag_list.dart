import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/domain/entities/eh_gallery_tag_group.dart';
import 'package:flutter/material.dart';

class GalleryDetailTagList extends StatelessWidget {
  const GalleryDetailTagList({super.key, required this.tagGroups});

  final List<EhGalleryTagGroup> tagGroups;

  @override
  Widget build(BuildContext context) {
    if (tagGroups.isEmpty) return const SizedBox.shrink();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tagGroups.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final group = tagGroups[index];
        return Row(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: context.theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(group.namespace.name),
              ),
            ),
            Expanded(
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: group.name
                    .map(
                      (name) => Card(
                        color: context.theme.colorScheme.surfaceContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(name),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
