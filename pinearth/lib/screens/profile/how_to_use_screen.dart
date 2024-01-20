import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

import '../../custom_widgets/custom_widgets.dart';
import 'how_to_use_video_tutorials_screen.dart';

class HowToUse extends StatefulWidget {
  const HowToUse({super.key});

  @override
  State<HowToUse> createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: const AppbarTitle(
          text: 'How to use',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              ActionCard(forUser: true, svgImage: "a_user".svg),
              const SizedBox(
                height: 50,
              ),
              ActionCard(forUser: false, svgImage: "a_business".svg),
            ],
          ),
        ),
      )),
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard(
      {super.key, required this.forUser, this.image, this.svgImage});

  final bool forUser;
  final String? image;
  final String? svgImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HowToUseVideoTutorialScreen(
                      forUser: forUser,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black.withOpacity(.2))),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: (svgImage != null)
                    ? SvgPicture.asset(svgImage!)
                    : Image.asset(image!)),
            const SizedBox(
              height: 10,
            ),
            Text(
              (forUser) ? '"I am a user"' : '"I am a business"',
              style:
                  GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "View how-to-use",
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
