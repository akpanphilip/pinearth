// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';

class ScheduleVisit extends StatefulWidget {
  const ScheduleVisit({super.key});

  @override
  State<ScheduleVisit> createState() => _ScheduleVisitState();
}

class _ScheduleVisitState extends State<ScheduleVisit> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: AppbarTitle(
          text: 'Schedule a visit',
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Name'),
                ],
              ),
              SizedBox(height: 10),
              CustomTextField(obscureText: false, hintText: ''),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Phone number'),
                ],
              ),
              SizedBox(height: 10),
              CustomTextField(obscureText: false, hintText: ''),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Email'),
                ],
              ),
              SizedBox(height: 10),
              CustomTextField(obscureText: false, hintText: ''),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Message'),
                  SizedBox(width: 5),
                  Text(
                    '(Optional)',
                    style: GoogleFonts.nunito(color: Colors.black45),
                  ),
                ],
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  decoration: InputDecoration(
                    // border
                    hintText: 'Enter text...',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
