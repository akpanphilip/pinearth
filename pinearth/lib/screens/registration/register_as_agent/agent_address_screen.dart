import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/list_property/widgets/property_listing_back_button.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class AgentRegistrationAddressScreen extends ConsumerStatefulWidget {
  const AgentRegistrationAddressScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AgentRegistrationAddressScreenState();
}

class _AgentRegistrationAddressScreenState
    extends ConsumerState<AgentRegistrationAddressScreen> {
  String addressTitle = "Office address";

  @override
  void initState() {
    super.initState();
    final agentType = ref.read(registerAsAgentProvider).agentType;
    if (agentType == landlordAgentType) {
      addressTitle = "House address";
    }
    if (agentType == shortletAgentType) {
      addressTitle = "Shortlet address";
    }
    if (agentType == shortletAgentType) {
      addressTitle = "Shortlet address";
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerasagentprovider = ref.watch(registerAsAgentProvider);
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
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      32.toColumnSpace(),
                      LabelTitle(text: addressTitle),
                      10.toColumnSpace(),
                      CustomTextField(
                        obscureText: false,
                        hintText: "6391 Elgin St. Celina, Delaware 10299",
                        controller: registerasagentprovider.addressController,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    if ([eventCenterAgentType]
                        .contains(registerasagentprovider.agentType)) ...[
                      22.toColumnSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LabelTitle(text: "Company ID"),
                            10.toColumnSpace(),
                            GestureDetector(
                                onTap: () =>
                                    registerasagentprovider.selectCompanyId(),
                                child: Builder(
                                  builder: (context) {
                                    if (registerasagentprovider
                                        .companyId.isEmpty) {
                                      return const UploadImg();
                                    }
                                    return SelectedImagesWidget(
                                        images:
                                            registerasagentprovider.companyId);
                                  },
                                )),
                          ],
                        ),
                      ),
                      22.toColumnSpace(),
                    ],
                    if ([agentAgentType]
                        .contains(registerasagentprovider.agentType)) ...[
                      22.toColumnSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const LabelTitle(text: "Website"),
                                10.toRowSpace(),
                                const Text('optional')
                              ],
                            ),
                            10.toColumnSpace(),
                            CustomTextField(
                              obscureText: false,
                              hintText: "Johndoe.com",
                              controller:
                                  registerasagentprovider.websiteController,
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (![
                      developerAgentType,
                      eventCenterAgentType,
                      shortletAgentType
                    ].contains(agentType)) ...[
                      22.toColumnSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelTitle(text: 'Goverment issued ID'),
                                ImportantLabelTitle(
                                    text: ' *Image must be clear')
                              ],
                            ),
                            10.toColumnSpace(),
                            GestureDetector(
                                onTap: () =>
                                    registerasagentprovider.selectIdCard(),
                                child: Builder(
                                  builder: (context) {
                                    if (registerasagentprovider
                                        .idCard.isEmpty) {
                                      return const UploadImg();
                                    }
                                    return SelectedImagesWidget(
                                        images: registerasagentprovider.idCard);
                                  },
                                )),
                          ],
                        ),
                      ),
                    ],
                    if (![
                      developerAgentType,
                      eventCenterAgentType,
                      shortletAgentType
                    ].contains(agentType)) ...[
                      124.toColumnSpace(),
                    ],
                    if ([
                      developerAgentType,
                      eventCenterAgentType,
                      shortletAgentType
                    ].contains(agentType))
                      350.toColumnSpace(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Expanded(child: PropertyListingBackButton()),
                          40.toRowSpace(),
                          Expanded(
                              child: CustomButtonWidget(
                            onClick: () {
                              if (registerasagentprovider
                                  .addressController.text.isEmpty) {
                                getIt<IAlertInteraction>().showErrorAlert(
                                    "Please provide an address");
                                return;
                              }
                              if (registerasagentprovider.agentType ==
                                  agentAgentType) {
                                if (registerasagentprovider.idCard.isEmpty) {
                                  getIt<IAlertInteraction>().showErrorAlert(
                                      "Please provide an id card");
                                  return;
                                }
                              }
                              registerasagentprovider.register(context);
                            },
                            color: appColor.primary,
                            child: const Center(
                              child: Text("Finish"),
                            ),
                          )),
                        ],
                      ),
                    ),
                    20.toColumnSpace(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
