import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

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
      ref.read(registerAsAgentProvider).setIsEdit(true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final editBusinessProviderProvider = ref.watch(registerAsAgentProvider);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              14.toColumnSpace(),

              // Center(
              //   child: GestureDetector(
              //     onTap: () {
              //       editBusinessProviderProvider.selectProfessionalPictures();
              //     },
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(10000),
              //       child: (editBusinessProviderProvider
              //               .professionalProfilePhoto.first
              //               .startsWith("http"))
              //           ? Container(
              //               height: 100,
              //               width: 100,
              //               decoration: BoxDecoration(
              //                   image: DecorationImage(
              //                       image: CachedNetworkImageProvider(
              //                         editBusinessProviderProvider
              //                             .professionalProfilePhoto.first,
              //                         maxWidth: 100,
              //                         maxHeight: 100,
              //                       ),
              //                       fit: BoxFit.cover)),
              //             )
              //           : Container(
              //               height: 100,
              //               width: 100,
              //               decoration: BoxDecoration(
              //                   image: DecorationImage(
              //                       image: FileImage(File(
              //                           editBusinessProviderProvider
              //                               .professionalProfilePhoto.first)),
              //                       fit: BoxFit.cover)),
              //             ),
              //     ),
              //   ),
              // ),

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
                  controller:
                      editBusinessProviderProvider.companyNameController,
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
                onClick: () => editBusinessProviderProvider.register(context),
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
      ),
    );
  }
}
