import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/screens/registration/register_as_agent/about_registration_screen.dart';
import 'package:pinearth/screens/registration/register_as_agent/agent_detail_screen.dart';
import 'package:pinearth/utils/constants/app_constants.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 40, left: 14, bottom: 0),
            child: Text("Register business profile",
                style: GoogleFonts.nunito(color: Colors.white, fontSize: 20))),
        ListTile(
          title: const DrawerLinks(
            text: 'Register as an Agent',
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AboutAgentRegistrationScreen(
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
                    builder: (context) => const AboutAgentRegistrationScreen(
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
                    builder: (context) => const AboutAgentRegistrationScreen(
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
                    builder: (context) => const AboutAgentRegistrationScreen(
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
                    builder: (context) => const AboutAgentRegistrationScreen(
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
                    builder: (context) => const AboutAgentRegistrationScreen(
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
                    builder: (context) => const AboutAgentRegistrationScreen(
                          agentType: shortletAgentType,
                        )));
          },
        ),
        // ListTile(
        //   title: Text("Shop"),
        //   onTap: () {},
        // ),
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
