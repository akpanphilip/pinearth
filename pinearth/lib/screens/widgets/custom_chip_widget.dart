import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class CustomChipWidget extends StatelessWidget {
  const CustomChipWidget({
    super.key,
    required this.label,
    this.color
  });

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34, width: 102,
      decoration: BoxDecoration(
        color: color ?? appColor.chipBackground,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(100)
      ),
      child: Center(
        child: Text("$label", style: TextStyle(
          fontSize: 12.toFontSize(),
          fontWeight: FontWeight.w400,
          color: appColor.primary
        ),),
      ),
    );
  }
}