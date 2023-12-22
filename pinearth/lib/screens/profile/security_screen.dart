// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/providers/user/change_password_provider.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../custom_widgets/custom_widgets.dart';
import 'profile_screen.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
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
          text: 'Security',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Consumer(
            builder: (context, ref, child) {
              final changePasswordP = ref.watch(changePasswordProvider);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LabelTitle(text: 'Change phone number'),
                  // 10.toColumnSpace(),
                  // CustomTextField(
                  //   obscureText: false, 
                  //   hintText: '(406) 555-0120'
                  // ),
                  20.toColumnSpace(),
                  LabelTitle(text: 'Old password'),
                  10.toColumnSpace(),
                  CustomTextField(
                    obscureText: !changePasswordP.oldPasswordIsVisible, hintText: 'Enter your old password',
                    controller: changePasswordP.oldPasswordController,
                    suffixIcon: InkWell(
                    onTap: () => ref.read(changePasswordProvider).toggleOldPasswordVisibility(),
                      child: Icon(
                        changePasswordP.oldPasswordIsVisible ? Icons.visibility_off : Icons.remove_red_eye,
                        color: appColor.primary,
                      ),
                    ),
                  ),
                  10.toColumnSpace(),

                  LabelTitle(text: 'New password'),
                  10.toColumnSpace(),
                  CustomTextField(
                    obscureText: !changePasswordP.newPasswordIsVisible, hintText: 'Enter your new password',
                    controller: changePasswordP.newPasswordController,
                    suffixIcon: InkWell(
                    onTap: () => ref.read(changePasswordProvider).toggleNewPasswordVisibility(),
                      child: Icon(
                        changePasswordP.newPasswordIsVisible ? Icons.visibility_off : Icons.remove_red_eye,
                        color: appColor.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
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
                            changePasswordP.changePassword(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Save',
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          )),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      )),
    );
  }
}
