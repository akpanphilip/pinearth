// ignore_for_file: prefer_const_constructors, must_call_super, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pinearth/screens/root_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool animate = false;

  @override
  void initState() {
    startAnimation();
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RootScreen()));
  }
}
