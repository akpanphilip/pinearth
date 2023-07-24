// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/screens/list_option_screen.dart';

import '../custom_widgets/custom_widgets.dart';

class ListPropertyScreen extends StatefulWidget {
  const ListPropertyScreen({super.key});

  @override
  State<ListPropertyScreen> createState() => _ListPropertyScreenState();
}

class _ListPropertyScreenState extends State<ListPropertyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AppbarTitle(
              text: 'List property',
            ),
          ),
          centerTitle: false,
          elevation: 0.5,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    child: Image(
                        image: AssetImage('assets/images/list-property.png'))),
                Text(
                  'Sell with a Pinearth partner agent',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1173AB),
                      fontSize: 16),
                ),
                SizedBox(height: 10),
                  Text(
                    'Not in a market with Pinearth’s new selling experience? Work with a real estate agent for selling support at every step, including prepping, listing and marketing your home.',
                    style: GoogleFonts.nunito(fontSize: 14),
                ),
                SizedBox(height: 15),
                // ButtonSn(text: 'Find an agent'),
                SizedBox(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ListOpt()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xff1173AB),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          child: Text('Find an agent',
                              style: GoogleFonts.nunito()),
                        ))),
                SizedBox(height: 50),
                Text(
                  'Sell with a Pinearth partner agent',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1173AB),
                      fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Not in a market with Pinearth’s new selling experience? Work with a real estate agent for selling support at every step, including prepping, listing and marketing your home.',
                  style: GoogleFonts.nunito(fontSize: 14),
                ),
                SizedBox(height: 15),
                SizedBox(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ListOpt()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xff1173AB),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          child: Text('Sell it yourself',
                              style: GoogleFonts.nunito()),
                        )))
              ],
            ),
          ),
        )));
  }
}
