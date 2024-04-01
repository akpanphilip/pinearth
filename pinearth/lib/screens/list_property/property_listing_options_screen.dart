// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/properties/list_property_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/list_property/property_photos_screen.dart';
import 'package:pinearth/screens/widgets/custom_drop_down.dart';
import 'package:pinearth/screens/widgets/input_fields/text_area_field.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

import '../../custom_widgets/custom_widgets.dart';
import '../../providers/user/profile_provider.dart';
import '../../utils/styles/colors.dart';
import 'property_spec_screen.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

class PropertyListingOptionScreen extends ConsumerStatefulWidget {
  const PropertyListingOptionScreen({super.key});

  @override
  ConsumerState<PropertyListingOptionScreen> createState() =>
      _PropertyListingOptionScreenState();
}

class _PropertyListingOptionScreenState
    extends ConsumerState<PropertyListingOptionScreen> {
  final _items = [
    CustomDropDownItem(label: "For Rent", value: 'rent'),
    CustomDropDownItem(label: "For sale", value: 'sale'),
    CustomDropDownItem(label: "shortlet", value: 'shortlet'),
  ];
  List<CustomDropDownItem<String>> rentDurations(String type) {
    return [
      if (type == "shortlet") CustomDropDownItem(label: "Day", value: 'day'),
      CustomDropDownItem(label: "Month", value: 'month'),
      CustomDropDownItem(label: "Year", value: 'year')
    ];
  }

  CustomDropDownItem<String> _selected =
      CustomDropDownItem(label: "For sale", value: 'sale');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _selected = _items.firstWhere((element) =>
          element.value ==
          ref.read<ListPropertyProvider>(listPropertyProvider).listingOption);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final listPropertyP = ref.watch<ListPropertyProvider>(listPropertyProvider);
    final profileRef = ref.watch(profileProvider);

    // print("role is ${profileRef.profileState.data?.role}");

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
        bottom: pageProgressWidget(progress: 0.2),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (profileRef.profileState.data?.role != landlordAgentType &&
                  profileRef.profileState.data?.role != shortletAgentType) ...[
                Text(
                    'How do you want to list as: eg Rent, Shortlet or for sale',
                    style: GoogleFonts.nunito(
                        fontSize: 14, fontWeight: FontWeight.w700)),
                10.toColumnSpace(),
                if (profileRef.profileState.data?.role == agentAgentType)
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor().inactiveColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("For Sale")),
                if (profileRef.profileState.data?.role == developerAgentType)
                  SizedBox(
                    width: 200,
                    child: CustomDropdownWidget<String>(
                      items: _items,
                      onSelect: (v) {
                        listPropertyP.setLisingOption(v.value);
                        _selected = v as CustomDropDownItem<String>;
                        if (v.value == "shortlet") {
                          listPropertyP.setRentDuration("day");
                        } else {
                          listPropertyP.setRentDuration("month");
                        }
                        setState(() {});
                      },
                      // hintText: "Select an option",
                      selected: _selected,
                    ),
                  ),
                30.toColumnSpace(),
              ],
              LabelTitle(text: 'Name of property'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false,
                hintText: 'E.g Two bedroom in alakahia',
                controller: listPropertyP.propertyNameController,
              ),
              20.toColumnSpace(),
              LabelTitle(
                  text: (listPropertyP.listingOption == "sale")
                      ? 'Property price'
                      : "Price of rent"),
              10.toColumnSpace(),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      obscureText: false,
                      hintText:
                          'E.g ${(listPropertyP.listingOption != "sale" || (profileRef.profileState.data?.role == landlordAgentType && profileRef.profileState.data?.role != shortletAgentType)) ? "200,000 / ${listPropertyP.rentDuration}" : "30,000,000"}',
                      controller: listPropertyP.propertyPriceController,
                      inputType: TextInputType.number,
                    ),
                  ),
                  if (listPropertyP.listingOption != "sale" ||
                      (profileRef.profileState.data?.role ==
                              landlordAgentType &&
                          profileRef.profileState.data?.role !=
                              shortletAgentType))
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: CustomDropdownWidget<String>(
                          items: rentDurations(listPropertyP.listingOption),
                          onSelect: (v) {
                            listPropertyP.setRentDuration(v.value);
                          },
                          selected: rentDurations(listPropertyP.listingOption)
                              .firstWhere((element) =>
                                  element.value == listPropertyP.rentDuration),
                        ),
                      ),
                    ),
                ],
              ),
              20.toColumnSpace(),
              if (profileRef.profileState.data?.role != landlordAgentType &&
                  profileRef.profileState.data?.role != shortletAgentType) ...[
                LabelTitle(text: 'Description of property'),
                10.toColumnSpace(),
                TextAreaField(
                  hintText: 'What  is special about this property',
                  controller: listPropertyP.propertyDescriptionController,
                ),
                20.toColumnSpace(),
              ],
              Row(
                children: [
                  LabelTitle(text: 'Images of property'),
                  SizedBox(width: 15),
                  Text(
                    '*${listPropertyP.listingOption == "sale" ? "60" : "20"} images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              10.toColumnSpace(),
              GestureDetector(
                  onTap: () => listPropertyP.selectPropertyImages(
                      fileType: FileType.image),
                  child: Builder(
                    builder: (context) {
                      if (listPropertyP.propertyImages.isEmpty) {
                        return UploadImg();
                      }

                      return SelectedImagesWidgetV2(
                          images: listPropertyP.propertyImages);
                    },
                  )),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SizedBox(
                  //     width: 150,
                  //     height: 50,
                  //     child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             elevation: 0,
                  //             backgroundColor: Color.fromARGB(162, 0, 0, 0),
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(8))),
                  //         onPressed: () {},
                  //         child: Text('Back', style: GoogleFonts.nunito()))),
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
                          if (profileRef.profileState.data?.role !=
                                  landlordAgentType &&
                              profileRef.profileState.data?.role !=
                                  shortletAgentType) {
                            if (listPropertyP
                                .propertyDescriptionController.text.isEmpty) {
                              getIt<IAlertInteraction>().showErrorAlert(
                                  "Please provide the property description.");
                              return;
                            }
                          }
                          if (listPropertyP
                              .propertyNameController.text.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide the property name.");
                            return;
                          }

                          if (listPropertyP.propertyImages.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide the property images.");
                            return;
                          }

                          if ((listPropertyP.listingOption == "sale" &&
                              listPropertyP.propertyImages.length > 60)) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Maxium allowed images of property sale is *60.");
                            return;
                          }

                          if ((listPropertyP.listingOption != "sale" &&
                              listPropertyP.propertyImages.length > 20)) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Maxium allowed images of property sale is *20.");
                            return;
                          }

                          if (listPropertyP.listingOption == "sale" &&
                              profileRef.profileState.data?.role !=
                                  developerAgentType) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PropertySectionPictureScreen()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PropertySpecScreen()),
                            );
                          }
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
