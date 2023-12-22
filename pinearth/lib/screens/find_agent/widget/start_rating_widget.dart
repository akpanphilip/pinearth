
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    super.key,
    this.rating = 0
  });

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(rating, (index) => SvgPicture.asset('star_checked'.svg)).toList(),
        ...List.generate(5-rating, (index) => SvgPicture.asset('star_unchecked'.svg)).toList()
      ],
    );
  }
}