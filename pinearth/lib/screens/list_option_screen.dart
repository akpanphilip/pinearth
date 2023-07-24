// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';

class ListOpt extends StatefulWidget {
  const ListOpt({super.key});

  @override
  State<ListOpt> createState() => _ListOptState();
}

class _ListOptState extends State<ListOpt> {
  @override
  Widget build(BuildContext context) {
    List<String> dropdownItems = ['Select your option', 'Sell property'];

    String selectedOption =
        dropdownItems[0]; // Set the initial selected option (if desired)

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: AppbarTitle(
            text: 'List property',
          ),
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Do you want to sell or rent this property',
                  style: GoogleFonts.nunito(fontSize: 14)),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(
                  value: selectedOption,
                  items: dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text(item,
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    );
                  }).toList(),
                  onChanged: (_) {},
                  icon: Icon(Icons.expand_more),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
