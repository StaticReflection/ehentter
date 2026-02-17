import 'package:flutter/material.dart';

class EhRatingBar extends StatelessWidget {
  final double rating;
  final double size;

  const EhRatingBar({super.key, required this.rating, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) => Icon(Icons.star_rounded, size: size, color: Colors.grey),
          ),
        ),
        ClipRect(
          clipper: _RatingClipper(rating),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              5,
              (index) =>
                  Icon(Icons.star_rounded, size: size, color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }
}

class _RatingClipper extends CustomClipper<Rect> {
  final double rating;

  _RatingClipper(this.rating);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * (rating / 5), size.height);
  }

  @override
  bool shouldReclip(_RatingClipper oldClipper) => oldClipper.rating != rating;
}
