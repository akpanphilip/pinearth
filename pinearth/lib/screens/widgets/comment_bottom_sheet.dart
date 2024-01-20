import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../backend/domain/models/entities/property_model.dart';
import '../../custom_widgets/custom_widgets.dart';
import '../../utils/styles/colors.dart';

class CommentBottomSheet extends StatelessWidget {
  const CommentBottomSheet({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 1.5,
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("(${property.reviews.length}) comments",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ]),
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Row(children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: appColor.primary,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: Text(
                                "Aliquam porta nisl dolor, molestie pellentesque elit molestie in. Morbi metus neque, elementum ullam",
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                )))),
                  )
                ]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
              itemCount: 10),
        )),
        Padding(
            padding: const EdgeInsets.all(20),
            child: CustomTextField(
              obscureText: false,
              isFilled: false,
              // fillColor: Colors.white,
              hintText: "Comment",
              border: const UnderlineInputBorder(),
              suffixIcon: IconButton(
                  onPressed: () {
                    //send
                  },
                  icon: const Icon(Icons.send, color: Colors.black)),
            ))
      ]),
    );
  }
}
