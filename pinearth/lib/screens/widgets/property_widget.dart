

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/user/my_listing_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/property_detail/property_detail_screen.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:redacted/redacted.dart';

import '../../utils/styles/colors.dart';

class PropertyWidget extends ConsumerWidget {
  const PropertyWidget({
    super.key,
    required this.property
  });

  final PropertyModel property;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(myPropertyListingProvider).isSaved(property.id.toString());
    final profileState = ref.read(profileProvider).profileState;
    final isLoggedIn = profileState.data != null;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PropertyDetailScreen(
            property: property,
          ),
        ));
      },
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 273, minWidth: 273
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xffE6F1F7), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffE6F1F7),
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 201,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                      ),
                      child: CachedNetworkImage(
                        imageUrl: "${property.houseView.first.houseView.addRemotePath}",
                        
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
    
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                      child: Text(property.propertyStatus, style: TextStyle(
                        fontSize: 14.toFontSize(), fontWeight: FontWeight.w700
                      ),),
                    ),
                  ),
    
                  Positioned(
                    bottom: 7,
                    right: 21,
                    left: 21,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (isLoggedIn) {
                              if (isSaved) {                                
                                ref.read(myPropertyListingProvider).unSaveProperty(property.id.toString());
                              } else {
                                ref.read(myPropertyListingProvider).saveProperty(property.id.toString());
                              }
                            } else {
                              getIt<IAlertInteraction>().showInfoAlert("You must be logged in to save a property");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.5),
                              borderRadius: BorderRadius.circular(2)
                            ),
                            padding: EdgeInsets.fromLTRB(8, 7, 7, 8),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  isSaved ? 'property_saved_icon'.svg : 'property_not_saved_icon'.svg,
                                  height: 20, width: 20,
                                ),
                                // Text(isSaved ? "Saved!" : "Save", style: TextStyle(
                                //   color: Colors.white,
                                //   fontSize: 12.toFontSize(),
                                //   fontWeight: FontWeight.w600
                                // ),)
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Column(
                          children: [
                            SvgPicture.asset("assets/svgs/propety_image_stat_indicator.svg"),
                            5.toColumnSpace(),
                            Text("${property.houseView.length}", style: TextStyle(
                              fontSize: 10.toFontSize(),
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),)
                          ],
                        ),
                        7.toRowSpace(),
                        SvgPicture.asset("assets/svgs/property_location_indicator.svg"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${(num.tryParse(property.propertyPrice) ?? 0).formattedMoney()} NGN/Month',
                    style: GoogleFonts.nunito(
                      color: const Color(0xff1173AB),
                      fontSize: 12,
                      fontWeight: FontWeight.w700
                    )
                  ),
                  5.toColumnSpace(),
                  Text(
                    '${property.title} in ${property.address}',
                    style: GoogleFonts.nunito(
                      color: const Color(0xff000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  5.toColumnSpace(),
                  Text(
                    '${property.desc}',
                    style: GoogleFonts.nunito(
                      color: const Color(0xff000000),
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                    )
                  ),
                  10.toColumnSpace(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xff000000),
                                width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                  SvgPicture.asset(
                                    'assets/images/house.svg', // Replace with the path to your SVG file
                                    width: 13,
                                    height: 13,
                                  ),
                                Text('${property.bedRoom.length} bedroom flat',
                                    style: GoogleFonts.nunito(
                                        color:
                                            const Color(0xff000000),
                                        fontSize: 7))
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xff000000),
                                width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/bathroom.svg', // Replace with the path to your SVG file
                                  width: 13,
                                  height: 13,
                                ),
                                Text('${property.noOfBathrooms} bathrooms',
                                    style: GoogleFonts.nunito(
                                        color:
                                            const Color(0xff000000),
                                        fontSize: 7))
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xff000000),
                                width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/feet.svg', // Replace with the path to your SVG file
                                  width: 13,
                                  height: 13,
                                ),
                                Text('${property.lotSize} sqr feet',
                                    style: GoogleFonts.nunito(
                                        color:
                                            const Color(0xff000000),
                                        fontSize: 7))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  21.toColumnSpace(),
    
                  Row(
                    children: [
                      InkWell(
                        // onTap: () => context.router,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage: CachedNetworkImageProvider(
                            property.owner.profile!.uploadId,
                            maxWidth: 30, maxHeight: 30
                          ),
                        ),
                      ),
                      6.toRowSpace(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${property.owner.lastName} ${property.owner.firstName}", style: GoogleFonts.nunito(
                              fontSize: 12.toFontSize(),
                              fontWeight: FontWeight.w600
                            ),),
                            Text("${property.owner.role}", style: GoogleFonts.nunito(
                              fontSize: 10.toFontSize(),
                              fontWeight: FontWeight.w600,
                              color: appColor.primary
                            ),),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: appColor.primary,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 7),
                        child: Center(
                          child: Text("View", style: TextStyle(
                            fontSize: 12.toFontSize(),
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          ),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class LoadingPropertyWidget extends StatelessWidget {
  const LoadingPropertyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 273, minWidth: 273, maxHeight: 400
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xffE6F1F7), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffE6F1F7),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 201,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                    ),
                  ),
                ),
    
                Positioned(
                  right: 20,
                  top: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                    child: Text("---", style: TextStyle(
                      fontSize: 14.toFontSize(), fontWeight: FontWeight.w700
                    ),),
                  ),
                ),
    
                Positioned(
                  bottom: 7,
                  right: 21,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          // SvgPicture.asset("assets/svgs/propety_image_stat_indicator.svg"),
                          // 5.toColumnSpace(),
                          Text("---", style: TextStyle(
                            fontSize: 10.toFontSize(),
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          ),)
                        ],
                      ),
                      7.toRowSpace(),
                      // SvgPicture.asset("assets/svgs/property_location_indicator.svg"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${(0).formattedMoney()} NGN/Month',
                  style: GoogleFonts.nunito(
                    color: const Color(0xff1173AB),
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                  )
                ),
                5.toColumnSpace(),
                Text(
                  '--- in ---',
                  style: GoogleFonts.nunito(
                    color: const Color(0xff000000),
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                5.toColumnSpace(),
                Text(
                  '------------------------------------------',
                  style: GoogleFonts.nunito(
                    color: const Color(0xff000000),
                    fontSize: 12,
                    fontWeight: FontWeight.w400
                  )
                ),
                10.toColumnSpace(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xff000000),
                              width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                                // SvgPicture.asset(
                                //   'assets/images/house.svg', // Replace with the path to your SVG file
                                //   width: 13,
                                //   height: 13,
                                // ),
                              Text('--- bedroom flat',
                                  style: GoogleFonts.nunito(
                                      color:
                                          const Color(0xff000000),
                                      fontSize: 7))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xff000000),
                              width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              // SvgPicture.asset(
                              //   'assets/images/bathroom.svg', // Replace with the path to your SVG file
                              //   width: 13,
                              //   height: 13,
                              // ),
                              Text('--- bathrooms',
                                  style: GoogleFonts.nunito(
                                      color:
                                          const Color(0xff000000),
                                      fontSize: 7))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xff000000),
                              width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              // SvgPicture.asset(
                              //   'assets/images/feet.svg', // Replace with the path to your SVG file
                              //   width: 13,
                              //   height: 13,
                              // ),
                              Text('--- sqr feet',
                                  style: GoogleFonts.nunito(
                                      color:
                                          const Color(0xff000000),
                                      fontSize: 7))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                21.toColumnSpace(),
    
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                    ),
                    6.toRowSpace(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("---- ----", style: GoogleFonts.nunito(
                            fontSize: 12.toFontSize(),
                            fontWeight: FontWeight.w600
                          ),),
                          Text("---", style: GoogleFonts.nunito(
                            fontSize: 10.toFontSize(),
                            fontWeight: FontWeight.w600,
                            color: appColor.primary
                          ),),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: appColor.primary,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 7),
                      child: Center(
                        child: Text("View", style: TextStyle(
                          fontSize: 12.toFontSize(),
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ).redacted(context: context, redact: true);
  }
}