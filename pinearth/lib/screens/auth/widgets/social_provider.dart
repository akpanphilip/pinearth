import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../providers/auth/register_provider.dart';
import '../../../utils/styles/colors.dart';

class SocialProvider extends ConsumerWidget {
  const SocialProvider(
      {super.key,
      required this.title,
      required this.image,
      this.isLoading = false,
      required this.function});

  final String title;
  final String image;
  final bool isLoading;
  final Function() function;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        function();
      },
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: appColor.primary,
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            (isLoading)
                ? CupertinoActivityIndicator(
                    color: appColor.primary,
                  )
                : Image.asset(
                    image,
                    width: 50,
                    height: 20,
                  ),
            const SizedBox(width: 10),
            Text(title,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600,
                  color: appColor.primary,
                  fontSize: 16,
                )),
          ])),
    );
  }
}
