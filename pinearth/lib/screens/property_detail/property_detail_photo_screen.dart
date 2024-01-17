import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/screens/property_detail/widgets/view_image_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class PropertyDetailPhotoScreen extends StatelessWidget {
  const PropertyDetailPhotoScreen({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: const AppbarTitle(
          text: 'Property photo’s',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            27.toColumnSpace(),
            PropertyImageItem(
              title: "Photo of the property",
              images: property.houseView.map((e) => e.houseView).toList(),
            ),
            27.toColumnSpace(),
            PropertyImageItem(
              title: "Photo of the Living room",
              images: property.livingRoom.map((e) => e.livingRoom).toList(),
            ),
            27.toColumnSpace(),
            PropertyImageItem(
              title: "Photo of the Bedroom",
              images: property.bedRoom.map((e) => e.bedRoom).toList(),
            ),
            27.toColumnSpace(),
            PropertyImageItem(
              title: "Photo of the Bathroom",
              images: property.bedRoom.map((e) => e.bedRoom).toList(),
            ),
            27.toColumnSpace(),
            PropertyImageItem(
              title: "Photo of the Kitchen",
              images: property.kitchen.map((e) => e.kitchen).toList(),
            ),
            27.toColumnSpace(),
            PropertyImageItem(
              title: "Photo of the Kitchen",
              images: property.documents.map((e) => e.documents).toList(),
            ),
            27.toColumnSpace(),
            PropertyImageItem(
              title: "Photo of the House plan",
              images: property.housePlan.map((e) => e.housePlan).toList(),
            ),
            27.toColumnSpace(),
            PropertyImageItem(
              title: "Photos of the House size and dimensions",
              images: property.size.map((e) => e.size).toList(),
            ),
            23.toColumnSpace()
          ],
        ),
      ),
    );
  }
}

class PropertyImageItem extends StatelessWidget {
  const PropertyImageItem(
      {super.key, required this.title, required this.images});

  final String title;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            "$title",
            style: TextStyle(
                fontSize: 16.toFontSize(),
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ),
        27.toColumnSpace(),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...images.map((e) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                child: ViewImageWidget(
                                    title: title, images: images)),
                            // isScrollControlled: true,
                            // isDismissible: false
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: e.addRemotePath,
                          height: 110,
                          width: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
