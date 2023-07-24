// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';
import 'list_property_screen.dart';

class AccountSuccess extends StatelessWidget {
  const AccountSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: AppbarTitle(
            text: 'Personal ID',
          ),
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Image(image: AssetImage('assets/images/success.png'))),
            FormTitle(text: 'Your account has been created'),
            DescriptionText(
                text:
                    'You can now list, trade and rent out properties, and many other perks!'),
            SizedBox(height: 40),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color(0xff1173AB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListPropertyScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
