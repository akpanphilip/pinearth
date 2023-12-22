// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

import '../custom_widgets/custom_widgets.dart';
import 'profile/profile_screen.dart';

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
              SvgPicture.asset('customer_support_rocket'.svg, height: 50, width: 50,),
              20.toRowSpace(),
              Expanded(
                child: Text(
                  textAlign: TextAlign.start,
                  'Send your complaint to support@pinearth.com',
                  style: GoogleFonts.nunito(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
