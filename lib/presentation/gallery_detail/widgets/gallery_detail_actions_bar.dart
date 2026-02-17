import 'package:ehentter/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class GalleryDetailActionsBar extends StatelessWidget {
  const GalleryDetailActionsBar({required this.onTapRead, super.key});

  final VoidCallback onTapRead;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _Action(
          icon: const Icon(Icons.auto_stories),
          title: context.l10n.read,
          onTap: onTapRead,
        ),
      ],
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
    return SizedBox(
      width: 76,
      height: 76,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(title, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}
