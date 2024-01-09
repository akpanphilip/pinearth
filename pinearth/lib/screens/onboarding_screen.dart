// ignore_for_file: prefer_const_constructors, must_call_super, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/services/i_local_storage_service.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/screens/intro_screen/intro_screen.dart';
import 'package:pinearth/screens/root_screen.dart';
import 'package:pinearth/utils/constants/local_storage_keys.dart';

import '../providers/user/profile_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool animate = false;

  @override
  void initState() {
    startAnimation();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider).initialize(context, failSilently: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 113, 201),
      body: Center(
          child: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: animate ? 1 : 0,
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 250,
                ),
              )),
        ],
      )),
    );
  }

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(Duration(milliseconds: 5000));
    final seenIntro = await getIt<ILocalStorageService>()
        .getItem(appDataBoxKey, seenIntroKey, defaultValue: false);
    if (seenIntro) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RootScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }
}
