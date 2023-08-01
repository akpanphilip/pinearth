// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

import 'about_property_two_screen.dart';

class AboutPropertyOne extends StatefulWidget {
  const AboutPropertyOne({super.key});

  @override
  State<AboutPropertyOne> createState() => _AboutPropertyOneState();
}

class _AboutPropertyOneState extends State<AboutPropertyOne> {
  @override
  Widget build(BuildContext context) {
    List<String> dropdownItems = ['Select your option', 'Sell property'];

    String selectedOption =
        dropdownItems[0]; // Set the initial selected option (if desired)

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: AppbarTitle(
          text: 'Tell us about this property',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelTitle(text: 'Property Type'),
              SizedBox(height: 10),
              CustomTextField(
                  obscureText: true, hintText: 'E.g (bungalow etc)'),
              SizedBox(height: 20),
              LabelTitle(text: 'Number of rooms'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: 'E.g 1 room'),
              SizedBox(height: 20),
              LabelTitle(text: 'number of bathroom\'s'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: 'E.g 3 bathrooms'),
              SizedBox(height: 20),
              LabelTitle(text: 'Lot size(sqft)'),
              SizedBox(height: 10),
              CustomTextField(
                  obscureText: true, hintText: 'E.g 173 Square feet'),
              SizedBox(height: 20),
              LabelTitle(text: 'Address Of Property'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: '2118 Thromming'),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Color.fromARGB(162, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPropertyOne()),
                            );
                          },
                          child: Text('Back', style: GoogleFonts.nunito()))),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xff1173AB),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPropertyTwo()),
                          );
                        },
                        child: Text('Continue', style: GoogleFonts.nunito())),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
