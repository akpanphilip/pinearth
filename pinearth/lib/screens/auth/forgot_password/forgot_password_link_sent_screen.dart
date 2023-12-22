import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class ForgotPasswordLinkSentScreen extends StatelessWidget {
  const ForgotPasswordLinkSentScreen({super.key});

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
          text: 'Forgot Password',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          34.toColumnSpace(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("We have sent a password reset link to your email", style: TextStyle(
              fontSize: 20.toFontSize(),
              fontWeight: FontWeight.w800,
              color: Colors.black
            ),),
          ),

          34.toColumnSpace(),

          Center(
            child: SvgPicture.asset('forgot_password_link_sent'.svg),
          ),

          71.toColumnSpace(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: CustomButtonWidget(
              onClick: () {
                Navigator.pop(context);
              },
              color: appColor.primary,
              radius: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                child: Center(
                  child: Text("Continue", style: TextStyle(
                    fontSize: 15.toFontSize(),
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}