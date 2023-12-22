import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/list_property/widgets/property_listing_back_button.dart';
import 'package:pinearth/screens/registration/register_as_agent/agent_address_screen.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class AgentRegistrationContactScreen extends ConsumerStatefulWidget {
  const AgentRegistrationContactScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AgentRegistrationContactScreenState();
}

class _AgentRegistrationContactScreenState extends ConsumerState<AgentRegistrationContactScreen> {

  String nameTitle = "Business Name";
  String buttonText = "Next";

  @override
  void initState() {
    super.initState();
    
    if (ref.read(registerAsAgentProvider).agentType == bankAgentType) {
      nameTitle = "Bank Name";
      buttonText = "Finish";
    }
    if (ref.read(registerAsAgentProvider).agentType == hotelAgentType) {
      nameTitle = "Hotel Name";
      buttonText = "Finish";
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerasagentprovider = ref.watch(registerAsAgentProvider);
    bool requireName = [bankAgentType, hotelAgentType].contains(registerasagentprovider.agentType);
    final agentType = registerasagentprovider.agentType;
    final isEdit = registerasagentprovider.isEdit;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: AppbarTitle(
          text: isEdit ? 'Edit $agentType Profile' : 'Register as $agentType',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            32.toColumnSpace(),
            if (requireName) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelTitle(text: "$nameTitle"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false, hintText: "Kola enterprice/Oceanic bank",
                      controller: registerasagentprovider.nameController,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if (agentType != bankAgentType) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Email address"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false, hintText: "example@domain.com",
                      controller: registerasagentprovider.emailAddressController,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelTitle(text: "Phone number"),
                  10.toColumnSpace(),
                  CustomTextField(
                    obscureText: false, hintText: "08088888888",
                    controller: registerasagentprovider.phoneNumberController,
                    inputType: TextInputType.number,
                  ),
                ],
              ),
            ),
            22.toColumnSpace(),

            if ([shortletAgentType].contains(registerasagentprovider.agentType)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Shortlet Address"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false, hintText: "13 ejirin road",
                      controller: registerasagentprovider.addressController,
                      inputType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if ([bankAgentType].contains(registerasagentprovider.agentType)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Office Address"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false, hintText: "13 ejirin road",
                      controller: registerasagentprovider.addressController,
                      inputType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],


            if (![agentAgentType, landlordAgentType, bankAgentType, developerAgentType].contains(registerasagentprovider.agentType)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "State"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false, hintText: "Ondo",
                      controller: registerasagentprovider.stateController,
                      inputType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],

            if (![landlordAgentType, shortletAgentType].contains(registerasagentprovider.agentType)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Company ID"),
                    10.toColumnSpace(),
                    GestureDetector(
                      onTap: () => registerasagentprovider.selectCompanyId(),
                      child: Builder(
                        builder: (context) {
                          if (registerasagentprovider.companyId.isEmpty) {
                            return const UploadImg();
                          }
                          return SelectedImagesWidget(images: registerasagentprovider.companyId);
                        },
                      )
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),

              ...[
                if (![bankAgentType].contains(registerasagentprovider.agentType)) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelTitle(text: "Company name"),
                        10.toColumnSpace(),
                        CustomTextField(
                          obscureText: false, hintText: "E.g XYZ Corporation",
                          controller: registerasagentprovider.companyNameController,
                          inputType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                  22.toColumnSpace(),
                ],

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LabelTitle(text: "Company Reg. Number"),
                      10.toColumnSpace(),
                      CustomTextField(
                        obscureText: false, hintText: "E.g CRN1234567890",
                        controller: registerasagentprovider.companyRegNoController,
                        inputType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ],
            ],

            if ([landlordAgentType].contains(registerasagentprovider.agentType)) ...[
              350.toColumnSpace(),
            ],
            if (![landlordAgentType, shortletAgentType].contains(registerasagentprovider.agentType)) ...[
              120.toColumnSpace(),
            ],
            if ([shortletAgentType].contains(registerasagentprovider.agentType)) ...[
              120.toColumnSpace(),
            ],

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                  children: [
                    const Expanded(child: PropertyListingBackButton()),
                    40.toRowSpace(),
                    Expanded(child: CustomButtonWidget(
                      onClick: () {
                        if ([bankAgentType, hotelAgentType, shortletAgentType].contains(registerasagentprovider.agentType)) {
                          registerasagentprovider.register(context);
                        } else {
                          if (requireName && registerasagentprovider.nameController.text.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert("Please provide a name");
                            return;
                          }
                          if (registerasagentprovider.emailAddressController.text.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert("Please provide an email address");
                            return;
                          }
                          if (registerasagentprovider.phoneNumberController.text.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert("Please provide a phone number.");
                            return;
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AgentRegistrationAddressScreen()));
                        }
                      },
                      color: appColor.primary,
                      child: Center(child: Text(buttonText),),
                    )),
                  ],
                ),
            ),
              20.toColumnSpace(),
          ],
        ),
      ),
    );
  }
}