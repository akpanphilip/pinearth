// ignore_for_file: unnecessary_brace_in_string_interps, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:redacted/redacted.dart';

import '../utils/styles/colors.dart';

// viewLink
class ViewLink extends StatelessWidget {
  final String text;

  const ViewLink({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.nunito(
            color: Color(0xff1173AB),
            fontSize: 13,
            fontWeight: FontWeight.w700));
  }
}

// update widget
class UpdateWidget extends StatelessWidget {
  // final String locationImg;
  final String location;

  const UpdateWidget({
    super.key,
    // required this.locationImg,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12, // Set the color of the bottom border
            width: 1.0, // Set the width of the bottom border
          ),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(15.0), child: Text("$location")),
    );
  }
}

class LoadingUpdateWidget extends StatelessWidget {
  // final String locationImg;
  final String location;

  const LoadingUpdateWidget({
    super.key,
    // required this.locationImg,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12, // Set the color of the bottom border
            width: 1.0, // Set the width of the bottom border
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/updateLocation.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(width: 15),
            Expanded(
                child: Text.rich(TextSpan(
                    text: 'A new property is up for rent at ',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: [
                  TextSpan(
                    text: location,
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ]))),
          ],
        ),
      ),
    ).redact(context);
  }
}

// appbar title text
class AppbarTitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;

  const AppbarTitle({
    super.key,
    required this.text,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(text,
          textAlign: TextAlign.start,
          style: GoogleFonts.nunito(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800)),
    );
  }
}

// sub title text
class SubTitle extends StatelessWidget {
  final String text;

  const SubTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(text,
          style: GoogleFonts.nunito(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700)),
    );
  }
}

// agent list
class AgentList extends StatelessWidget {
  // final String locationImg;
  final String name;

  const AgentList({
    super.key,
    // required this.locationImg,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12, // Set the color of the bottom border
            width: 1.0, // Set the width of the bottom border
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/agent.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(width: 15),
            Expanded(
                child: Text.rich(TextSpan(
                    text: name,
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                    children: [
                  TextSpan(
                    text: 'just listed a new property, want to see it?',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ]))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextButton(
                  onPressed: () {},
                  child: ViewLink(
                    text: 'View',
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// button
class ActionButton extends StatelessWidget {
  final String text;

  const ActionButton({
    super.key,
    required this.text,
  });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             elevation: 0,
//             backgroundColor: Color(0xff1173AB),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(50))),
//         onPressed: () {},
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//           child: Text(
//             text,
//             style: GoogleFonts.nunito(
//                 color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
//           ),
//         ));
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff1173AB), borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Text(
          text,
          style: GoogleFonts.nunito(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

// description text
class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

// form title
class FormTitle extends StatelessWidget {
  final String text;

  const FormTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Text(text,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800)),
      ),
    );
  }
}

// google auth button
class GoogleAuth extends StatelessWidget {
  final String text;

  const GoogleAuth({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 280,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Color(0xff1173AB), width: 2),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Image(image: AssetImage('assets/images/google.png')),
                  ),
                  Text(
                    text,
                    style: GoogleFonts.nunito(
                        color: Color(0xff1173AB),
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

// label title
class LabelTitle extends StatelessWidget {
  final String text;
  final Color color;

  const LabelTitle({
    super.key,
    required this.text,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        style: GoogleFonts.nunito(
            color: color, fontSize: 16, fontWeight: FontWeight.w700));
  }
}

class ImportantLabelTitle extends StatelessWidget {
  final String text;

  const ImportantLabelTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: GoogleFonts.nunito(
          fontSize: 14, color: Colors.red, fontWeight: FontWeight.w700),
    );
  }
}

// input
class CustomTextField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final bool readOnly;
  final Function? onTap;
  final TextInputType? inputType;
  final Widget? suffixIcon;
  final double maxHeight;
  final bool isFilled;
  final Color fillColor;
  final InputBorder? border;

  const CustomTextField(
      {super.key,
      required this.obscureText,
      required this.hintText,
      this.controller,
      this.readOnly = false,
      this.isFilled = true,
      this.fillColor = const Color(0xffeeeeee),
      this.border,
      this.onTap,
      this.validator,
      this.inputType,
      this.maxHeight = 48,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: TextStyle(color: Colors.black, fontSize: 16.toFontSize()),
      controller: controller,
      readOnly: readOnly,
      textAlignVertical: TextAlignVertical.center,
      validator: validator,
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      keyboardType: inputType,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 19),
          fillColor: fillColor,
          filled: isFilled,
          border: border ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none),
          hintText: hintText,
          constraints: BoxConstraints(maxHeight: maxHeight, minHeight: 48),
          suffixIcon: suffixIcon),
    );
  }
}

// auth button
// class AuthButton extends StatelessWidget {
//   final String text;
//   // final Function press;
//   const AuthButton({
//     super.key,
//     required this.text
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 200,
//         child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 elevation: 0,
//                 backgroundColor: Color(0xff1173AB),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25))),
//             onPressed: (){},
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Text(
//                 text,
//                 style: GoogleFonts.nunito(
//                     fontSize: 16,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700),
//               ),
//             )),
//       ),
//     );
//   }
// }

// form options
class TextOpt extends StatelessWidget {
  final String text;

  const TextOpt({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }
}

// mmid title text
class MidTitle extends StatelessWidget {
  final String text;

  const MidTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.nunito(
            fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),
      ),
    );
  }
}

// upload id
class UploadId extends StatelessWidget {
  final String img;
  final String text;

  const UploadId({
    super.key,
    required this.img,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.black12, // Set the color of the bottom border
          width: 2.0, // Set the width of the bottom border
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(img),
              height: 30,
              width: 30,
            ),
            Text(
              text,
              style:
                  GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            Icon(Icons.chevron_right_rounded, size: 30)
          ],
        ),
      ),
    );
  }
}

// sizedbutton
class ButtonSn extends StatelessWidget {
  final String text;
  final Function press;

  const ButtonSn({
    super.key,
    required this.text,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ElevatedButton(
            onPressed: press(),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color(0xff1173AB),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Text(text, style: GoogleFonts.nunito()),
            )));
  }
}

// profile section
class ProfileSection extends StatelessWidget {
  final String img;
  final String text;

  // final String? borderTop;
  const ProfileSection({
    super.key,
    required this.img,
    required this.text,
    // required this.borderTop,
  });

// AssetImage('assets/images/edit.png')
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              // top: borderTop,
              bottom:
                  BorderSide(style: BorderStyle.solid, color: Colors.black12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage(img),
                  errorBuilder: (c, r, s) => SizedBox.shrink(),
                  height: 30,
                  width: 30,
                ),
                SizedBox(width: 20),
                Text(
                  text,
                  style: GoogleFonts.nunito(
                      fontSize: 14, fontWeight: FontWeight.w700),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.black26,
            )
          ],
        ),
      ),
    );
  }
}

// upload picture
class UploadImg extends StatelessWidget {
  const UploadImg({super.key, this.height = 200});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: SvgPicture.asset('sample_upload'.svg),
      ),
    );
  }
}

class SelectedImagesWidget extends StatelessWidget {
  const SelectedImagesWidget(
      {super.key, required this.images, this.height = 200});

  final List images;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade300),
      child: Row(
        children: [
          ...images.take(3).map((e) => Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Builder(builder: (context) {
                    print(e.runtimeType == File);
                    if (e.runtimeType == String) {
                      if (e.toString().startsWith('http')) {
                        return CachedNetworkImage(
                          imageUrl: e,
                          fit: BoxFit.cover,
                          height: 200,
                        );
                      }
                      return Image.file(
                        File(e),
                        fit: BoxFit.cover,
                        height: 200,
                      );
                    }
                    // if (e.runtimeType == File) {
                    // }
                    return Image.file(
                      e,
                      fit: BoxFit.cover,
                      height: 200,
                    );
                    // return SizedBox.shrink();
                  })).animate().fadeIn(duration: Duration(milliseconds: 500))))
        ],
      ),
    );
  }
}

class SelectedImagesWidgetV2 extends StatelessWidget {
  const SelectedImagesWidgetV2(
      {super.key, required this.images, this.height = 200});

  final List images;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300),
        child: PageView.builder(
          itemBuilder: (contex, index) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Builder(builder: (context) {
                  final e = images[index];

                  if (e.runtimeType == String) {
                    if (e.toString().startsWith('http')) {
                      return CachedNetworkImage(
                        imageUrl: e,
                        fit: BoxFit.cover,
                        height: 200,
                      );
                    }
                    return Image.file(
                      File(e),
                      fit: BoxFit.cover,
                      height: 200,
                    );
                  }
                  // if (e.runtimeType == File) {
                  // }
                  return Image.file(
                    e,
                    fit: BoxFit.cover,
                    height: 200,
                  );
                  // return SizedBox.shrink();
                })).animate().fadeIn(duration: Duration(milliseconds: 500));
          },
          itemCount: images.length,
        )

        // ListView.separated(
        //   scrollDirection: Axis.horizontal,
        //   separatorBuilder: (context, index) {
        //     return const SizedBox(
        //       width: 10,
        //     );
        //   },
        //   itemBuilder: (context, index) {
        //     return ClipRRect(
        //         borderRadius: BorderRadius.circular(10),
        //         child: Builder(builder: (context) {
        //           final e = images[index];

        //           if (e.runtimeType == String) {
        //             if (e.toString().startsWith('http')) {
        //               return CachedNetworkImage(
        //                 imageUrl: e,
        //                 fit: BoxFit.cover,
        //                 height: 200,
        //               );
        //             }
        //             return Image.file(
        //               File(e),
        //               fit: BoxFit.cover,
        //               height: 200,
        //             );
        //           }
        //           // if (e.runtimeType == File) {
        //           // }
        //           return Image.file(
        //             e,
        //             fit: BoxFit.cover,
        //             height: 200,
        //           );
        //           // return SizedBox.shrink();
        //         })).animate().fadeIn(duration: Duration(milliseconds: 500));
        //   },
        //   itemCount: images.length,
        // ),
        );
  }
}

class Price extends StatelessWidget {
  final String price;

  const Price({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }
}

class LabelProperty extends StatelessWidget {
  final String text;

  const LabelProperty({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
          color: Colors.black26, fontWeight: FontWeight.w300, fontSize: 16),
    );
  }
}

class PropertyFeature extends StatelessWidget {
  final String text;

  const PropertyFeature({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
          fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
    );
  }
}

class HelpButton extends StatelessWidget {
  const HelpButton({super.key, required this.text, required this.helpIcon});

  final String text;
  final Widget helpIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: appColor.inputBackground,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.help_outline_rounded,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

PreferredSize pageProgressWidget({required double progress}) {
  return PreferredSize(
      preferredSize: Size(double.infinity, 20),
      child: LinearProgressIndicator(
        value: progress,
        color: appColor.inputBackground,
        backgroundColor: appColor.inactiveColor,
      ));
}
