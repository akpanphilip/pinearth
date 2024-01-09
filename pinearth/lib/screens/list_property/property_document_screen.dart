// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/providers/properties/list_property_provider.dart';
import 'package:pinearth/screens/list_property/property_preview_screen.dart';
import 'package:pinearth/screens/list_property/widgets/property_listing_back_button.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../custom_widgets/custom_widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

import '../../locator.dart';
import '../feedback_alert/i_feedback_alert.dart';
import 'property_spec_screen.dart';

class PropertyDocumentScreen extends ConsumerStatefulWidget {
  const PropertyDocumentScreen({super.key});

  @override
  ConsumerState<PropertyDocumentScreen> createState() =>
      _PropertyDocumentScreenState();
}

class _PropertyDocumentScreenState
    extends ConsumerState<PropertyDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    final listpropertyprovider = ref.watch(listPropertyProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: AppbarTitle(
          padding: EdgeInsets.only(left: 20),
          text: 'Ownership documents',
        ),
        centerTitle: false,
        elevation: 0.5,
        bottom: pageProgressWidget(progress: 1),
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
                  LabelTitle(text: 'Upload image of Document for house'),
                  Text(
                    '*1 image min',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () => listpropertyprovider.selectPropertyDocuments(
                      fileType: FileType.image),
                  child: Builder(
                    builder: (context) {
                      if (listpropertyprovider.documentFiles.isEmpty) {
                        return UploadImg();
                      }
                      return SelectedImagesWidget(
                          images: listpropertyprovider.documentFiles);
                    },
                  )),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Upload image of House plan'),
                  Text(
                    '*60 images max',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () => listpropertyprovider.selectHousePlanDocuments(
                      fileType: FileType.image),
                  child: Builder(
                    builder: (context) {
                      if (listpropertyprovider.housePlanImages.isEmpty) {
                        return UploadImg();
                      }
                      return SelectedImagesWidget(
                          images: listpropertyprovider.housePlanImages);
                    },
                  )),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Upload image of House size & dimensions'),
                  Text(
                    '*1 images min',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () => listpropertyprovider.selectPropertySize(
                      fileType: FileType.image),
                  child: Builder(
                    builder: (context) {
                      if (listpropertyprovider.propertySizeImages.isEmpty) {
                        return UploadImg();
                      }
                      return SelectedImagesWidget(
                          images: listpropertyprovider.propertySizeImages);
                    },
                  )),
              SizedBox(height: 40),
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
                          if (listpropertyprovider.documentFiles.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide an image of the property document");
                            return;
                          }
                          if (listpropertyprovider.propertySizeImages.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide an image of the House size & dimensions");
                            return;
                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => PropertyPreviewScreen()),
                          // );
                          listpropertyprovider.listProperty(context);
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
