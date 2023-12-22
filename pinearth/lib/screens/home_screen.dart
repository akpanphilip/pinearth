// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/providers/properties/properties_list_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/search/search_screen.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/side_bar_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import 'widgets/empty_state_widget.dart';
import 'widgets/input_fields/search_input_field.dart';
import 'widgets/property_category_tile_widget.dart';
import 'widgets/property_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  String currentClass = "All";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(propertyListProvider).loadProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    final propertyListP = ref.watch(propertyListProvider);
    final propertyListState = propertyListP.propertyListState;

    // final user = ref.watch(profileProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 5, 113, 201),
              // height: 125,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Consumer(
                        builder: (ctx, ref, child) {
                          final user = ref.watch(profileProvider).profileState.data;
                          final isLoggedIn = user != null;
                          // const hasRole = false;
                          final hasRole = isLoggedIn && user.hasRole == true;
                          return !isLoggedIn ? SizedBox.shrink() : !hasRole ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () => Scaffold.of(context).openDrawer(),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                              11.toRowSpace(),
                            ],
                          ) : SizedBox.shrink();
                        }
                      ),
                      
                      Expanded(
                        child: GestureDetector(
                          
                          child: SearchPropertyFieldWidget(
                            controller: propertyListP.searchParamController,
                            readOnly: true,
                            onClick: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  PropertyClassTileWidget(
                    onClassChange: (String propertyClass) {
                      setState(() {
                        currentClass = propertyClass;
                      });
                    },
                    currentClass: currentClass,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Container(
                width: 104,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffE6F1F7)
                ),
                child: Center(
                  child: Text(
                    'Properties',
                    style: GoogleFonts.nunito(color: Color(0xff1173AB)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (propertyListState.isLoading()) {
                    // return Center(
                    //   child: CircularProgressIndicator.adaptive(),
                    // );
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...[1,2,3].map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: LoadingPropertyWidget(),
                            );
                          })
                        ],
                      ),
                    );
                  }
                  if (propertyListState.isError()) {
                    return Center(
                      child: CustomErrorWidget(message: propertyListState.message, onReload: () => propertyListP.loadProperties())
                    );
                  }
                  List<PropertyModel> data = propertyListState.data ?? [];

                  if (currentClass != 'All') {
                    data = data.where((element) => element.propertyStatus.toLowerCase() == currentClass.toLowerCase()).toList();
                  }
                  
                  if (data.isEmpty) {
                    return EmptyStateWidget(
                      message: propertyListState.message,
                      onReload: () => propertyListP.loadProperties(),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.read(propertyListProvider).loadProperties();
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Center(
                            child: Text(currentClass == 'All' ? 'Featured Listings' : currentClass,
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w700
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          30.toColumnSpace(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...data.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: PropertyWidget(
                                      property: e,
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                              
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
