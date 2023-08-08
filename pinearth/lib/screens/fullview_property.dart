// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FullViewProperty extends StatefulWidget {
  const FullViewProperty({super.key});

  @override
  State<FullViewProperty> createState() => _FullViewPropertyState();
}

class _FullViewPropertyState extends State<FullViewProperty> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/full_property_view.png'),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Positioned(
                      top: 10,
                      left: 10,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Positioned(
                      bottom: 40,
                      left: 40,
                      child: Image(image: AssetImage('assets/images/tag.png')))
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullViewProperty()),
                      ),
                      child: Text(
                        'Details',
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text('Images'),
                    GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullViewProperty()),
                            ),
                        child: Text('Seller Info')),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Park Smith Properties',
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Image(image: AssetImage('assets/images/call.png'))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LabelProperty(text: 'Property features'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        PropertyFeature(text: '2 Story building'),
                        SizedBox(width: 20),
                        PropertyFeature(text: '3 bedrooms'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LabelProperty(text: 'Address'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        PropertyFeature(
                            text:
                                '2972 Westheimer Rd. Santa Ana, Illinois 85486 '),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LabelProperty(text: 'Price'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Price(price: '200'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LabelProperty(text: 'Map'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/map.png'))),
                    ),
                    SizedBox(height: 30),
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ProfileScreen()),
                              // );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Schedule a visit',
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
            )
          ],
        ),
      ),
    ));
  }
}

class Price extends StatelessWidget {
  final String price;
  const Price({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }
}

class LabelProperty extends StatelessWidget {
  final String text;
  const LabelProperty({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
          color: Colors.black26, fontWeight: FontWeight.w300, fontSize: 16),
    );
  }
}

class PropertyFeature extends StatelessWidget {
  final String text;
  const PropertyFeature({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
          fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
    );
  }
}
