// ignore_for_file: prefer_const_constructors

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/locator.dart';

import 'screens/onboarding_screen.dart';

// 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  setUpLocator();
  runApp(ProviderScope(
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  final botToastBuilder = BotToastInit();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinearth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme()
      ),
      home: const OnboardingScreen(),
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (context, child) {
        child = botToastBuilder(context,child); 
        return GestureDetector(
          onTap: () => primaryFocus!.unfocus(),
          child: child,
        );
      },
    );
  }
}
