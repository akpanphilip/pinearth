// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/providers/properties/list_property_provider.dart';
import 'package:pinearth/screens/list_property/property_document_screen.dart';
import 'package:pinearth/screens/list_property/widgets/property_listing_back_button.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/screens/widgets/custom_drop_down.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../custom_widgets/custom_widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

import 'property_spec_screen.dart';

class PropertySpecialSpecScreen extends ConsumerStatefulWidget {
  const PropertySpecialSpecScreen({super.key});

  @override
  ConsumerState<PropertySpecialSpecScreen> createState() => _PropertySpecialSpecScreenState();
}

class _PropertySpecialSpecScreenState extends ConsumerState<PropertySpecialSpecScreen> {
  @override
  Widget build(BuildContext context) {
    final listpropertyprovider = ref.watch(listPropertyProvider);
    final hasParkingSpace = listpropertyprovider.propertyHasPackingSpaceController.text;
    final hasAppliances = listpropertyprovider.propertyHasAppliancesController.text;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: AppbarTitle(
          text: 'Tell us about this property',
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
              LabelTitle(text: 'Income Per Month'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false, hintText: 'E.g 100,000 naira',
                controller: listpropertyprovider.propertyIncomePerYearController,
                inputType: TextInputType.number,
              ),
              20.toColumnSpace(),
              LabelTitle(text: 'Year Built'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false, hintText: 'E.g 2000',
                controller: listpropertyprovider.propertyYearBuiltController,
                inputType: TextInputType.number,
              ),

              20.toColumnSpace(),
              LabelTitle(text: 'Year Renovated'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false, hintText: 'E.g 2010',
                controller: listpropertyprovider.propertyYearRenovatedController,
                inputType: TextInputType.number,
              ),

              20.toColumnSpace(),
              LabelTitle(text: 'Year Reconstructed'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false, hintText: 'E.g 2023',
                controller: listpropertyprovider.propertyYearReconstructedController,
                inputType: TextInputType.number,
              ),

              20.toColumnSpace(),
              LabelTitle(text: 'Is There Available Parking Space?'),
              10.toColumnSpace(),
              CustomDropdownWidget<String>(
                items: [
                  CustomDropDownItem(label: "Yes", value: 'Yes'),
                  CustomDropDownItem(label: "No", value: 'No')
                ], 
                onSelect: (v) {
                  listpropertyprovider.propertyHasPackingSpaceController.text = (v.value);
                  listpropertyprovider.notifyListeners();
                },
                hintText: "Select an option",
                selected: hasParkingSpace.isEmpty ? null : CustomDropDownItem(label: hasParkingSpace, value: hasParkingSpace),
              ),

              20.toColumnSpace(),
              LabelTitle(text: 'Is There Other Appliances?'),
              10.toColumnSpace(),
              CustomDropdownWidget<String>(
                items: [
                  CustomDropDownItem(label: "Yes", value: 'Yes'),
                  CustomDropDownItem(label: "No", value: 'No')
                ], 
                onSelect: (v) {
                  listpropertyprovider.propertyHasAppliancesController.text = (v.value);
                  listpropertyprovider.notifyListeners();
                },
                hintText: "Select an option",
                selected: hasAppliances.isEmpty ? null : CustomDropDownItem(label: hasAppliances, value: hasAppliances),
              ),

              if (listpropertyprovider.propertyHasAppliancesController.text == "Yes") ...[
                20.toColumnSpace(),
                LabelTitle(text: 'What appliances are on the property'),
                10.toColumnSpace(),
                CustomTextField(
                  obscureText: false, hintText: 'E.g Fridge, Grinder, Washing machine',
                  controller: TextEditingController(),
                  inputType: TextInputType.text,
                ),
              ],

              20.toColumnSpace(),
              LabelTitle(text: 'Google map address'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false, hintText: 'E.g https://map.com',
                controller: listpropertyprovider.propertyGoogleMapController,
                inputType: TextInputType.url,
              ),
              
              30.toColumnSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: PropertyListingBackButton()
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: CustomButtonWidget(
                      color: appColor.primary,
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PropertyDocumentScreen()),
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
