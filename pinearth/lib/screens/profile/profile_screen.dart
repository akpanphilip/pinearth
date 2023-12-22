// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/screens/profile/edit_business_profile_screen.dart';
import 'package:pinearth/screens/profile/edit_profile_screen.dart';
import 'package:pinearth/screens/how_to_use_screen.dart';
import 'package:pinearth/screens/profile/my_listed_properties/my_listed_properties_screen.dart';
import 'package:pinearth/screens/profile/security_screen.dart';
import 'package:pinearth/screens/registration/register_as_agent/agent_detail_screen.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';

import '../../custom_widgets/custom_widgets.dart';
import '../../providers/user/profile_provider.dart';
import '../customer_support_screen.dart';
import 'widgets/loading_profile_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(profileProvider).initialize(context);
    // if (ref.read(profileProvider).profileState.data == null) {
    
    // }
  }

  @override
  Widget build(BuildContext context) {
    final profileP = ref.watch(profileProvider);
    final profileState = profileP.profileState;
    bool hasRole = false;
    bool canList = false;
    if (profileState.data != null) {
      hasRole = profileState.data!.hasRole;
      canList = profileP.canList;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: AppbarTitle(
          text: 'Profile',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              if (profileState.isLoading()) {
                return LoadingProfileWidget();
              }
              if (profileState.isError()) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: CustomErrorWidget(
                    message: profileState.message, onReload: () => ref.read(profileProvider).initialize(context)
                  ),
                );
              }
              final profile = profileState.data!;
               return Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      if (!profile.hasRole) Image(image: AssetImage('assets/images/user.png')),
                      if (profile.hasRole) ClipRRect(
                        borderRadius: BorderRadius.circular(10000),
                        child: Builder(
                          builder: (context) {
                            final agentProfileState = ref.watch(profileProvider).agentProfileState;
                            if (agentProfileState.isLoading()) {
                              return SizedBox(
                                height: 100, width: 100,
                              );
                            }
                            if (agentProfileState.isError()) {
                              return SizedBox(
                                height: 100, width: 100,
                              );
                            }
                            return Container(
                              height: 100, width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    ref.read(profileProvider).agentProfileState.data['profile_photo'],
                                    maxWidth: 100, maxHeight: 100,
                                  ),
                                  fit: BoxFit.cover
                                )
                              ),
                            );
                          }
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text('${profile.firstName} ${profile.lastName}',
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700, fontSize: 18)),
                      ),
                      SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfileScreen()),
                          );
                        },
                        child: ProfileSection(
                          img: 'assets/images/edit.png',
                          text: 'Edit profile',
                        ),
                      ),
                      if (profile.hasRole) ...[
                        if (canList) GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyListedPropertiesScreen()),
                            );
                          },
                          child: ProfileSection(
                            img: 'assets/images/listed.png',
                            text: 'My listed properties',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ref.read(registerAsAgentProvider).agentType = profile.role;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditBusinessProfileScreen()),
                            );
                          },
                          child: ProfileSection(
                            img: 'assets/images/edit.png',
                            text: 'Edit business profile',
                          ),
                        ),
                      ],
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SecurityScreen()),
                          );
                        },
                        child: ProfileSection(
                          img: 'assets/images/security.png',
                          text: 'Security',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HowToUse()),
                          );
                        },
                        child: ProfileSection(
                          img: 'assets/images/how.png',
                          text: 'How to use?',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerSupportScreen()));
                        },
                        child: ProfileSection(
                          img: 'assets/images/customer-support.png',
                          text: 'Customer support',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(profileProvider).logout(context);
                        },
                        child: ProfileSection(
                          img: '',
                          text: 'Logout',
                        ),
                      )
                    ],
                  ),
                )
              );
            }
          ),
        ),
      ),
    );
  }
}
