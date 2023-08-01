// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';
import 'profile_screen.dart';

class MyListedPropertyScreen extends StatefulWidget {
  const MyListedPropertyScreen({super.key});

  @override
  State<MyListedPropertyScreen> createState() => _MyListedPropertyScreenState();
}

class _MyListedPropertyScreenState extends State<MyListedPropertyScreen> {
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
          text: 'My Listed Properties',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 20),
                decoration: BoxDecoration(
                    color: Color(0xfffD9D9D9),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/available-listing.png'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('My elimgbu house',
                                style: GoogleFonts.nunito(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            SizedBox(
                              width: 200,
                              child: Text(
                                '2464 Royal Ln. Mesa, New Jersey 45463',
                                style: GoogleFonts.nunito(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Image(
                              image: AssetImage('assets/images/available.png'),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Property is still \n available',
                              style: GoogleFonts.nunito(
                                  fontSize: 6, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.black26,
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 20),
                decoration: BoxDecoration(
                    color: Color(0xfffD9D9D9),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/available-listing.png'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('My eliozu house',
                                style: GoogleFonts.nunito(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            SizedBox(
                              width: 200,
                              child: Text(
                                '2464 Royal Ln. Mesa, New Jersey 45463',
                                style: GoogleFonts.nunito(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Image(
                              image:
                                  AssetImage('assets/images/unavailable.png'),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Property is not \n available',
                              style: GoogleFonts.nunito(
                                  fontSize: 6, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.black26,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
