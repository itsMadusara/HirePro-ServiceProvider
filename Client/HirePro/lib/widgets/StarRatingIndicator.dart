import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRatingIndicator extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;
  StarRatingIndicator(this.rating, this.size, this.color);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: color,
      ),
      unratedColor: Colors.grey,
      itemCount: 5,
      itemSize: size,
      direction: Axis.horizontal,
    );
  }
}
