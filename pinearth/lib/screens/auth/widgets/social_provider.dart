import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/styles/colors.dart';

class SocialProvider extends StatelessWidget {
  const SocialProvider({super.key, required this.title, required this.image,required this.onTap});

  final String title;
  final String image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: appColor.primary,
            ),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Image.asset(image,width: 50,height: 20,),
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
