// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/screens/auth/register/account_success_screen.dart';
import 'package:pinearth/screens/list_property/widgets/property_listing_back_button.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../custom_widgets/custom_widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

import 'property_spec_screen.dart';
import 'listed_complete_screen.dart';

class PropertyPreviewScreen extends StatefulWidget {
  const PropertyPreviewScreen({super.key});

  @override
  State<PropertyPreviewScreen> createState() => _PropertyPreviewScreenState();
}

class _PropertyPreviewScreenState extends State<PropertyPreviewScreen> {
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
          text: 'Here\'s how it works',
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
              Container(
                margin: EdgeInsets.all(10),
                width: 320,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Color(0xffE6F1F7), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffE6F1F7),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 185,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          image: DecorationImage(
                              image: AssetImage('assets/images/property.png'),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: [
                          Positioned(
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 25),
                                    child: Text('For rent',
                                        style: GoogleFonts.nunito(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                  )),
                              top: 20,
                              right: 15),
                          Positioned(
                              bottom: 20,
                              right: 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            "assets/images/view.png"),
                                      ),
                                      SizedBox(width: 10),
                                      Image(
                                        image: AssetImage(
                                            "assets/images/location.png"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text('10',
                                        style: GoogleFonts.nunito(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('50.00',
                              style: GoogleFonts.nunito(
                                  color: Color(0xff1173AB),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(height: 5),
                          Text(
                            'random',
                            style: GoogleFonts.nunito(
                                color: Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                          Text('lorem random text goes here',
                              style: GoogleFonts.nunito(
                                  color: Color(0xff000000),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color(0xff000000), width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/house.svg', // Replace with the path to your SVG file
                                          width: 13,
                                          height: 13,
                                        ),
                                        Text('5 bedroom flat',
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff000000),
                                                fontSize: 7))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color(0xff000000), width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/bathroom.svg', // Replace with the path to your SVG file
                                          width: 13,
                                          height: 13,
                                        ),
                                        Text('3 bathrooms',
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff000000),
                                                fontSize: 7))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color(0xff000000), width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/feet.svg', // Replace with the path to your SVG file
                                          width: 13,
                                          height: 13,
                                        ),
                                        Text('4 sqr feet',
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff000000),
                                                fontSize: 7))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 33,
                                      height: 33,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/agent.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Adam Silver',
                                            style: GoogleFonts.nunito(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700)),
                                        Text('Land agent',
                                            style: GoogleFonts.nunito(
                                                color: Color(0xff1173AB),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 110,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: Color(0xff1173AB),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      child: Text('Rent it',
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700))),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40),
              LabelTitle(text: 'Google maps address'),
              SizedBox(height: 10),
              CustomTextField(
                  obscureText: true, hintText: 'E.g This property is haunt'),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: PropertyListingBackButton()
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: CustomButtonWidget(
                      color: appColor.primary,
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListedComplete()),
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
