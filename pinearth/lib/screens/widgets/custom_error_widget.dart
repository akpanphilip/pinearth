import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.message,
    this.onReload,
    this.showErrorImage = false,
  });

  final bool showErrorImage;
  final String message;
  final Function? onReload;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showErrorImage) ...[
            SvgPicture.asset("moon_stars".svg),
            10.toColumnSpace(),
          ],
          Text(
            message,
            style: const TextStyle(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          10.toColumnSpace(),
          if (onReload != null)
            InkWell(
                onTap: () => onReload!(),
                child: const Text(
                  'Tap to refresh',
                  style: TextStyle(color: Colors.black),
                ))
        ],
      ),
    );
  }
}
