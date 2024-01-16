// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:pinearth/providers/auth/register_provider.dart';
import 'package:pinearth/screens/auth/register/account_success_screen.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

import '../../../custom_widgets/custom_widgets.dart';

class PersonalID extends ConsumerStatefulWidget {
  const PersonalID({super.key, this.uploadId = false});

  ///If we are uploading the userid because the user signed up with social
  ///provider, the hit the signin with google endpoint to update the user's id
  final bool uploadId;

  @override
  ConsumerState<PersonalID> createState() => _PersonalIDState();
}

class _PersonalIDState extends ConsumerState<PersonalID> {
  @override
  Widget build(BuildContext context) {
    final registerP = ref.watch(registerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: AppbarTitle(
          text: 'Personal ID',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Center(
          child: Column(
            children: [
              MidTitle(text: 'UPLOAD YOUR ID'),
              DescriptionText(
                text:
                    'We need to verify your identity to be sure you are who you say you are',
              ),
              SizedBox(height: 30),
              if (registerP.idFile != null) ...[
                SelectedImagesWidget(
                  images: [registerP.idFile],
                  height: 150,
                ),
                10.toColumnSpace(),
                Center(
                  child: InkWell(
                      onTap: () => registerP.changeDocument(),
                      child: Text("change document")),
                ),
              ],
              if (registerP.idFile == null) ...[
                GestureDetector(
                  onTap: () => registerP.selectDocument(),
                  child: UploadId(
                    img: 'assets/images/nin.png',
                    text: 'NIN / NATIONAL ID',
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () => registerP.selectDocument(),
                  child: UploadId(
                    img: 'assets/images/driver-license.png',
                    text: 'DRIVERS LICENSE',
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () => registerP.selectDocument(),
                  child: UploadId(
                    img: 'assets/images/internation-passport.png',
                    text: 'INTERNATIONAL PASSPORT',
                  ),
                ),
              ],
              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Color(0xff1173AB),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onPressed: () {
                        if (registerP.checkId()) {
                          if (widget.uploadId) {
                            registerP.uploadId(context);
                          } else {
                            if (registerP.loginWithGoogle) {
                              registerP.registerWithSocialProvider(
                                context,
                              );
                            } else {
                              registerP.register(context);
                            }
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Next',
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
      ),
    );
  }
}
