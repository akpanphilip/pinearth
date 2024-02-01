import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/screens/profile/edit_business_profile_screen.dart';
import 'package:pinearth/screens/profile/edit_profile_screen.dart';
import 'package:pinearth/screens/profile/how_to_use_screen.dart';
import 'package:pinearth/screens/profile/my_listed_properties/my_listed_properties_screen.dart';
import 'package:pinearth/screens/profile/security_screen.dart';
import 'package:pinearth/screens/registration/register_as_agent/agent_detail_screen.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider).initialize(context);
    });
    // if (ref.read(profileProvider).profileState.data == null) {

    // }
  }

  @override
  Widget build(BuildContext context) {
    final profileP = ref.watch(profileProvider);
    final profileState = profileP.profileState;
    // bool hasRole = false;
    bool canList = false;
    if (profileState.data != null) {
      // hasRole = profileState.data!.hasRole!;
      canList = profileP.canList;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: const AppbarTitle(
          padding: EdgeInsets.only(left: 30),
          text: 'Profile',
        ),
        centerTitle: false,
        elevation: 0.5,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Builder(builder: (context) {
            if (profileState.isLoading()) {
              return const LoadingProfileWidget();
            }
            if (profileState.isError()) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: CustomErrorWidget(
                    message: profileState.message,
                    onReload: () =>
                        ref.read(profileProvider).initialize(context)),
              );
            }
            final profile = profileState.data!;

            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      profileP.updateProfilePicture();
                    },
                    child: Column(
                      children: [
                        (profileP.newProfilePic != "")
                            ? SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10000),
                                    child: Image.file(
                                        File(profileP.newProfilePic))),
                              )
                            : Column(
                                children: [
                                  (!profile.hasRole!)
                                      ? const Image(
                                          image: AssetImage(
                                              'assets/images/user.png'))
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10000),
                                          child: Builder(
                                            builder: (context) {
                                              if (profile.hasRole!) {
                                                if (profile.role == "Bank") {
                                                  return (profile.profile
                                                                  ?.avatar ==
                                                              null ||
                                                          profile.profile
                                                                  ?.avatar
                                                                  ?.trim() ==
                                                              "")
                                                      ? const Image(
                                                          image: AssetImage(
                                                              'assets/images/user.png'))
                                                      : Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    profile
                                                                        .profile
                                                                        ?.avatar,
                                                                    maxWidth:
                                                                        100,
                                                                    maxHeight:
                                                                        100,
                                                                  ),
                                                                  fit: BoxFit.cover)),
                                                        );
                                                }
                                                if (profile.role ==
                                                    developerAgentType) {
                                                  return (profileP
                                                                  .developerProfileState
                                                                  .data
                                                                  ?.profilePhoto ==
                                                              null ||
                                                          profileP
                                                                  .developerProfileState
                                                                  .data
                                                                  ?.profilePhoto!
                                                                  .trim() ==
                                                              "")
                                                      ? const Image(
                                                          image: AssetImage(
                                                              'assets/images/user.png'))
                                                      : Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    profileP
                                                                            .developerProfileState
                                                                            .data!
                                                                            .profilePhoto ??
                                                                        "",
                                                                    maxWidth:
                                                                        100,
                                                                    maxHeight:
                                                                        100,
                                                                  ),
                                                                  fit: BoxFit.cover)),
                                                        );
                                                }
                                              }
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10000),
                                                child:
                                                    Builder(builder: (context) {
                                                  final agentProfileState = ref
                                                      .watch(profileProvider)
                                                      .agentProfileState;

                                                  if (agentProfileState
                                                      .isLoading()) {
                                                    return const Image(
                                                        image: AssetImage(
                                                            'assets/images/user.png'));
                                                  }
                                                  if (agentProfileState
                                                      .isError()) {
                                                    return const Image(
                                                        image: AssetImage(
                                                            'assets/images/user.png'));
                                                  }

                                                  return (ref
                                                                  .read(
                                                                      profileProvider)
                                                                  .agentProfileState
                                                                  .data?[
                                                              'profile_photo'] ==
                                                          null)
                                                      ? const Image(
                                                          image: AssetImage(
                                                              'assets/images/user.png'))
                                                      : Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                    ref
                                                                        .read(
                                                                            profileProvider)
                                                                        .agentProfileState
                                                                        .data['profile_photo'],
                                                                    maxWidth:
                                                                        100,
                                                                    maxHeight:
                                                                        100,
                                                                  ),
                                                                  fit: BoxFit.cover)),
                                                        );
                                                }),
                                              );
                                            },
                                          ),
                                        )
                                ],
                              )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Builder(builder: (context) {
                    if (profile.role == developerAgentType) {
                      if (profileP.developerProfileState.data != null) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                                '${profileP.developerProfileState.data?.companyName}',
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w700, fontSize: 18)),
                            const SizedBox(
                              width: 10,
                            ),
                            if (profileP.developerProfileState.data!
                                        .isVerified !=
                                    null &&
                                profileP
                                    .developerProfileState.data!.isVerified!)
                              SvgPicture.asset("verified".svg),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Center(
                        child: Text('${profile.firstName} ${profile.lastName}',
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700, fontSize: 18)),
                      );
                    }
                  }),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()),
                      );
                    },
                    child: const ProfileSection(
                      img: 'assets/images/edit.png',
                      text: 'Edit profile',
                    ),
                  ),
                  if (profile.hasRole!) ...[
                    if (canList)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyListedPropertiesScreen()),
                          );
                        },
                        child: const ProfileSection(
                          img: 'assets/images/listed.png',
                          text: 'My listed properties',
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        ref.read(registerAsAgentProvider).agentType =
                            profile.role!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EditBusinessProfileScreen()),
                        );
                      },
                      child: const ProfileSection(
                        img: 'assets/images/edit.png',
                        text: 'Edit business profile',
                      ),
                    ),
                  ],
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SecurityScreen()),
                      );
                    },
                    child: const ProfileSection(
                      img: 'assets/images/security.png',
                      text: 'Security',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HowToUse()),
                      );
                    },
                    child: const ProfileSection(
                      img: 'assets/images/how.png',
                      text: 'How to use?',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CustomerSupportScreen()));
                    },
                    child: const ProfileSection(
                      img: 'assets/images/customer-support.png',
                      text: 'Customer support',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(profileProvider).logout(context);
                    },
                    child: const ProfileSection(
                      img: '',
                      text: 'Logout',
                    ),
                  )
                ],
              ),
            ));
          }),
        ),
      ),
    );
  }
}
