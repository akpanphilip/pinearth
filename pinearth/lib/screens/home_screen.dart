// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = ["All", "For Rent", "For Sale", "Hotel", "Event Center"];

  List<IconData> icons = [
    Icons.home,
    Icons.explore,
    Icons.search,
    Icons.feed,
    Icons.person,
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Color.fromARGB(255, 5, 113, 201),
                height: 125,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            decoration: InputDecoration(
                              hintText:
                                  'Enter an address, neighborhood or zip code',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: items.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              current = index;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              // margin: EdgeInsets.symmetric(
                                              //     horizontal: 10),
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 10, 10, 0),
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: current == index
                                                    ? Colors.black
                                                    : Colors.black38,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  items[index],
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Container(
                  width: 104,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffE6F1F7)),
                  child: Center(
                    child: Text(
                      'Properties',
                      style: GoogleFonts.nunito(color: Color(0xff1173AB)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Featured Listings',
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w700)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 250,
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border:
                              Border.all(color: Color(0xffE6F1F7), width: 1),
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
                            Image(
                              image: AssetImage("assets/images/property.png"),
                              height: 185,
                              width: 250,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('300,000 NGN/Month',
                                      style: GoogleFonts.nunito(
                                          color: Color(0xff1173AB),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 5),
                                  Text(
                                    'Nice Condo in Alakahia',
                                    style: GoogleFonts.nunito(
                                        color: Color(0xff000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                      'Beautiful Huge 1 Family House In Heart Of Westbury. Newly Renovated With New Wood',
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xff000000),
                                                width: 1),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                  SvgPicture.asset(
                                                    'assets/images/house.svg', // Replace with the path to your SVG file
                                                    width: 13,
                                                    height: 13,
                                                  ),
                                                Text('3 bedroom flat',
                                                    style: GoogleFonts.nunito(
                                                        color:
                                                            Color(0xff000000),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xff000000),
                                                width: 1),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/bathroom.svg', // Replace with the path to your SVG file
                                                  width: 13,
                                                  height: 13,
                                                ),
                                                Text('3 bathrooms',
                                                    style: GoogleFonts.nunito(
                                                        color:
                                                            Color(0xff000000),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xff000000),
                                                width: 1),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/feet.svg', // Replace with the path to your SVG file
                                                  width: 13,
                                                  height: 13,
                                                ),
                                                Text('110 sqr feet',
                                                    style: GoogleFonts.nunito(
                                                        color:
                                                            Color(0xff000000),
                                                        fontSize: 7))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                     ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}



//  padding:
//                               EdgeInsets.symmetric(vertical: 5, horizontal: 13),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),