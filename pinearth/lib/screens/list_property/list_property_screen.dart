// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/auth/login_screen.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/find_agent/find_agent_screen.dart';
import 'package:pinearth/screens/list_property/property_listing_options_screen.dart';
import 'package:pinearth/screens/list_property/widgets/feature_not_available_widget.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../custom_widgets/custom_widgets.dart';
import 'widgets/can_list_property_widget.dart';

class ListPropertyScreen extends ConsumerStatefulWidget {
  const ListPropertyScreen({super.key});

  @override
  ConsumerState<ListPropertyScreen> createState() => _ListPropertyScreenState();
}

class _ListPropertyScreenState extends ConsumerState<ListPropertyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      if (ref.read(profileProvider).profileState.data == null) {
        Future.delayed(Duration.zero, () {
          getIt<IAlertInteraction>()
              .showInfoAlert("You must be logged in to continue");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      } else {
        // final user = ref.read(profileProvider).profileState.data!;
        // if (user.hasRole) {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyListingOptionScreen()));
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileRef = ref.watch(profileProvider);
    final profileState = profileRef.profileState;
    final profile = profileState.data!;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.black, // Set the desired color here
          ),
          backgroundColor: Colors.white,
          title: AppbarTitle(
            padding: EdgeInsets.only(left: 30),
            text: 'List property',
          ),
          centerTitle: false,
          elevation: 0.5,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: profile.hasRole == true
                ? CanListPropertyWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: double.infinity,
                          child: Image(image: AssetImage('list-property'.png))),
                      37.toColumnSpace(),
                      Text(
                        'Sell with a Pinearth partner agent',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff1173AB),
                            fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Not in a market with Pinearth’s new selling experience? Work with a real estate agent for selling support at every step, including prepping, listing and marketing your home.',
                        style: GoogleFonts.nunito(fontSize: 14),
                      ),
                      SizedBox(height: 15),
                      // ButtonSn(text: 'Find an agent'),
                      SizedBox(
                          child: CustomButtonWidget(
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FindAgentScreen(
                                            type: agentAgentType,
                                          )),
                                );
                              },
                              color: appColor.primary,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Text('Find an agent',
                                    style: GoogleFonts.nunito()),
                              ))),
                      SizedBox(height: 50),
                      Text(
                        'Sell your property by yourself',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff1173AB),
                            fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Not in a market with Pinearth’s new selling experience? Work with a real estate agent for selling support at every step, including prepping, listing and marketing your home.',
                        style: GoogleFonts.nunito(fontSize: 14),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                          child: CustomButtonWidget(
                              onClick: () {
                                if (profile != null &&
                                    profile.hasRole! &&
                                    profileRef.canList) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PropertyListingOptionScreen()),
                                  );
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          FeatureNotAvailableWidget());
                                }
                              },
                              color: appColor.primary,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Text('Sell it yourself',
                                    style: GoogleFonts.nunito()),
                              )))
                    ],
                  ),
          ),
        )));
  }
}
