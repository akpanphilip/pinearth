import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget(
      {super.key, this.message = "This page is empty", this.onReload});

  final String message;
  final Function? onReload;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GestureDetector(
        onTap: () {
          if (onReload != null) {
            onReload!();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset("moon_stars".svg),
            10.toColumnSpace(),
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            10.toColumnSpace(),
            if (onReload != null)
              Center(
                child: InkWell(
                    child: const Text(
                  'Tap to reload',
                  style: TextStyle(color: Colors.black),
                )),
              )
          ],
        ),
      ),
    );
  }
}
