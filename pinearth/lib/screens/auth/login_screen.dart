// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/providers/auth/login_provider.dart';
import 'package:pinearth/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:pinearth/screens/auth/register/register_screen.dart';
import 'package:pinearth/screens/root_screen.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../custom_widgets/custom_widgets.dart';
import '../../providers/auth/register_provider.dart';
import 'widgets/social_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => RootScreen()),
            (route) => false);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AppbarTitle(
              text: '',
            ),
          ),
          centerTitle: false,
          elevation: 0.5,
          leading: InkWell(
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => RootScreen()),
                  (route) => false),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: CircleAvatar(
                //     backgroundImage:
                //         AssetImage('assets/images/auth_avatar.png'),
                //     radius: 30,
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: FormTitle(
                      text: 'Login to begin selling and renting properties'),
                ),

                // const SizedBox(
                //   height: 20,
                // ),
                SocialProvider(
                  title: "Sign in with Google",
                  isLoading: ref.watch(registerProvider).loadingGoogleInfo,
                  function: () {
                    ref
                        .read<RegisterProvider>(registerProvider)
                        .loginWithGoogle = true;
                    ref
                        .read<RegisterProvider>(registerProvider)
                        .registerWithGoogle(context);
                  },
                  image: "google".png,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (Platform.isIOS) ...[
                  SocialProvider(
                    title: "Sign in with Apple",
                    function: () {
                      //TODO sign up with apple
                    },
                    image: "apple".png,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                // GoogleAuth(text: 'Sign in with Google'),
                // FormTitle(text: 'OR'),
                LabelTitle(text: 'Email address'),
                SizedBox(height: 10),
                CustomTextField(
                  obscureText: false,
                  hintText: 'Email address',
                  controller: ref.read(loginProvider).emailController,
                ),
                SizedBox(height: 20),
                LabelTitle(text: 'Password'),
                SizedBox(height: 10),
                CustomTextField(
                  obscureText: !ref.watch(loginProvider).passwordIsVisible,
                  hintText: 'Password',
                  controller: ref.read(loginProvider).passwordController,
                  suffixIcon: InkWell(
                    onTap: () =>
                        ref.read(loginProvider).togglePasswordVisibility(),
                    child: Icon(
                      ref.watch(loginProvider).passwordIsVisible
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: appColor.primary,
                    ),
                  ),
                ),
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
                          ref.read(loginProvider).login(context);
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
                InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen())),
                    child: TextOpt(text: 'Forgot password?')),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: TextOpt(text: 'Don\'t have an account? Sign up'))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
