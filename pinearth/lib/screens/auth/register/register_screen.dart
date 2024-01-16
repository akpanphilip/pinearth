// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:pinearth/providers/auth/register_provider.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../../custom_widgets/custom_widgets.dart';
import '../../../locator.dart';
import '../../feedback_alert/i_feedback_alert.dart';
import '../widgets/social_provider.dart';
import 'home_address.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final registerP = ref.watch(registerProvider);
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
              // Center(
              //   child: CircleAvatar(
              //     backgroundImage: AssetImage('assets/images/auth_avatar.png'),
              //     radius: 30,
              //   ),
              // ),
              FormTitle(text: 'Sign up to list your property'),
              // GoogleAuth(text: 'Sign up with Google'),
              // FormTitle(text: 'OR'),
              const SizedBox(
                height: 20,
              ),
              Consumer(builder: (context, ref, child) {
                final provider = ref.watch(registerProvider);

                return Column(
                  children: [
                    SocialProvider(
                      title: "Sign up with Google",
                      isLoading: provider.loadingGoogleInfo,
                      function: () {
                        ref.read<RegisterProvider>(registerProvider).loginWithGoogle = true;
                        ref.read<RegisterProvider>(registerProvider).registerWithGoogle(context);

                        // ref
                        //     .read<RegisterProvider>(registerProvider)
                        //     .registerWithGoogle(context);
                      },
                      image: "google".png,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (Platform.isIOS) ...[
                      SocialProvider(
                        title: "Sign up with Apple",
                        function: () {
                          //TODO sign up with apple
                        },
                        image: "apple".png,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]
                  ],
                );
              }),

              LabelTitle(text: 'First name'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false,
                hintText: 'First name',
                controller: ref.read(registerProvider).firstNameController,
              ),
              20.toColumnSpace(),

              LabelTitle(text: 'Last name'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false,
                hintText: 'Last name',
                controller: ref.read(registerProvider).lastNameController,
              ),
              20.toColumnSpace(),

              LabelTitle(text: 'Middle name'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false,
                hintText: 'Middle name',
                controller: ref.read(registerProvider).middleNameController,
              ),
              20.toColumnSpace(),

              LabelTitle(text: 'Email address'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false,
                hintText: 'Email address',
                controller: ref.read(registerProvider).emailController,
              ),
              20.toColumnSpace(),

              LabelTitle(text: 'Date of birth'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false,
                hintText: 'Day / Month /  Year',
                controller: registerP.dateOfBirthController,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: registerP.dateOfBirth == null
                          ? DateTime.now()
                          : registerP.dateOfBirth!,
                      firstDate:
                          DateTime.now().subtract(Duration(days: 5000 * 365)),
                      lastDate: DateTime.now());
                  if (date != null) {
                    ref.read(registerProvider).setDateOfBirth(date);
                  }
                },
              ),
              20.toColumnSpace(),

              LabelTitle(text: 'Password'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: !ref.read(registerProvider).passwordIsVisible,
                hintText: 'Password',
                controller: ref.read(registerProvider).passwordController,
                suffixIcon: InkWell(
                  onTap: () =>
                      ref.read(registerProvider).togglePasswordVisibility(),
                  child: Icon(
                    ref.watch(registerProvider).passwordIsVisible
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                    color: appColor.primary,
                  ),
                ),
              ),
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
                        final canGo =
                            ref.read(registerProvider).checkBeforeAddress();
                        ref.read(registerProvider).loginWithGoogle = false;
                        if (canGo) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeAddress()),
                          );
                        }
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
              20.toColumnSpace(),

              TextOpt(text: 'Forgot password?'),
              10.toColumnSpace(),
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
