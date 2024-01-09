import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinearth/screens/list_property/property_listing_options_screen.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class CanListPropertyWidget extends StatelessWidget {
  const CanListPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: SvgPicture.asset('can_list_property'.svg),
        ),

        23.toColumnSpace(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hey there, Bussiness man", style: TextStyle(
                fontSize: 20.toFontSize(),
                fontWeight: FontWeight.w900,
                color: appColor.primary
              ),),
              9.toColumnSpace(),

              Text("You can now list properties since you have a bussiness account, here’s what you can do", style: TextStyle(
                fontSize: 16.toFontSize(),
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),),
              9.toColumnSpace(),
              Text("1. List properties", style: TextStyle(
                fontSize: 16.toFontSize(),
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),),
              2.toColumnSpace(),
              Text("2. Have access to unfiltered customer service", style: TextStyle(
                fontSize: 16.toFontSize(),
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),),
              2.toColumnSpace(),
              Text("3. Manage your properties", style: TextStyle(
                fontSize: 16.toFontSize(),
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),),

              47.toColumnSpace(),

              CustomButtonWidget(
                onClick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PropertyListingOptionScreen()));
                },
                color: appColor.primary,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 32),
                  child: const Text("List Property"),
                ),
              )
            ],
          ),
        ),
        
      ],
    );
  }
}