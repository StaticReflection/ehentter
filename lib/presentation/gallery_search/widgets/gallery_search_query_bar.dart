import 'package:ehentter/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class GallerySearchQueryBar extends StatefulWidget {
  const GallerySearchQueryBar({required this.onQuery, super.key});

  final Function(String query) onQuery;

  @override
  State<GallerySearchQueryBar> createState() => _GallerySearchQueryBarState();
}

class _GallerySearchQueryBarState extends State<GallerySearchQueryBar> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) => widget.onQuery(value),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: context.l10n.gallery_search_textfield_hint,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message: context.l10n.clear,
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => controller.clear(),
              ),
            ),
            Tooltip(
              message: context.l10n.search,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => widget.onQuery(controller.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
