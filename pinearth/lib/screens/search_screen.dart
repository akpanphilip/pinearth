// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/models/property_model.dart';
import 'package:pinearth/providers/properties/properties_list_provider.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/property_category_tile_widget.dart';
import 'package:pinearth/screens/widgets/side_bar_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

import 'widgets/input_fields/search_input_field.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<String> items = ["All", "For Rent", "For Sale", "Hotel", "Event Center"];

  List<String> categories = [
    "Featured Listings",
    "For Rent",
    "For Sale",
    "Hotel",
    "Event Center"
  ];

  String currentClass = "All";

  @override
  void initState() {
    super.initState();
    ref.read(propertyListProvider).loadProperties();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final propertyListP = ref.watch(propertyListProvider);
    final propertyListState = propertyListP.propertyListState;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 5, 113, 201),
              // height: 125,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      11.toRowSpace(),
                      Expanded(
                        child: SearchPropertyFieldWidget(
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  PropertyClassTileWidget(
                    onClassChange: (String propertyClass) {
                      setState(() {
                        currentClass = propertyClass;
                      });
                    },
                    currentClass: currentClass,
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
            Builder(
              builder: (context) {
                if (propertyListState.isLoading()) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (propertyListState.isError()) {
                  return CustomErrorWidget(message: propertyListState.message, onReload: () => propertyListP.loadProperties());
                }
                return Container(
                  child: Text("It is loaded..."),
                );
              },
            ),
            Text(currentClass == 'All' ? 'Featured Listings' : currentClass,
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
      ),
      drawer: Drawer(
        child: SideBarWidget(),
      ),
    );
  }
}


