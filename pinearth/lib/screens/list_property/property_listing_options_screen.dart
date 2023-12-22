// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/properties/list_property_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/list_property/property_photos_screen.dart';
import 'package:pinearth/screens/widgets/custom_drop_down.dart';
import 'package:pinearth/screens/widgets/input_fields/text_area_field.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

import '../../custom_widgets/custom_widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

class PropertyListingOptionScreen extends ConsumerStatefulWidget {
  const PropertyListingOptionScreen({super.key});

  @override
  ConsumerState<PropertyListingOptionScreen> createState() => _PropertyListingOptionScreenState();
}

class _PropertyListingOptionScreenState extends ConsumerState<PropertyListingOptionScreen> {

  @override
  Widget build(BuildContext context) {
    final listPropertyP = ref.watch(listPropertyProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: AppbarTitle(
          text: 'List property',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Do you want to sell or rent this property',
              //     style: GoogleFonts.nunito(
              //         fontSize: 14, fontWeight: FontWeight.w700)
              //     ),
              // 10.toColumnSpace(),
              
              // CustomDropdownWidget<String>(
              //   items: [
              //     CustomDropDownItem(label: "For rent", value: 'rent'),
              //     CustomDropDownItem(label: "For sale", value: 'sale')
              //   ], 
              //   onSelect: (v) {
              //     listPropertyP.setLisingOption(v.value);
              //   },
              //   hintText: "Select an option",
              //   selected: listPropertyP.listingOption.isEmpty ? null : CustomDropDownItem(label: "For ${listPropertyP.listingOption}", value: '${listPropertyP.listingOption}'),
              // ),
              // 30.toColumnSpace(),

              LabelTitle(text: 'Name of property'),
              10.toColumnSpace(),
              CustomTextField(
                  obscureText: false, hintText: 'E.g Two bedroom in alakahia',
                  controller: listPropertyP.propertyNameController,
                ),
              20.toColumnSpace(),
              LabelTitle(text: 'Property price'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false, hintText: 'E.g 30,000,000',
                controller: listPropertyP.propertyPriceController,
                inputType: TextInputType.number,
              ),
              20.toColumnSpace(),

              LabelTitle(text: 'Description of property'),
              10.toColumnSpace(),
              TextAreaField(
                hintText: 'What  is special about this property',
                controller: listPropertyP.propertyDescriptionController,
              ),
              20.toColumnSpace(),

              Row(
                children: [
                  LabelTitle(text: 'Images of property'),
                  SizedBox(width: 15),
                  Text(
                    '*60 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              10.toColumnSpace(),
              GestureDetector(
                onTap: () => listPropertyP.selectPropertyImages(),
                child: Builder(
                  builder: (context) {
                    if (listPropertyP.propertyImages.isEmpty) {
                      return UploadImg();
                    }

                    return SelectedImagesWidget(images: listPropertyP.propertyImages);
                  },
                )
              ),

              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Color.fromARGB(162, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {},
                          child: Text('Back', style: GoogleFonts.nunito()))),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xff1173AB),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          if (listPropertyP.propertyNameController.text.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert("Please provide the property name.");
                            return;
                          }
                          if (listPropertyP.propertyDescriptionController.text.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert("Please provide the property description.");
                            return;
                          }
                          if (listPropertyP.propertyImages.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert("Please provide the property images.");
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PropertySectionPictureScreen()),
                          );
                        },
                        child: Text('Continue', style: GoogleFonts.nunito())),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
