// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';
import 'profile_screen.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: AppbarTitle(
          text: 'Security',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelTitle(text: 'Change phone number'),
              SizedBox(height: 10),
              CustomTextField(obscureText: false, hintText: '(406) 555-0120'),
              SizedBox(height: 20),
              LabelTitle(text: 'Change password'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: ''),
              SizedBox(height: 10),
              LabelTitle(text: 'Repeat password'),
              SizedBox(height: 10),
              CustomTextField(obscureText: false, hintText: ''),
              SizedBox(height: 80),
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
                              builder: (context) => ProfileScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Save',
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
      )),
    );
  }
}