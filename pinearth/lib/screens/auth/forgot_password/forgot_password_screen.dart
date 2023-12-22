import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/screens/auth/forgot_password/forgot_password_link_sent_screen.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();

  void requestPasswordReset(BuildContext context) async {
    final alert = getIt<IAlertInteraction>();
    if (emailController.text.isEmpty) {
      alert.showErrorAlert("Please provide your registered email address");
    } else {
      alert.showLoadingAlert("");
      final res = await getIt<IUserRepo>().requestPasswordReset(emailController.text);
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert(l.message);
      }, (r) {
        alert.showSuccessAlert("Password reset link have been sent to ${emailController.text}");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ForgotPasswordLinkSentScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: const AppbarTitle(
          text: 'Forgot Password',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            34.toColumnSpace(),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Let's have your registered email.", style: TextStyle(
                fontSize: 20.toFontSize(),
                fontWeight: FontWeight.w800,
                color: Colors.black
              ),),
            ),
      
            27.toColumnSpace(),
      
            Center(
              child: SvgPicture.asset('forgot_password'.svg),
            ),
      
            27.toColumnSpace(),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelTitle(text: 'Email address'),
                  const SizedBox(height: 10),
                  CustomTextField(
                    obscureText: false, 
                    hintText: 'Email address',
                    // controller: ref.read(loginProvider).emailController,
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
      
            68.toColumnSpace(),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: CustomButtonWidget(
                onClick: () {
                  requestPasswordReset(context);
                },
                color: appColor.primary,
                radius: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                  child: Center(
                    child: Text("Submit", style: TextStyle(
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
      ),
    );
  }
}