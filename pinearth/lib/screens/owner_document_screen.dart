// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/screens/how_it_works_screen.dart';

import '../custom_widgets/custom_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'about_property_one_screen.dart';

class OwnerDocument extends StatefulWidget {
  const OwnerDocument({super.key});

  @override
  State<OwnerDocument> createState() => _OwnerDocumentState();
}

class _OwnerDocumentState extends State<OwnerDocument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        backgroundColor: Colors.white,
        title: AppbarTitle(
          text: 'Owner\'s documents',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Upload image of Document for house'),
                  Text(
                    '*60 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(height: 10),
              UploadImg(),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Upload image of House plan'),
                  Text(
                    '*60 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(height: 10),
              UploadImg(),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Upload image of House size & dimensions'),
                  Text(
                    '*60 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(height: 10),
              UploadImg(),
              SizedBox(height: 40),
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
                          onPressed: () {},
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
                                builder: (context) => HowItWorks()),
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
