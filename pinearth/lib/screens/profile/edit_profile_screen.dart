// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/providers/user/edit_profile_provider.dart';

import '../../custom_widgets/custom_widgets.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final editProfileP = ref.watch(editProfileProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: AppbarTitle(
          text: 'Edit Profile',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelTitle(text: 'First name'),
              SizedBox(height: 10),
              CustomTextField(
                obscureText: false,
                hintText: 'Guy',
                controller: editProfileP.firstNameController,
              ),
              SizedBox(height: 20),
              LabelTitle(text: 'Last name'),
              SizedBox(height: 10),
              CustomTextField(
                obscureText: false,
                hintText: 'Hawkins',
                controller: editProfileP.lastNameController,
              ),
              SizedBox(height: 20),
              LabelTitle(text: 'Middle name'),
              SizedBox(height: 10),
              CustomTextField(
                obscureText: false,
                hintText: 'Hawkins',
                controller: editProfileP.middleNameController,
              ),
              SizedBox(height: 20),
              LabelTitle(text: 'Email'),
              SizedBox(height: 10),
              CustomTextField(
                obscureText: false,
                hintText: '',
                controller: editProfileP.emailController,
              ),
              SizedBox(height: 10),
              LabelTitle(text: 'Address'),
              SizedBox(height: 10),
              CustomTextField(
                obscureText: false,
                hintText: '',
                controller: editProfileP.addressController,
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
                        editProfileP.updateProfile(context);
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
          ),
        ),
      )),
    );
  }
}
