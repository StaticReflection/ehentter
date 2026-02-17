import 'package:ehentter/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GalleryReaderActionsBar extends StatelessWidget {
  const GalleryReaderActionsBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      color: context.theme.colorScheme.surfaceContainer,
      padding: .all(8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back),
          ),
          Expanded(child: Text(title, overflow: .ellipsis, maxLines: 1)),
        ],
      ),
    );
  }
}
