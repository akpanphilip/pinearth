// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FullViewProperty extends StatefulWidget {
  const FullViewProperty({super.key});

  @override
  State<FullViewProperty> createState() => _FullViewPropertyState();
}

class _FullViewPropertyState extends State<FullViewProperty> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/full_property_view.png'),
                      fit: BoxFit.cover)),
            )
          ],
        ),
      ),
    ));
  }
}
