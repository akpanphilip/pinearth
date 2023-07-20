// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/onboarding_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:iconly/iconly.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinearth',
      theme: ThemeData(
        primaryColor: Color(0x0f1173AB), // Set the primary color
      ),
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}
