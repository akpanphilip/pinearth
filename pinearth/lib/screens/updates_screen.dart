// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../custom_widgets/custom_widgets.dart';
import '../models/update_location_model.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AppbarTitle(
            text: 'Updates',
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(IconlyLight.notification, color: Colors.black),
          )
        ],
        elevation: 0.5,
      ),
      body: SafeArea(
        // child: ListView.builder(
        //     itemCount: updateLocation.length,
        //     itemBuilder: (context, index) {
        //       final locationUpdate = updateLocation[index];
        //       return UpdateWidget(
        //         locationImg: locationUpdate['locationImg'] as String,
        //         location: locationUpdate['location'] as String,
        //       );
        //     }),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UpdateWidget(location: 'Alakashia'),
              UpdateWidget(location: 'No. 4 New GRA'),
              UpdateWidget(location: 'Pipeline'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Center(
                  child: ViewLink(text: 'View all'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubTitle(text: 'Agents'),
                  AgentList(name: 'Agent John Griff'),
                  AgentList(name: 'Agent John Griff'),
                  AgentList(name: 'Agent John Griff'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Center(
                      child: ViewLink(text: 'View all'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
