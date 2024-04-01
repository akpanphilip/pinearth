import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/backend/domain/services/i_local_storage_service.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/screens/root_screen.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/constants/local_storage_keys.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../profile/how_to_use_screen.dart';
import 'widgets/intro_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentScreen = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // final isEnd = currentScreen == 2;

    return Scaffold(
      body: Column(
        children: [
          62.toColumnSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              children: [
                Image.asset(
                  'intro_logo'.png,
                  height: 51,
                  width: 150,
                ),
                // 109.toRowSpace(),
                const Spacer(),

                Text(
                  "${currentScreen + 1}/3",
                  style: TextStyle(
                      fontSize: 15.toFontSize(),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),

                16.toRowSpace(),
              ],
            ),
          ),
          40.toColumnSpace(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PageView(
                onPageChanged: (currentIndex) {
                  setState(() {
                    currentScreen = currentIndex;
                  });
                },
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  SingleChildScrollView(
                    child: IntroWidget(
                      artpPath: "intro_1".svg,
                      title: "Buy a home",
                      description:
                          "Find your place with an immersive photo experience and the most listings, including things you won’t find anywhere else.",
                      buttonText: "Browse homes",
                    ),
                  ),
                  // if (currentScreen == 1)
                  SingleChildScrollView(
                    child: IntroWidget(
                      artpPath: "intro_2".svg,
                      title: "Sell a home",
                      description:
                          "No matter what path you take to sell your home, we can help you navigate a successful sale.  ",
                      buttonText: "See your options",
                    ),
                  ),
                  // if (currentScreen == 2)
                  SingleChildScrollView(
                    child: IntroWidget(
                      artpPath: "intro_3".svg,
                      title: 'Rent a home',
                      description:
                          "We’re creating a seamless online experience – from shopping on the largest rental network, to applying, to paying rent.",
                      buttonText: "Find rentals",
                    ),
                  ),
                ],
              ),
            ),
          ),
          47.toColumnSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtonWidget(
                onClick: () {
                  if (currentScreen > 0) {
                    pageController.animateToPage(currentScreen - 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  }
                },
                color: const Color(0xFF000000)
                    .withOpacity(currentScreen == 0 ? .10 : .50),
                radius: 100,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text('Back',
                      style: GoogleFonts.nunito(color: Colors.white)),
                ),
              ),
              20.toRowSpace(),
              CustomButtonWidget(
                onClick: () {
                  if (currentScreen == 2) {
                    getIt<ILocalStorageService>()
                        .setItem(appDataBoxKey, seenIntroKey, true);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HowToUse(
                                  isOnboarding: true,
                                )),
                        (route) => false);
                  } else {
                    print("current screen is $currentScreen");
                    if (currentScreen < 3) {
                      pageController.animateToPage(currentScreen + 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }
                  }
                },
                color: appColor.primary,
                radius: 100,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(currentScreen == 2 ? 'Finish' : 'Next',
                      style: GoogleFonts.nunito(color: Colors.white)),
                ),
              ),
            ],
          ),
          20.toColumnSpace(),
        ],
      ),
    );
  }
}
