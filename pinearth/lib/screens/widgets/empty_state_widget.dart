import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.message = "This page is empty",
    required this.onReload
  });

  final String message;
  final Function onReload;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset("moon_stars".svg),
          10.toColumnSpace(),
          Text(message, style: const TextStyle(
            color: Colors.black,
          ), textAlign: TextAlign.center,),
          10.toColumnSpace(),
          Center(
            child: InkWell(
              onTap: () => onReload(),
              child: const Text('Tap to reload', style: TextStyle(
                color: Colors.black
              ),)
            ),
          )
        ],
      ),
    );
  }
}