// ignore_for_file: unnecessary_brace_in_string_interps, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// property widget
class PropertyWidget extends StatelessWidget {
  final String image;
  final String price;
  final String location;
  final String desc;
  final String bedroom;
  final String bathroom;
  final String sqr;
  // final String agentImg;
  // final String agent;
  // final String category;

  const PropertyWidget({
    super.key,
    required this.image,
    required this.price,
    required this.location,
    required this.desc,
    required this.bedroom,
    required this.bathroom,
    required this.sqr,
    // required this.agentImg,
    // required this.agent,
    // required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 320,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Color(0xffE6F1F7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0xffE6F1F7),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 185,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover)),
            child: Stack(
              children: [
                Positioned(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 25),
                          child: Text('For rent',
                              style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        )),
                    top: 20,
                    right: 15),
                Positioned(
                    bottom: 20,
                    right: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage("assets/images/view.png"),
                            ),
                            SizedBox(width: 10),
                            Image(
                              image: AssetImage("assets/images/location.png"),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text('10',
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(price,
                    style: GoogleFonts.nunito(
                        color: Color(0xff1173AB),
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 5),
                Text(
                  location,
                  style: GoogleFonts.nunito(
                      color: Color(0xff000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 5),
                Text(desc,
                    style: GoogleFonts.nunito(
                        color: Color(0xff000000),
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Color(0xff000000), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/images/house.svg', // Replace with the path to your SVG file
                                width: 13,
                                height: 13,
                              ),
                              Text('${bedroom} bedroom flat',
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff000000), fontSize: 7))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Color(0xff000000), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/images/bathroom.svg', // Replace with the path to your SVG file
                                width: 13,
                                height: 13,
                              ),
                              Text('${bathroom} bathrooms',
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff000000), fontSize: 7))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Color(0xff000000), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/images/feet.svg', // Replace with the path to your SVG file
                                width: 13,
                                height: 13,
                              ),
                              Text('${sqr} sqr feet',
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff000000), fontSize: 7))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/agent.png'),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Adam Silver',
                                  style: GoogleFonts.nunito(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                              Text('Land agent',
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff1173AB),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 110,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Color(0xff1173AB),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Text('Rent it',
                                style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

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

// appbar title text
class AppbarTitle extends StatelessWidget {
  final String text;
  const AppbarTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.start,
        style: GoogleFonts.nunito(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800));
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
      padding: const EdgeInsets.all(20),
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
  const LabelTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        style: GoogleFonts.nunito(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700));
  }
}

// input
class CustomTextField extends StatelessWidget {
  final bool obscureText;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.obscureText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
          fillColor: Color(0xffeeeeee),
          filled: true,
          border: OutlineInputBorder(
              // borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          hintText: hintText),
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
            Image(image: AssetImage(img)),
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
                Image(image: AssetImage(img)),
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
  const UploadImg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage('assets/images/sample-upload.png'),
              fit: BoxFit.cover)),
    );
  }
}
