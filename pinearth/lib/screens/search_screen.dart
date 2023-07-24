// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/models/property_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> items = ["All", "For Rent", "For Sale", "Hotel", "Event Center"];

  List<String> categories = [
    "Featured Listings",
    "For Rent",
    "For Sale",
    "Hotel",
    "Event Center"
  ];

  // List<IconData> icons = [
  //   Icons.home,
  //   Icons.explore,
  //   Icons.search,
  //   Icons.feed,
  //   Icons.person,
  // ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 140,

          // scrolledUnderElevation: ,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: [
                Container(
                  color: Color.fromARGB(255, 5, 113, 201),
                  height: 140,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                decoration: InputDecoration(
                                  hintText:
                                      'Enter an address, neighborhood or zip code',
                                  prefixIcon: Icon(IconlyLight.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
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
                                  // custom tab bat
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
                                                    vertical: 10,
                                                    horizontal: 15),
                                                // margin: EdgeInsets.symmetric(
                                                //     horizontal: 10),
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 10, 10, 0),
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: current == index
                                                      ? Colors.white70
                                                      : Colors.white30,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    items[index],
                                                    style: GoogleFonts.nunito(
                                                        color: current == index
                                                            ? Color(0xff1173AB)
                                                            : Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  // custom tab bar end
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // SizedBox(height: 20),
        SliverToBoxAdapter(
          child: Column(
            children: [
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
              // main body
              Column(
                children: [
                  Text(categories[current],
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700))
                ],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.9,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final property = properties[index];
                  return PropertyWidget(
                    image: property['imageUrl'] as String,
                    price: property['price'] as String,
                    bathroom: property['bathroom'] as String,
                    bedroom: property['bedroom'] as String,
                    // category: property['category'] as String,
                    location: property['location'] as String,
                    desc: property['desc'] as String,
                    sqr: property['sqr'] as String,
                    // agent: property['agent'] as String,
                  );
                }),
          ),
        ),
        SliverPadding(padding: EdgeInsets.all(50)),
        SliverToBoxAdapter(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            height: MediaQuery.of(context).size.height / 1.9,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final property = properties[index];
                  return PropertyWidget(
                    image: property['imageUrl'] as String,
                    price: property['price'] as String,
                    bathroom: property['bathroom'] as String,
                    bedroom: property['bedroom'] as String,
                    // category: property['category'] as String,
                    location: property['location'] as String,
                    desc: property['desc'] as String,
                    sqr: property['sqr'] as String,
                    // agent: property['agent'] as String,
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
