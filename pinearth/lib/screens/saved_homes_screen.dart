// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../custom_widgets/custom_widgets.dart';

class SavedHomesScreen extends StatefulWidget {
  const SavedHomesScreen({super.key});

  @override
  State<SavedHomesScreen> createState() => _SavedHomesScreenState();
}

class _SavedHomesScreenState extends State<SavedHomesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AppbarTitle(
            text: 'Saved Homes',
          ),
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/exploring.png')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'You have no saved homes, like a home for it to appear here',
                style: GoogleFonts.nunito(color: Colors.black, fontSize: 16),
              ),
            ),
            SizedBox(height: 70),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color(0xff1173AB),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    'Back to homes',
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
