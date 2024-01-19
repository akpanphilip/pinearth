import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailWidget extends StatelessWidget {
  const PropertyDetailWidget({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            22.toColumnSpace(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.info_outlined),
                      const SizedBox(width: 10),
                      Text(
                        "${property.owner.firstName} ${property.owner.lastName}",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                if (property.owner.profile?.phoneNo != null &&
                    property.owner.profile?.phoneNo?.trim() != "")
                  GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(
                            "tel:${property.owner.profile?.phoneNo}"));
                      },
                      child: SvgPicture.asset("call_seller_icon".svg))
              ],
            ),
            14.toColumnSpace(),
            PropertyFeatureTitle(
              title: "Description of property",
              child: Text(
                property.desc!,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            14.toColumnSpace(),
            PropertyFeatureTitle(
              leading: SvgPicture.asset("help_clinic".svg),
              title: "Property features",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        property.propertyType!,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      24.toRowSpace(),
                      Text(
                        "${property.noOfRooms} bedrooms",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  14.toColumnSpace(),
                  Row(
                    children: [
                      Text(
                        "${property.lotSize} sqr feet",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      24.toRowSpace(),
                      Text(
                        "${property.noOfBathrooms} Bathrooms",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            10.toColumnSpace(),
            if (property.appliance?.trim() != "" &&
                property.appliance?.trim().toLowerCase() == "yes") ...[
              //Applicances
              14.toColumnSpace(),
              PropertyFeatureTitle(
                  leading: SvgPicture.asset("blender".svg),
                  title: "Appliances",
                  child: Wrap(
                    children: property.appliances
                        .map((appliance) => Text(
                              appliance.name ?? "",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ))
                        .toList(),
                  )),
              10.toColumnSpace(),
            ],
            14.toColumnSpace(),
            PropertyFeatureTitle(
              title: "Address",
              leading: SvgPicture.asset("assistant_direction".svg),
              child: Text(
                property.address!,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            10.toColumnSpace(),
            if (property.incomePerMonth != null &&
                property.incomePerMonth!.trim() != "")
              PropertyFeatureTitle(
                  leading: Image.asset("payments".png),
                  title: "Income generated from property per month",
                  child: Text(
                    "NGN ${num.parse(property.incomePerMonth!).formattedMoney(currency: "NGN")}",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  )),
            14.toColumnSpace(),
            PropertyFeatureTitle(
              leading: Image.asset("payments".png),
              title: "Price",
              child: Text(
                  num.parse(property.propertyPrice!)
                      .formattedMoney(currency: "NGN"),
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  )),
            ),
            10.toColumnSpace(),
            14.toColumnSpace(),
            PropertyFeatureTitle(
              title: "Map",
              leading: SvgPicture.asset("distance".svg),
              child: Image.asset('assets/images/map.png'),
            ),
            10.toColumnSpace(),
          ],
        ),
      ),
    );
  }
}

class PropertyFeatureTitle extends StatelessWidget {
  const PropertyFeatureTitle(
      {super.key, this.title = "Feature", this.leading, this.child});

  final String title;
  final Widget? leading;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 10),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 14.toFontSize(),
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              child ?? Container(),
            ],
          ),
        ),
      ],
    );
  }
}
