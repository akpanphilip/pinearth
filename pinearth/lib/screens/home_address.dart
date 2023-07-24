// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';

class HomeAddress extends StatefulWidget {
  const HomeAddress({super.key});

  @override
  State<HomeAddress> createState() => _HomeAddressState();
}

class _HomeAddressState extends State<HomeAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AppbarTitle(
              text: 'Home Address',
            ),
          ),
          centerTitle: false,
          elevation: 0.5,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image(
                        image:
                            AssetImage('assets/images/connection-lost.png'))),
                SizedBox(height: 50),
                Center(
                  child: Text(
                    'YOU\'RE ALMOST DONE...',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 40),
                LabelTitle(text: 'Address'),
                SizedBox(height: 10),
                CustomTextField(
                    obscureText: false, hintText: 'Where do you live?'),
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
                                builder: (context) => HomeAddress()),
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
        ));
  }
}
