import 'package:ehentter/domain/entities/eh_gallery_category.dart';
import 'package:flutter/material.dart';

class _BaseCategoryCard extends StatelessWidget {
  const _BaseCategoryCard({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: .fromLTRB(4, 2, 4, 2),
        child: Text(
          label,
          style: TextStyle(
            shadows: [
              Shadow(offset: Offset(0, 0), blurRadius: 4, color: Colors.black),
            ],
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class EhGalleryCategoryCard extends StatelessWidget {
  const EhGalleryCategoryCard(this.category, {super.key});

  final EhGalleryCategory category;

  @override
  Widget build(BuildContext context) {
    return switch (category) {
      EhGalleryCategory.doujinshi => _BaseCategoryCard(
        color: Colors.red,
        label: category.label,
      ),
      EhGalleryCategory.manga => _BaseCategoryCard(
        color: Colors.orange,
        label: category.label,
      ),
      EhGalleryCategory.artistCg => _BaseCategoryCard(
        color: Colors.yellow,
        label: category.label,
      ),
      EhGalleryCategory.gameCg => _BaseCategoryCard(
        color: Colors.green,
        label: category.label,
      ),
      EhGalleryCategory.western => _BaseCategoryCard(
        color: Colors.lightGreen,
        label: category.label,
      ),
      EhGalleryCategory.nonH => _BaseCategoryCard(
        color: Colors.lightBlueAccent,
        label: category.label,
      ),
      EhGalleryCategory.imageSet => _BaseCategoryCard(
        color: Colors.blueAccent,
        label: category.label,
      ),
      EhGalleryCategory.cosplay => _BaseCategoryCard(
        color: Colors.deepPurple,
        label: category.label,
      ),
      EhGalleryCategory.asianPorn => _BaseCategoryCard(
        color: Colors.pinkAccent,
        label: category.label,
      ),
      EhGalleryCategory.misc => _BaseCategoryCard(
        color: Colors.grey,
        label: category.label,
      ),
    };
  }
}
