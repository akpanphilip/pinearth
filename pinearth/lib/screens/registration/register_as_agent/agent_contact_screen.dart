import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
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

import '../../widgets/custom_drop_down.dart';

class AgentRegistrationContactScreen extends ConsumerStatefulWidget {
  const AgentRegistrationContactScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AgentRegistrationContactScreenState();
}

class _AgentRegistrationContactScreenState
    extends ConsumerState<AgentRegistrationContactScreen> {
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
    bool requireName = [bankAgentType, hotelAgentType]
        .contains(registerasagentprovider.agentType);
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
                      obscureText: false,
                      hintText: "Kola enterprice/Oceanic bank",
                      controller: registerasagentprovider.nameController,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if (agentType == hotelAgentType)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Enter address"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false,
                      hintText: "6391 Elgin St. Celina, Delaware 10299",
                      controller: registerasagentprovider.addressController,
                    ),
                  ],
                ),
              ),
            if (agentType == developerAgentType ||
                agentType == eventCenterAgentType ||
                agentType == agentAgentType ||
                agentType == landlordAgentType ||
                agentType == shortletAgentType) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Email address"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false,
                      hintText: "example@domain.com",
                      controller:
                          registerasagentprovider.emailAddressController,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if (agentType == eventCenterAgentType) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Property address"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false,
                      hintText: "6391 Elgin St. Celina, Delaware 10299",
                      controller: registerasagentprovider.addressController,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if (agentType != eventCenterAgentType) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Phone number"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false,
                      hintText: "08088888888",
                      controller: registerasagentprovider.phoneNumberController,
                      inputType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if ([shortletAgentType]
                .contains(registerasagentprovider.agentType)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Shortlet Address"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false,
                      hintText: "13 ejirin road",
                      controller: registerasagentprovider.addressController,
                      inputType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if ([bankAgentType]
                .contains(registerasagentprovider.agentType)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Office Address"),
                    10.toColumnSpace(),
                    CustomTextField(
                      obscureText: false,
                      hintText: "13 ejirin road",
                      controller: registerasagentprovider.addressController,
                      inputType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            // if (![
            //   agentAgentType,
            //   landlordAgentType,
            //   bankAgentType,
            //   developerAgentType
            // ].contains(registerasagentprovider.agentType))
            ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "State"),
                    10.toColumnSpace(),
                    CustomDropdownWidget<String>(
                      items: nigerianState
                          .map((e) => CustomDropDownItem(label: e, value: e))
                          .toList(),
                      onSelect: (v) {
                        // listPropertyP.setRentDuration(v.value);
                        registerasagentprovider.updateSelectedState = v.value;
                      },
                      selected: CustomDropDownItem(
                          label: registerasagentprovider.selectedState,
                          value: registerasagentprovider.selectedState),
                    ),
                    // CustomTextField(
                    //   obscureText: false,
                    //   hintText: "E.g Rivers State",
                    //   controller: registerasagentprovider.stateController,
                    //   inputType: TextInputType.text,
                    // ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if (agentType == eventCenterAgentType) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Hall Capacity"),
                    10.toColumnSpace(),
                    CustomTextField(
                        obscureText: false,
                        hintText: "E.g 173 Square feet",
                        controller:
                            registerasagentprovider.hallCapacityController,
                        inputType: TextInputType.number,
                        suffixIcon: const HelpButton(
                          text: "Sqft",
                          helpIcon: Icon(
                            Icons.help_outline_rounded,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if (agentType == eventCenterAgentType) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Parking space"),
                    10.toColumnSpace(),
                    CustomTextField(
                        obscureText: false,
                        hintText: "E.g 173 Square feet",
                        controller:
                            registerasagentprovider.parkingSpaceController,
                        inputType: TextInputType.number,
                        suffixIcon: const HelpButton(
                          text: "Sqft",
                          helpIcon: Icon(
                            Icons.help_outline_rounded,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if (agentType == eventCenterAgentType) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(
                        text: "What appliances are on the property"),
                    10.toColumnSpace(),
                    // const LabelTitle(text: "What appliances are on the property"),
                    // 10.toColumnSpace(),

                    CustomTextField(
                      obscureText: false,
                      hintText: "E.g A fridge",
                      controller: registerasagentprovider.appliancesController,
                      // inputType: TextInputType.number,
                      // suffixIcon: const HelpButton(
                      //   text: "Sqft",
                      //   helpIcon: Icon(
                      //     Icons.help_outline_rounded,
                      //     color: Colors.white,
                      //   ),
                      // )
                    ),
                  ],
                ),
              ),
              22.toColumnSpace(),
            ],
            if (![landlordAgentType, shortletAgentType]
                .contains(registerasagentprovider.agentType)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelTitle(text: "Company ID"),
                    10.toColumnSpace(),
                    LabelTitle(
                        text: "*Image must be clear", color: appColor.red),
                    10.toColumnSpace(),
                    GestureDetector(
                        onTap: () => registerasagentprovider.selectCompanyId(),
                        child: Builder(
                          builder: (context) {
                            if (registerasagentprovider.companyId.isEmpty) {
                              return const UploadImg();
                            }
                            return SelectedImagesWidgetV2(
                                images: registerasagentprovider.companyId);
                          },
                        )),
                  ],
                ),
              ),
              22.toColumnSpace(),
              if (registerasagentprovider.agentType ==
                  eventCenterAgentType) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LabelTitle(text: "Images of the Event center"),
                      10.toColumnSpace(),
                      LabelTitle(text: "*20 images max", color: appColor.red),
                      10.toColumnSpace(),
                      GestureDetector(
                          onTap: () =>
                              registerasagentprovider.selectEventCenter(),
                          child: Builder(
                            builder: (context) {
                              if (registerasagentprovider
                                  .eventCenterImages.isEmpty) {
                                return const UploadImg();
                              }
                              return SelectedImagesWidget(
                                  images: registerasagentprovider
                                      .eventCenterImages);
                            },
                          )),
                    ],
                  ),
                ),
                22.toColumnSpace(),
              ],
              ...[
                if (![bankAgentType, eventCenterAgentType]
                    .contains(registerasagentprovider.agentType)) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelTitle(text: "Company name"),
                        10.toColumnSpace(),
                        CustomTextField(
                          obscureText: false,
                          hintText: "E.g XYZ Corporation",
                          controller:
                              registerasagentprovider.companyNameController,
                          inputType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                  22.toColumnSpace(),
                ],
                if (registerasagentprovider.agentType !=
                    eventCenterAgentType) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelTitle(text: "Company Reg. Number"),
                        10.toColumnSpace(),
                        CustomTextField(
                          obscureText: false,
                          hintText: "E.g CRN1234567890",
                          controller:
                              registerasagentprovider.companyRegNoController,
                          inputType: TextInputType.text,
                        ),
                      ],
                    ),
                  )
                ],
              ],
            ],
            if ([landlordAgentType]
                .contains(registerasagentprovider.agentType)) ...[
              350.toColumnSpace(),
            ],
            if (![landlordAgentType, shortletAgentType]
                .contains(registerasagentprovider.agentType)) ...[
              120.toColumnSpace(),
            ],
            if ([shortletAgentType]
                .contains(registerasagentprovider.agentType)) ...[
              120.toColumnSpace(),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Expanded(child: PropertyListingBackButton()),
                  40.toRowSpace(),
                  Expanded(
                      child: CustomButtonWidget(
                    onClick: () {
                      if ([
                        agentAgentType,
                        eventCenterAgentType,
                        landlordAgentType,
                        shortletAgentType
                      ].contains(registerasagentprovider.agentType)) {
                        if (registerasagentprovider
                            .emailAddressController.text.isEmpty) {
                          getIt<IAlertInteraction>().showErrorAlert(
                              "Please provide an email address");
                          return;
                        }
                      }

                      if ([bankAgentType, hotelAgentType, shortletAgentType]
                          .contains(registerasagentprovider.agentType)) {
                        if (agentType == hotelAgentType) {
                          if (registerasagentprovider.companyNameController.text
                              .trim()
                              .isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide a company name");
                            return;
                          }
                        }

                        // if (agentType == bankAgentType ||
                        //     agentType == shortletAgentType) {
                        if (registerasagentprovider.addressController.text
                            .trim()
                            .isEmpty) {
                          getIt<IAlertInteraction>()
                              .showErrorAlert("Please provide an address");
                          return;
                        }
                        if (registerasagentprovider
                            .phoneNumberController.text.isEmpty) {
                          getIt<IAlertInteraction>()
                              .showErrorAlert("Please provide a phone number.");
                          return;
                        }
                        // }

                        if (agentType == bankAgentType ||
                            agentType == hotelAgentType) {
                          if (registerasagentprovider.nameController.text
                              .trim()
                              .isEmpty) {
                            getIt<IAlertInteraction>()
                                .showErrorAlert("Please provide a name");
                            return;
                          }

                          if (registerasagentprovider
                              .companyRegNoController.text.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide a company reg number.");
                            return;
                          }
                          if (registerasagentprovider.companyId.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide an image of company id.");
                            return;
                          }
                        }
                        registerasagentprovider.register(context);
                      } else {
                        if (registerasagentprovider.agentType ==
                            eventCenterAgentType) {
                          if (registerasagentprovider.addressController.text
                              .trim()
                              .isEmpty) {
                            getIt<IAlertInteraction>()
                                .showErrorAlert("Please provide an address");
                            return;
                          }
                          // if (registerasagentprovider.stateController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   getIt<IAlertInteraction>()
                          //       .showErrorAlert("Please provide a state");
                          //   return;
                          // }
                          if (registerasagentprovider
                              .hallCapacityController.text
                              .trim()
                              .isEmpty) {
                            getIt<IAlertInteraction>()
                                .showErrorAlert("Please provide hall capacity");
                            return;
                          }
                          if (registerasagentprovider
                              .parkingSpaceController.text
                              .trim()
                              .isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide parking space capacity");
                            return;
                          }
                          if (registerasagentprovider
                              .eventCenterImages.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide image of the event center");
                            return;
                          }
                          if (registerasagentprovider.companyId.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide image of the company ID");
                            return;
                          }

                          // if (registerasagentprovider.eventCenterImages.isEmpty){
                          //   getIt<IAlertInteraction>()
                          //       .showErrorAlert("Please provide image of the event center");
                          //   return;
                          // }
                        } else {
                          if (registerasagentprovider.agentType ==
                              developerAgentType) {
                            if (registerasagentprovider
                                .companyNameController.text.isEmpty) {
                              getIt<IAlertInteraction>().showErrorAlert(
                                  "Please provide a company name");
                              return;
                            }
                            if (registerasagentprovider
                                .companyRegNoController.text.isEmpty) {
                              getIt<IAlertInteraction>().showErrorAlert(
                                  "Please provide a company reg number.");
                              return;
                            }

                            if (registerasagentprovider.companyId.isEmpty) {
                              getIt<IAlertInteraction>().showErrorAlert(
                                  "Please provide an image of company id.");
                              return;
                            }
                          }

                          if (requireName &&
                              registerasagentprovider
                                  .nameController.text.isEmpty) {
                            getIt<IAlertInteraction>()
                                .showErrorAlert("Please provide a name");
                            return;
                          }
                          // if (registerasagentprovider
                          //     .emailAddressController.text.isEmpty) {
                          //   getIt<IAlertInteraction>().showErrorAlert(
                          //       "Please provide an email address");
                          //   return;
                          // }
                          if (registerasagentprovider
                              .phoneNumberController.text.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert(
                                "Please provide a phone number.");
                            return;
                          }
                        }

                        if (registerasagentprovider.agentType ==
                            eventCenterAgentType) {
                          registerasagentprovider.register(context);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AgentRegistrationAddressScreen()));
                        }
                      }
                    },
                    color: appColor.primary,
                    child: Center(
                      child: Text(buttonText),
                    ),
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
