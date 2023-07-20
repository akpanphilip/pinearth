// ignore_for_file: unnecessary_brace_in_string_interps, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// property widget
class PropertyWidget extends StatelessWidget {
  final String image;
  final String price;
  final String location;
  final String desc;
  final String bedroom;
  final String bathroom;
  final String sqr;
  // final String agentImg;
  // final String agent;
  // final String category;

  const PropertyWidget({
    super.key,
    required this.image,
    required this.price,
    required this.location,
    required this.desc,
    required this.bedroom,
    required this.bathroom,
    required this.sqr,
    // required this.agentImg,
    // required this.agent,
    // required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 250,
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
                    image: AssetImage(image), fit: BoxFit.cover)),
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
                              image: AssetImage("assets/images/view.png"),
                            ),
                            SizedBox(width: 10),
                            Image(
                              image: AssetImage("assets/images/location.png"),
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
                Text(price,
                    style: GoogleFonts.nunito(
                        color: Color(0xff1173AB),
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 5),
                Text(
                  location,
                  style: GoogleFonts.nunito(
                      color: Color(0xff000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 5),
                Text(desc,
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
                          border:
                              Border.all(color: Color(0xff000000), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/images/house.svg', // Replace with the path to your SVG file
                                width: 13,
                                height: 13,
                              ),
                              Text('${bedroom} bedroom flat',
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff000000), fontSize: 7))
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
                          border:
                              Border.all(color: Color(0xff000000), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/images/bathroom.svg', // Replace with the path to your SVG file
                                width: 13,
                                height: 13,
                              ),
                              Text('${bathroom} bathrooms',
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff000000), fontSize: 7))
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
                          border:
                              Border.all(color: Color(0xff000000), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/images/feet.svg', // Replace with the path to your SVG file
                                width: 13,
                                height: 13,
                              ),
                              Text('${sqr} sqr feet',
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff000000), fontSize: 7))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/agent.png'),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    borderRadius: BorderRadius.circular(5))),
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
    );
  }
}

// viewLink
class ViewLink extends StatelessWidget {
  final String text;
  const ViewLink({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.nunito(
            color: Color(0xff1173AB),
            fontSize: 13,
            fontWeight: FontWeight.w700));
  }
}

// update widget
class UpdateWidget extends StatelessWidget {
  // final String locationImg;
  final String location;
  const UpdateWidget({
    super.key,
    // required this.locationImg,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12, // Set the color of the bottom border
            width: 1.0, // Set the width of the bottom border
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/updateLocation.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(width: 15),
            Expanded(
                child: Text.rich(TextSpan(
                    text: 'A new property is up for rent at ',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: [
                  TextSpan(
                    text: location,
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ]))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextButton(
                  onPressed: () {},
                  child: ViewLink(
                    text: 'View',
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// appbar title text
class AppbarTitle extends StatelessWidget {
  final String text;
  const AppbarTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.nunito(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700));
  }
}

// sub title text
class SubTitle extends StatelessWidget {
  final String text;
  const SubTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(text,
          style: GoogleFonts.nunito(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700)),
    );
  }
}

// agent list
class AgentList extends StatelessWidget {
  // final String locationImg;
  final String name;
  const AgentList({
    super.key,
    // required this.locationImg,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12, // Set the color of the bottom border
            width: 1.0, // Set the width of the bottom border
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/agent.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(width: 15),
            Expanded(
                child: Text.rich(TextSpan(
                    text: name,
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                    children: [
                  TextSpan(
                    text: 'just listed a new property, want to see it?',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ]))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextButton(
                  onPressed: () {},
                  child: ViewLink(
                    text: 'View',
                  )),
            )
          ],
        ),
      ),
    );
  }
}
