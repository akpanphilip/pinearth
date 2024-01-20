// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/properties/list_property_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/list_property/widgets/property_listing_back_button.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../custom_widgets/custom_widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

import 'property_spec_screen.dart';

class PropertySectionPictureScreen extends ConsumerStatefulWidget {
  const PropertySectionPictureScreen({super.key});

  @override
  ConsumerState<PropertySectionPictureScreen> createState() =>
      _PropertySectionPictureScreenState();
}

class _PropertySectionPictureScreenState
    extends ConsumerState<PropertySectionPictureScreen> {
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
          padding: EdgeInsets.only(left: 20),
          text: 'Property photo\'s',
        ),
        centerTitle: false,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        bottom: pageProgressWidget(progress: 0.4),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Detailed living room photo’s'),
                  Text(
                    '*10 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              10.toColumnSpace(),
              GestureDetector(
                  onTap: () => listPropertyP.selectLivingRoomImages(
                      fileType: FileType.image),
                  child: Builder(
                    builder: (context) {
                      if (listPropertyP.livingRoomImages.isEmpty) {
                        return UploadImg();
                      }
                      return SelectedImagesWidget(
                          images: listPropertyP.livingRoomImages);
                    },
                  )),
              20.toColumnSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Detailed bedroom photo’s'),
                  Text(
                    '*10 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              10.toColumnSpace(),
              GestureDetector(
                  onTap: () => listPropertyP.selectBedRoomImages(
                      fileType: FileType.image),
                  child: Builder(
                    builder: (context) {
                      if (listPropertyP.bedRoomImages.isEmpty) {
                        return UploadImg();
                      }
                      return SelectedImagesWidget(
                          images: listPropertyP.bedRoomImages);
                    },
                  )),
              20.toColumnSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Detailed toilet photo\'s'),
                  Text(
                    '*10 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              10.toColumnSpace(),
              GestureDetector(
                  onTap: () => listPropertyP.selectToiletImages(
                      fileType: FileType.image),
                  child: Builder(
                    builder: (context) {
                      if (listPropertyP.toiletImages.isEmpty) {
                        return UploadImg();
                      }
                      return SelectedImagesWidget(
                          images: listPropertyP.toiletImages);
                    },
                  )),
              20.toColumnSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Detailed kitchen photo\'s'),
                  Text(
                    '*10 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              10.toColumnSpace(),
              GestureDetector(
                  onTap: () => listPropertyP.selectKitchenImages(
                      fileType: FileType.image),
                  child: Builder(
                    builder: (context) {
                      if (listPropertyP.kitchenImages.isEmpty) {
                        return UploadImg();
                      }
                      return SelectedImagesWidget(
                          images: listPropertyP.kitchenImages);
                    },
                  )),
              40.toColumnSpace(),
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
                          if (listPropertyP.livingRoomImages.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide at least 1 living room image");
                            return;
                          }
                          if (listPropertyP.bedRoomImages.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide at least 1 bedroom image");
                            return;
                          }
                          if (listPropertyP.toiletImages.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide at least 1 toilet image");
                            return;
                          }
                          if (listPropertyP.kitchenImages.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide at least 1 toilet image");
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PropertySpecScreen()),
                          );
                        },
                        color: appColor.primary,
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
