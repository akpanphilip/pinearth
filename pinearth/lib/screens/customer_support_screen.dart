import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_widgets.dart';
import '../providers/user/profile_provider.dart';
import '../utils/extensions/number_extension.dart';
import '../utils/extensions/string_extension.dart';

class CustomerSupportScreen extends ConsumerStatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  ConsumerState<CustomerSupportScreen> createState() =>
      _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends ConsumerState<CustomerSupportScreen> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userRef = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: const AppbarTitle(
          text: 'Customer support',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff1173AB),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'customer_support_rocket'.svg,
                        height: 50,
                        width: 50,
                      ),
                      20.toRowSpace(),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.start,
                          'Send your complaint to support@pinearth.com',
                          style: GoogleFonts.nunito(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                30.toColumnSpace(),
                // 42.toColumnSpace(),
                const LabelTitle(text: 'Name'),
                10.toColumnSpace(),
                SizedBox(
                  height: 50,
                  child: CustomTextField(
                    obscureText: false,
                    validator: (String? str) {
                      if (str == null || str.trim().isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                    hintText: '',
                    controller: nameController,
                  ),
                ),
                20.toColumnSpace(),
                const LabelTitle(text: 'Phone number'),
                10.toColumnSpace(),
                SizedBox(
                  height: 50,
                  child: CustomTextField(
                    // contentPadding: const EdgeInsets.all(50),
                    inputType: TextInputType.phone,
                    validator: (String? str) {
                      if (str == null || str.trim().isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                    obscureText: false,
                    hintText: '',
                    controller: phoneNumberController,
                  ),
                ),
                // 20.toColumnSpace(),
                // const LabelTitle(text: 'Email'),
                // 10.toColumnSpace(),
                // CustomTextField(
                //   ,
                //   obscureText: false,
                //   hintText: '',
                //   controller: emailController,
                // ),
                20.toColumnSpace(),
                const LabelTitle(text: 'Message'),
                14.toColumnSpace(),
                SizedBox(
                  height: 150,
                  child: CustomTextField(
                    contentPadding: const EdgeInsets.all(20),
                    expands: true,
                    inputType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                    validator: (String? str) {
                      if (str == null || str.trim().isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                    obscureText: false,
                    hintText: '',
                    controller: messageController,
                  ),
                ),
                // TextField(
                //   controller: messageController,
                //   decoration: InputDecoration(
                //       fillColor: const Color(0xffeeeeee),
                //       filled: true,
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10)),
                //       hintText: "Type your message here..."),
                //   maxLines: 5,
                //   minLines: 5,
                // ),
                42.toColumnSpace(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xff1173AB),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        userRef.sendComplaint({
                          "name": nameController.text,
                          "phone_no": phoneNumberController.text,
                          "recipient": "mbakabilal.t@gmail.com",
                          "email": userRef.profileState.data!.email,
                          "message": messageController.text,
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Send Message',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
