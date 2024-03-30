// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/backend/domain/models/entities/user_search_result_model.dart';
import 'package:pinearth/controller/form_validator.dart';
import 'package:pinearth/providers/properties/list_property_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/list_property/property_owner_screen.dart';
import 'package:pinearth/screens/list_property/widgets/property_listing_back_button.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../custom_widgets/custom_widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

import '../../utils/constants/app_constants.dart';
import '../widgets/custom_drop_down.dart';
import 'special_property_spec_screen.dart';

class PropertySpecScreen extends ConsumerStatefulWidget {
  const PropertySpecScreen({super.key});

  @override
  ConsumerState<PropertySpecScreen> createState() => _PropertySpecScreenState();
}

class _PropertySpecScreenState extends ConsumerState<PropertySpecScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final listpropertyprovider = ref.watch(listPropertyProvider);
    final user = ref.watch(profileProvider).profileState.data!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, // Set the desired color here
          ),
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: AppbarTitle(
            padding: EdgeInsets.only(left: 20),
            text: 'Tell us about this property',
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0.5,
          bottom: pageProgressWidget(progress: 0.5)),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelTitle(text: 'Property Type'),
                        10.toColumnSpace(),
                        CustomTextField(
                          maxHeight: double.infinity,
                          obscureText: false,
                          hintText: 'E.g (bungalow etc)',
                          validator: Validator.validateEmptyField,
                          controller:
                              listpropertyprovider.propertyTypeController,
                        ),
                        20.toColumnSpace(),
                        LabelTitle(text: 'Number of rooms'),
                        10.toColumnSpace(),
                        CustomTextField(
                          maxHeight: double.infinity,
                          obscureText: false,
                          hintText: 'E.g 1 room',
                          validator: Validator.validateEmptyField,
                          controller:
                              listpropertyprovider.numberOfRoomsController,
                          inputType: TextInputType.number,
                        ),
                        20.toColumnSpace(),
                        LabelTitle(text: 'Number of bathroom\'s'),
                        10.toColumnSpace(),
                        CustomTextField(
                          maxHeight: double.infinity,
                          obscureText: false,
                          validator: Validator.validateEmptyField,
                          hintText: 'E.g 3 bathrooms',
                          controller:
                              listpropertyprovider.numberOfBathroomController,
                          inputType: TextInputType.number,
                        ),
                        20.toColumnSpace(),
                        LabelTitle(text: 'Lot size(sqft)'),
                        10.toColumnSpace(),
                        CustomTextField(
                            maxHeight: double.infinity,
                            obscureText: false,
                            validator: Validator.validateEmptyField,
                            hintText: 'E.g 173 Square feet',
                            controller:
                                listpropertyprovider.propertyLotSizeController,
                            inputType: TextInputType.number,
                            suffixIcon: HelpButton(
                              text: "Sqft",
                              helpIcon: Icon(
                                Icons.help_outline_rounded,
                                color: Colors.white,
                              ),
                            )),
                        20.toColumnSpace(),
                        LabelTitle(text: 'Address Of Property'),
                        10.toColumnSpace(),
                        CustomTextField(
                          maxHeight: double.infinity,
                          validator: Validator.validateEmptyField,
                          obscureText: false,
                          hintText: '2118 Thromming',
                          controller:
                              listpropertyprovider.propertyAddressController,
                        ),
                        20.toColumnSpace(),
                        LabelTitle(text: 'Property State'),
                        10.toColumnSpace(),
                        CustomDropdownWidget<String>(
                          items: nigerianState
                              .map(
                                  (e) => CustomDropDownItem(label: e, value: e))
                              .toList(),
                          onSelect: (v) {
                            // listPropertyP.setRentDuration(v.value);
                            listpropertyprovider.updateSelectedState = v.value;
                          },
                          selected: CustomDropDownItem(
                              label: listpropertyprovider.selectedState,
                              value: listpropertyprovider.selectedState),
                        ),
                        if (user.role == "Agent" &&
                            listpropertyprovider.listingOption == "sale") ...[
                          20.toColumnSpace(),
                          LabelTitle(text: 'Owner Of Property'),
                          10.toColumnSpace(),
                          CustomTextField(
                            obscureText: false,
                            hintText: 'Select property owner',
                            controller: listpropertyprovider.ownerController,
                            readOnly: true,
                            suffixIcon: Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              final owner = await showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return PropertyOwnerScreen();
                                  },
                                  isScrollControlled: true);
                              if (owner != null) {
                                listpropertyprovider
                                    .setOwner(owner as UserSearchResultModel);
                              }
                            },
                          ),
                        ],
                        30.toColumnSpace(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: PropertyListingBackButton()),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: CustomButtonWidget(
                            onClick: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PropertySpecialSpecScreen()),
                              );
                            },
                            color: appColor.primary,
                            child:
                                Text('Continue', style: GoogleFonts.nunito())),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
