import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

import '../../backend/domain/models/entities/agent_model.dart';
import '../../providers/user/profile_provider.dart';
import '../../utils/styles/colors.dart';
import '../widgets/custom_error_widget.dart';
import 'widgets/loading_profile_widget.dart';

class EditBusinessProfileScreen extends ConsumerStatefulWidget {
  const EditBusinessProfileScreen({super.key});

  @override
  ConsumerState<EditBusinessProfileScreen> createState() =>
      _EditBusinessProfileScreenState();
}

class _EditBusinessProfileScreenState
    extends ConsumerState<EditBusinessProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchAccountData();
    });
    super.initState();
  }

  void fetchAccountData() {
    final profileRef = ref.read(profileProvider);
    final role = profileRef.profileState.data?.role;

    print("role is ${role}");

    if (role == bankAgentType) {
      profileRef.loadBusinessProfile(context, "a bank");
    }
    if (role == "Short-let") {
      profileRef.loadBusinessProfile(context, "a short-let");
    }
    if (role == landlordAgentType) {
      profileRef.loadBusinessProfile(context, "a landlord");
    }
    if (role == developerAgentType) {
      profileRef.loadBusinessProfile(context, "a developer");
    }
    if (role == hotelAgentType) {
      profileRef.loadBusinessProfile(context, "a hotel");
    }
    if (role == eventCenterAgentType) {
      profileRef.loadBusinessProfile(context, "an event-center");
    }
    if (role == agentAgentType) {
      profileRef.loadBusinessProfile(context, "an agent");
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileP = ref.watch(profileProvider);
    final businessProfileState = profileP.businessProfileState;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: const AppbarTitle(
          text: 'Edit Business Profile',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: Builder(builder: (context) {
        if (businessProfileState.isLoading()) {
          return const LoadingProfileWidget();
        } else if (businessProfileState.isError()) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: CustomErrorWidget(
                message: businessProfileState.message,
                showErrorImage: true,
                onReload: () => fetchAccountData()),
          );
        } else {
          //Assume it is loaded
          final profile = businessProfileState.data!;
          return EditProfileBody(profile: profile);
        }
      }),
    );
  }
}

class EditProfileBody extends ConsumerStatefulWidget {
  const EditProfileBody({
    super.key,
    required this.profile,
  });

  final AgentModel profile;

  @override
  ConsumerState<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends ConsumerState<EditProfileBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final editBusinessProviderProvider = ref.watch(registerAsAgentProvider);

      editBusinessProviderProvider.nameController.text =
          widget.profile.companyName ?? '';
      editBusinessProviderProvider.emailAddressController.text =
          widget.profile.email ?? "";
      editBusinessProviderProvider.companyNameController.text =
          widget.profile.companyName ?? "";
      editBusinessProviderProvider.companyRegNoController.text =
          widget.profile.companyReg ?? "";
      editBusinessProviderProvider.phoneNumberController.text =
          widget.profile.phoneNo ?? "";
      editBusinessProviderProvider.addressController.text =
          widget.profile.address ?? "";
      editBusinessProviderProvider.websiteController.text =
          widget.profile.website ?? "";
      editBusinessProviderProvider.aboutController.text =
          widget.profile.aboutYou ?? "";
      editBusinessProviderProvider.specialityController.text =
          widget.profile.specialties ?? "";
      editBusinessProviderProvider.professionalProfilePhoto = [
        widget.profile.profilePhoto ?? ""
      ];
      editBusinessProviderProvider.companyId = [
        widget.profile.user.profile?.uploadId ?? ""
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final editBusinessProviderProvider = ref.watch(registerAsAgentProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            14.toColumnSpace(),

            Center(
              child: GestureDetector(
                onTap: () {
                  editBusinessProviderProvider.selectProfessionalPictures();
                },
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      if (editBusinessProviderProvider
                          .professionalProfilePhoto.isNotEmpty)
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10000),
                            child: (editBusinessProviderProvider
                                    .professionalProfilePhoto.first
                                    .startsWith("http"))
                                ? Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              editBusinessProviderProvider
                                                  .professionalProfilePhoto
                                                  .first,
                                              maxWidth: 100,
                                              maxHeight: 100,
                                            ),
                                            fit: BoxFit.cover)),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                editBusinessProviderProvider
                                                    .professionalProfilePhoto
                                                    .first)),
                                            fit: BoxFit.cover)),
                                  )),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            26.toColumnSpace(),

            if (editBusinessProviderProvider.agentType == bankAgentType) ...[
              const LabelTitle(text: 'Name'),
              const SizedBox(height: 10),
              CustomTextField(
                obscureText: false,
                hintText: 'name',
                controller: editBusinessProviderProvider.nameController,
              ),
              18.toColumnSpace(),
            ],

            const LabelTitle(text: 'Email'),
            const SizedBox(height: 10),
            CustomTextField(
              obscureText: false,
              hintText: 'example@domain.com',
              controller: editBusinessProviderProvider.emailAddressController,
            ),

            18.toColumnSpace(),

            const LabelTitle(text: 'Address'),
            const SizedBox(height: 10),
            CustomTextField(
              obscureText: false,
              hintText: '12 alakija street',
              controller: editBusinessProviderProvider.addressController,
            ),

            18.toColumnSpace(),
            const LabelTitle(text: 'About yourself'),
            const SizedBox(height: 10),
            CustomTextField(
              obscureText: false,
              hintText: 'Tell us about yourself',
              controller: editBusinessProviderProvider.aboutController,
            ),

            18.toColumnSpace(),
            const LabelTitle(text: 'Specialties'),
            const SizedBox(height: 10),
            CustomTextField(
              obscureText: false,
              hintText: 'What are your specialties?',
              controller: editBusinessProviderProvider.specialityController,
            ),

            18.toColumnSpace(),
            const LabelTitle(text: 'Company ID'),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () => editBusinessProviderProvider.selectCompanyId(),
                child: Builder(
                  builder: (context) {
                    if (editBusinessProviderProvider.companyId.isEmpty) {
                      return const UploadImg(
                        height: 50,
                      );
                    }
                    return SelectedImagesWidget(
                      images: editBusinessProviderProvider.companyId,
                      height: 50,
                    );
                  },
                )),
            // CustomTextField(
            //   obscureText: false, hintText: 'What is your company ID',
            //   controller: editBusinessProviderProvider.companyIdController,
            // ),
            if (![bankAgentType]
                .contains(editBusinessProviderProvider.agentType)) ...[
              18.toColumnSpace(),
              const LabelTitle(text: 'Company Name'),
              const SizedBox(height: 10),
              CustomTextField(
                obscureText: false,
                hintText: 'What is your company name',
                controller: editBusinessProviderProvider.nameController,
              ),
            ],

            18.toColumnSpace(),
            const LabelTitle(text: 'Company Reg Number'),
            const SizedBox(height: 10),
            CustomTextField(
              obscureText: false,
              hintText: 'What is your company registration number',
              controller: editBusinessProviderProvider.companyRegNoController,
            ),

            63.toColumnSpace(),

            CustomButtonWidget(
              onClick: () {
                editBusinessProviderProvider.isEdit = true;
                editBusinessProviderProvider.agentType = developerAgentType;
                editBusinessProviderProvider.register(context,
                    id: widget.profile.id.toString());
              },
              radius: 100,
              color: const Color(0xFF1173AB),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 13.0),
                child: Center(
                  child: Text("Save"),
                ),
              ),
            ),

            20.toColumnSpace(),
          ],
        ),
      ),
    );
  }
}
