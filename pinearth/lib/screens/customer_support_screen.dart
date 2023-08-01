// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';
import 'profile_screen.dart';

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
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
          text: 'Customer support',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xff1173AB),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Image(
                  image:
                      AssetImage('assets/images/customer-support-rocket.png')),
              SizedBox(width: 20),
              Text(
                textAlign: TextAlign.start,
                'Send your complaint to \n support@pinearth.com',
                style: GoogleFonts.nunito(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      )),
    );
  }
}
