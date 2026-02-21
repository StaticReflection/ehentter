import 'package:ehentter/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class GalleryDetailActionsBar extends StatelessWidget {
  const GalleryDetailActionsBar({required this.onTapRead, super.key});

  final VoidCallback onTapRead;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 8,
          children: [
            _Action(
              icon: const Icon(Icons.auto_stories),
              title: context.l10n.read,
              onTap: onTapRead,
            ),
          ],
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.title, required this.onTap});

  final Widget icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              icon,
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
