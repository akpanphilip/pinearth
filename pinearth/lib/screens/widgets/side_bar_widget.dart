import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/screens/registration/register_as_agent/about_registration_screen.dart';
import 'package:pinearth/screens/registration/register_as_agent/agent_detail_screen.dart';
import 'package:pinearth/utils/constants/app_constants.dart';

import '../../backend/application/servicies/localstorage/hive.local_storage.service.dart';
import '../../utils/constants/local_storage_keys.dart';

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({super.key});

  @override
  State<SideBarWidget> createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  bool showHelpOverlay = false;
  final localStorage = HiveLocalStorageService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final value = await localStorage.getItem(userDataBoxKey, seenHowToKey,
      //     defaultValue: false);

      await localStorage.setItem(userDataBoxKey, seenHowToKey, true);

      // if (!value) {
      //   showHelpOverlay = true;
      //   setState(() {});
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 40, left: 14, bottom: 0),
                child: Text("Register business profile",
                    style:
                        GoogleFonts.nunito(color: Colors.white, fontSize: 20))),
            ListTile(
              title: const DrawerLinks(
                text: 'Register as an Agent',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AboutAgentRegistrationScreen(
                              agentType: agentAgentType,
                            )));
              },
            ),
            ListTile(
              title: const DrawerLinks(
                text: 'Register as a Landlord',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AboutAgentRegistrationScreen(
                              agentType: landlordAgentType,
                            )));
              },
            ),
            ListTile(
              title: const DrawerLinks(
                text: 'Register as a Developer',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AboutAgentRegistrationScreen(
                              agentType: developerAgentType,
                            )));
              },
            ),
            ListTile(
              title: const DrawerLinks(
                text: 'Register as a Bank',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AboutAgentRegistrationScreen(
                              agentType: bankAgentType,
                            )));
              },
            ),
            ListTile(
              title: const DrawerLinks(
                text: 'Register as a Hotel',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AboutAgentRegistrationScreen(
                              agentType: hotelAgentType,
                            )));
              },
            ),
            ListTile(
              title: const DrawerLinks(
                text: 'Register as an Event Center',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AboutAgentRegistrationScreen(
                              agentType: eventCenterAgentType,
                            )));
              },
            ),
            ListTile(
              title: const DrawerLinks(
                text: 'Register as a Short-let',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AboutAgentRegistrationScreen(
                              agentType: shortletAgentType,
                            )));
              },
            ),
            // ListTile(
            //   title: Text("Shop"),
            //   onTap: () {},
            // ),
          ],
        ),
        if (showHelpOverlay)
          Positioned.fill(
            child: GestureDetector(
              onTap: () async {
                await localStorage.setItem(userDataBoxKey, seenHowToKey, true);
                showHelpOverlay = false;
                setState(() {});
              },
              child: Container(
                color: Colors.black38,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 100,
                      bottom: 190,
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    Positioned(
                        left: 40,
                        bottom: 50,
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                              "Register as one of the available profile types here",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        )),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}

class DrawerLinks extends StatelessWidget {
  final String text;

  const DrawerLinks({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(color: Colors.white, fontSize: 16),
    );
  }
}
