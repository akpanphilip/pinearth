// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/screens/root_screen.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

import '../../../custom_widgets/custom_widgets.dart';
import '../../list_property/list_property_screen.dart';

class AccountSuccess extends StatelessWidget {
  const AccountSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: AppbarTitle(
          text: 'Personal ID',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            100.toColumnSpace(),
            Center(
              child: Image(image: AssetImage('assets/images/success.png'), height: 80, width: 80,)
            ),
            43.toColumnSpace(),
            // FormTitle(text: ),
            Text('Your account has been created',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800)),
            18.toColumnSpace(),

            DescriptionText(
                text:
                    'You can now list, trade and rent out properties, and many other perks!'),
            79.toColumnSpace(),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color(0xff1173AB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => RootScreen()),
                        (route) => false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Continue',
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
    );
  }
}
