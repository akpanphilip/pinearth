// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/screens/auth/register_screen.dart';
import 'package:pinearth/screens/profile_screen.dart';

import '../../custom_widgets/custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: AppbarTitle(
            text: 'Profile',
          ),
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/auth_avatar.png'),
                  radius: 30,
                ),
              ),
              FormTitle(text: 'Login to list your property'),
              GoogleAuth(text: 'Sign in with Google'),
              FormTitle(text: 'OR'),
              LabelTitle(text: 'Email address'),
              SizedBox(height: 10),
              CustomTextField(obscureText: false, hintText: 'Email address'),
              SizedBox(height: 20),
              LabelTitle(text: 'Password'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: 'Password'),
              SizedBox(height: 30),
              // AuthButton(text: 'Login', press: () {}),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Login',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 20),
              TextOpt(text: 'Forgot password?'),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: TextOpt(text: 'Don\'t have an account? Sign up'))
            ],
          ),
        ),
      )),
    );
  }
}
