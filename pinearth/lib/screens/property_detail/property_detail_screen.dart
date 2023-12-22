// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/providers/properties/properties_list_provider.dart';
import 'package:pinearth/providers/user/my_listing_provider.dart';
import 'package:pinearth/screens/property_detail/property_detail_photo_screen.dart';
import 'package:pinearth/screens/property_detail/schedule_property_visit_screen.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import 'widgets/product_detail_widget.dart';
import 'widgets/seller_info_widget.dart';


class PropertyDetailScreen extends ConsumerStatefulWidget {
  const PropertyDetailScreen({
    super.key,
    required this.property
  });

  final PropertyModel property;

  @override
  ConsumerState<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends ConsumerState<PropertyDetailScreen> {
  final pageController = PageController();
  int pageIndex = 0;
  final propertyImagePageController = PageController();
  int propertyImagePageIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(propertyListProvider).loadPropertyDetail(widget.property.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final propertydetailstate = ref.watch(propertyListProvider).propertyDetailState;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body:  Builder(
        builder: (context) {
          if (propertydetailstate.isLoading()) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (propertydetailstate.isError()) {
            return Center(
              child: CustomErrorWidget(
                message: propertydetailstate.message, 
                onReload: () => ref.read(propertyListProvider).loadPropertyDetail(widget.property.id.toString())
              ),
            );
          }
          final property = propertydetailstate.data!;

          final isSaved = ref.watch(myPropertyListingProvider).isSaved(property.id.toString());

          return Column(
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Positioned.fill(
                      child: PageView.builder(
                        itemCount: property.houseView.length,
                        itemBuilder: (context, index) {
                          final homeView = property.houseView[index];
                          return CachedNetworkImage(
                            imageUrl: homeView.houseView.addRemotePath,
                            fit: BoxFit.cover,
                          );
                        },
                        controller: propertyImagePageController,
                        onPageChanged: (int index) {
                          setState(() {
                            propertyImagePageIndex = index;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      )
                    ),
                    Positioned(
                      bottom: 60,
                      left: 40,
                      child: Transform.rotate(
                        angle: 100.7,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: property.available ? Colors.white : Colors.red,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          child: Text(property.available ? "${property.propertyStatus.toUpperCase()}" : "UNAVAILABLE", style: TextStyle(
                            fontSize: 20.toFontSize(), fontWeight: FontWeight.w800, 
                            color: property.available ? Colors.white : Colors.red
                          ),)
                        ),
                      )
                    ),

                    Positioned(
                      bottom: 10, left: 22, right: 20,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (isSaved) {                                
                                ref.read(myPropertyListingProvider).unSaveProperty(property.id.toString());
                              } else {
                                ref.read(myPropertyListingProvider).saveProperty(property.id.toString());
                              }
                            },
                            child: Column(
                              children: [
                                Icon(
                                  isSaved ? Icons.bookmark : Icons.bookmark_outline, color: Colors.white,),
                                Text(isSaved ? "Saved!" : "Save", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.toFontSize(),
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                          ),
                          Spacer(),
                          Text("${(propertyImagePageIndex + 1)}/${property.houseView.length}", style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.toFontSize(),
                            fontWeight: FontWeight.w600
                          ),),
                          26.toRowSpace(),
                          InkWell(
                            child: SvgPicture.asset("expand".svg, width: 15,)
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              10.toColumnSpace(),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PropertyDetailTabWidget(
                        title: "Details",
                        onClick: () {
                          pageController.animateToPage(0, duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
                        },
                        isSelected: pageIndex == 0
                      ),
                    ),
                    40.toRowSpace(),
                    Expanded(
                      child: PropertyDetailTabWidget(
                        title: "Images",
                        onClick: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetailPhotoScreen(property: property)));
                        },
                        isSelected: false,
                      ),
                    ),
                    40.toRowSpace(),
                    Expanded(
                      child: PropertyDetailTabWidget(
                        title: "Seller Info",
                        onClick: () {
                          pageController.animateToPage(1, duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
                        },
                        isSelected: pageIndex == 1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (int p) {
                    setState(() {
                      pageIndex = p;
                    });
                  },
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    PropertyDetailWidget(
                      property: property,
                    ),
                    SelletInfoWidget(
                      property: property,
                    )
                  ],
                ),
              ),
              10.toColumnSpace(),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color(0xff1173AB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SchedulePropertyVisitScreen(
                            property: property,
                          )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Schedule a visit',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                ),
              ),
              10.toColumnSpace(),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Container(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Park Smith Properties',
              //               style: GoogleFonts.nunito(
              //                   color: Colors.black,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //             Image(image: AssetImage('assets/images/call.png'))
              //           ],
              //         ),
              //         SizedBox(height: 10),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             LabelProperty(text: 'Property features'),
              //           ],
              //         ),
              //         SizedBox(height: 10),
              //         Row(
              //           children: [
              //             PropertyFeature(text: '2 Story building'),
              //             SizedBox(width: 20),
              //             PropertyFeature(text: '3 bedrooms'),
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //         // Row(
              //         //   mainAxisAlignment: MainAxisAlignment.start,
              //         //   children: [
              //         //     LabelProperty(text: 'Address'),
              //         //   ],
              //         // ),
              //         // SizedBox(height: 10),
              //         // Row(
              //         //   children: [
              //         //     PropertyFeature(
              //         //         text:
              //         //             '2972 Westheimer Rd. Santa Ana, Illinois 85486 '),
              //         //   ],
              //         // ),
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             LabelProperty(text: 'Price'),
              //           ],
              //         ),
              //         SizedBox(height: 10),
              //         Row(
              //           children: [
              //             Price(price: '200'),
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             LabelProperty(text: 'Map'),
              //           ],
              //         ),
              //         SizedBox(height: 10),
              //         Container(
              //           width: double.infinity,
              //           height: 150,
              //           decoration: BoxDecoration(
              //               image: DecorationImage(
              //                   image: AssetImage('assets/images/map.png'))),
              //         ),
              //         SizedBox(height: 30),
              
              //       ],
              //     ),
              //   ),
              // )
            ],
          );
        }
      ),
    ));
  }
}

class PropertyDetailTabWidget extends StatelessWidget {
  const PropertyDetailTabWidget({
    super.key,
    required this.title,
    required this.onClick,
    this.isSelected = false
  });

  final Function onClick;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Text(
              '$title',
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            6.toColumnSpace(),
            Container(
              color: isSelected ? appColor.primary : Colors.transparent,
              height: 4,
            )
          ],
        ),
      ),
    );
  }
}
