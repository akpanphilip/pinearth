import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/firebase_options.dart';
import 'package:pinearth/locator.dart';

import 'screens/onboarding_screen.dart';
import 'utils/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load();
  setUpLocator();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final botToastBuilder = BotToastInit();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: appColor.primary));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinearth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.nunitoTextTheme()),
      home: const OnboardingScreen(),
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return GestureDetector(
          onTap: () => primaryFocus!.unfocus(),
          child: child,
        );
      },
    );
  }
}
