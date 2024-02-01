// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:pinearth/providers/user/my_listing_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/auth/login_screen.dart';
import 'package:pinearth/screens/root_screen.dart';
import 'package:pinearth/screens/search_screen.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/property_widget.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

import '../custom_widgets/custom_widgets.dart';

class SavedHomesScreen extends ConsumerStatefulWidget {
  const SavedHomesScreen({super.key});

  @override
  ConsumerState<SavedHomesScreen> createState() => _SavedHomesScreenState();
}

class _SavedHomesScreenState extends ConsumerState<SavedHomesScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (ref.read(profileProvider).profileState.data == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        ref.read(myPropertyListingProvider).getSavedProperties();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final savedHomeState = ref.watch(myPropertyListingProvider).savedPropertyState;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AppbarTitle(
            padding: EdgeInsets.only(left: 30),
            text: 'Saved Homes',
          ),
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: Builder(
        builder: (context) {
          if (savedHomeState.isLoading()) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: LoadingPropertyWidget(),
            );
          }
          if (savedHomeState.isError()) {
            return Center(child: CustomErrorWidget(message: savedHomeState.message, onReload: () => ref.read(myPropertyListingProvider).getSavedProperties()));
          }
          final data = savedHomeState.data ?? [];
          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('no_saved_home'.svg, height: 150, width: 150,),
                  DescriptionText(
                    text: 'You have no saved homes, like a home for it to appear here',
                  ),
                  SizedBox(height: 90),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => RootScreen()),
                        (route)=>false
                      );
                    },
                    child: ActionButton(text: 'Back to homes')
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final property = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: PropertyWidget(
                  property: property,
                ),
              );
            },
          );
        }
      ),
    );
  }
}
