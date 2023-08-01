// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/screens/property_photos_screen.dart';

import '../custom_widgets/custom_widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

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
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: AppbarTitle(
          text: 'List property',
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
                  style: GoogleFonts.nunito(
                      fontSize: 14, fontWeight: FontWeight.w700)),
              SizedBox(height: 10),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Color(0xffD9D9D9),
              //       borderRadius: BorderRadius.circular(10)),
              //   child: DropdownButton<String>(
              //     value: selectedOption,
              //     items: dropdownItems.map((String item) {
              //       return DropdownMenuItem<String>(
              //         value: item,
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 10, vertical: 10),
              //           child: Text(item,
              //               style: GoogleFonts.nunito(
              //                   fontSize: 16, fontWeight: FontWeight.w700)),
              //         ),
              //       );
              //     }).toList(),
              //     onChanged: (_) {},
              //     icon: Icon(Icons.expand_more),
              //   ),
              // )
              Container(
                  width: 135,
                  decoration: BoxDecoration(
                      color: Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        Text('Sell property'),
                        Icon(Icons.expand_more)
                      ],
                    ),
                  )),
              SizedBox(height: 30),
              LabelTitle(text: 'Name of property'),
              SizedBox(height: 10),
              CustomTextField(
                  obscureText: false, hintText: 'E.g Two bedroom in alakahia'),
              SizedBox(height: 20),
              LabelTitle(text: 'Description of property'),
              SizedBox(height: 10),
              CustomTextField(
                  obscureText: false,
                  hintText: 'What  is special about this property'),
              SizedBox(height: 20),
              Row(
                children: [
                  LabelTitle(text: 'Images of property'),
                  SizedBox(width: 15),
                  Text(
                    '*60 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(height: 10),
              UploadImg(),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Color.fromARGB(162, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {},
                          child: Text('Back', style: GoogleFonts.nunito()))),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xff1173AB),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PropertyPhoto()),
                          );
                        },
                        child: Text('Continue', style: GoogleFonts.nunito())),
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
