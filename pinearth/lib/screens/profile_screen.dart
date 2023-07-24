// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/screens/edit_profile_screen.dart';

import '../custom_widgets/custom_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
          text: 'Profile',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Image(image: AssetImage('assets/images/user.png')),
                SizedBox(height: 10),
                Center(
                  child: Text('Cameron Williamson',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700, fontSize: 18)),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfile()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.black12),
                            bottom: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.black12))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image(
                                  image: AssetImage('assets/images/edit.png')),
                              SizedBox(width: 20),
                              Text(
                                'Edit profile',
                                style: GoogleFonts.nunito(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.black26,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ProfileSection(
                  img: 'assets/images/listed.png',
                  text: 'My listed properties',
                ),
                ProfileSection(
                  img: 'assets/images/security.png',
                  text: 'Security',
                ),
                ProfileSection(
                  img: 'assets/images/how.png',
                  text: 'How to use?',
                ),
                ProfileSection(
                  img: 'assets/images/customer-support.png',
                  text: 'Customer support',
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
