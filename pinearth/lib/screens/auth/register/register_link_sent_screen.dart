import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/screens/auth/login_screen.dart';
import 'package:pinearth/screens/root_screen.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class RegisterLinkSentScreen extends StatelessWidget {
  const RegisterLinkSentScreen({super.key});

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
          text: 'Check your inbox',
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
            child: Text("We have sent a confirmation link to your email", style: TextStyle(
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
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (r) => false);
              },
              color: appColor.primary,
              radius: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                child: Center(
                  child: Text("Go to Login", style: TextStyle(
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