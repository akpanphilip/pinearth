// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../custom_widgets/custom_widgets.dart';
import '../home_address.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              FormTitle(text: 'Sign up to list your property'),
              GoogleAuth(text: 'Sign up with Google'),
              FormTitle(text: 'OR'),
              LabelTitle(text: 'Name'),
              SizedBox(height: 10),
              CustomTextField(obscureText: false, hintText: 'Full names'),
              SizedBox(height: 20),
              LabelTitle(text: 'Email address'),
              SizedBox(height: 10),
              CustomTextField(obscureText: false, hintText: 'Email address'),
              SizedBox(height: 20),
              LabelTitle(text: 'Date of birth'),
              SizedBox(height: 10),
              CustomTextField(obscureText: false, hintText: ''),
              SizedBox(height: 20),
              LabelTitle(text: 'Password'),
              SizedBox(height: 10),
              CustomTextField(obscureText: true, hintText: 'Password'),
              SizedBox(height: 30),
              // AuthButton(
              //     text: 'Sign up',
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => HomeAddress()),
              //       );
              //     }),
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
                              builder: (context) => HomeAddress()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Sign up',
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
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: TextOpt(text: 'have an account? Login'))
            ],
          ),
        ),
      )),
    );
  }
}
