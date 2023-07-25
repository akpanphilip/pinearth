// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'about_property_one_screen.dart';

class AboutPropertyTwo extends StatefulWidget {
  const AboutPropertyTwo({super.key});

  @override
  State<AboutPropertyTwo> createState() => _AboutPropertyTwoState();
}

class _AboutPropertyTwoState extends State<AboutPropertyTwo> {
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
              LabelTitle(text: 'Income Per Month'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: 'E.g 100,000 naira'),
              SizedBox(height: 20),
              LabelTitle(text: 'Year Built, Renovated And Reconstructed'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: ''),
              SizedBox(height: 20),
              LabelTitle(text: 'Is There Available Parking Space?'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: ''),
              SizedBox(height: 20),
              LabelTitle(text: 'Is There Available Parking Space?'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: ''),
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
                                  builder: (context) => AboutPropertyTwo()),
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
                                builder: (context) => AboutPropertyOne()),
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
