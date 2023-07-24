// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../custom_widgets/custom_widgets.dart';

class PersonalID extends StatefulWidget {
  const PersonalID({super.key});

  @override
  State<PersonalID> createState() => _PersonalIDState();
}

class _PersonalIDState extends State<PersonalID> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Center(
          child: Column(
            children: [
              MidTitle(text: 'UPLOAD YOUR ID'),
              DescriptionText(
                text:
                    'We need to verify your identity to be sure you are who you say you are',
              ),
              SizedBox(height: 30),
              UploadId(
                img: 'assets/images/nin.png',
                text: 'NIN / NATIONAL ID',
              ),
              SizedBox(height: 10),
              UploadId(
                img: 'assets/images/driver-license.png',
                text: 'DRIVERS LICENSE',
              ),
              SizedBox(height: 10),
              UploadId(
                img: 'assets/images/internation-passport.png',
                text: 'INTERNATIONAL PASSPORT',
              ),
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
                          MaterialPageRoute(builder: (context) => PersonalID()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Next',
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
      ),
    );
  }
}
