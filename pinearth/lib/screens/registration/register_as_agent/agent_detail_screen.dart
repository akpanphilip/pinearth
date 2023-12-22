import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/list_property/widgets/property_listing_back_button.dart';
import 'package:pinearth/screens/registration/register_as_agent/agent_address_screen.dart';
import 'package:pinearth/screens/registration/register_as_agent/agent_contact_screen.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/screens/widgets/input_fields/text_area_field.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';


class AgentRegistrationDetailScreen extends ConsumerStatefulWidget {
  const AgentRegistrationDetailScreen({
    super.key,
    
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AgentRegistrationDetailScreenState();
}

class _AgentRegistrationDetailScreenState extends ConsumerState<AgentRegistrationDetailScreen> {

  String imageTitle = "Professional profile photo";
  String aboutTitle = "About yourself";

  @override
  void initState() {
    super.initState();
    if (ref.read(registerAsAgentProvider).agentType == bankAgentType) {
      imageTitle = "Bank Logo";
      aboutTitle = "About Your Bank";
    }
    if (ref.read(registerAsAgentProvider).agentType == hotelAgentType) {
      imageTitle = "Hotel Logo";
      aboutTitle = "About Your Hotel";
    }
    if (ref.read(registerAsAgentProvider).agentType == eventCenterAgentType) {
      imageTitle = "Company Logo";
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerasagentprovider = ref.watch(registerAsAgentProvider);
    final isEdit = registerasagentprovider.isEdit;
    final agentType = registerasagentprovider.agentType;
    
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              32.toColumnSpace(),

              if ([eventCenterAgentType, shortletAgentType].contains(registerasagentprovider.agentType)) ...[
                16.toColumnSpace(),
                Column(
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
              ],
              16.toColumnSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTitle(text: imageTitle),
                  const ImportantLabelTitle(text: ' *Image must be clear')
                ],
              ),
              10.toColumnSpace(),
              GestureDetector(
                onTap: () => registerasagentprovider.selectProfessionalPictures(),
                child: Builder(
                  builder: (context) {
                    if (registerasagentprovider.professionalProfilePhoto.isEmpty) {
                      return const UploadImg();
                    }
                    return SelectedImagesWidget(images: registerasagentprovider.professionalProfilePhoto);
                  },
                )
              ),
              
              22.toColumnSpace(),
              if (![eventCenterAgentType, shortletAgentType].contains(registerasagentprovider.agentType)) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelTitle(text: aboutTitle),
                    ImportantLabelTitle(text: ' *(what makes you different${registerasagentprovider.agentType == agentAgentType ? " as an Agent" : ""}?)')
                  ],
                ),
                10.toColumnSpace(),
                TextAreaField(
                  controller: registerasagentprovider.aboutController,
                ),
              ],
              
        
              if (registerasagentprovider.agentType == agentAgentType) ...[
                22.toColumnSpace(),
                const LabelTitle(text: 'Specialties'),
                10.toColumnSpace(),
                CustomTextField(
                  obscureText: false,
                  hintText: "e.g Buyers agent, 3 years listing agent",
                  controller: registerasagentprovider.specialityController,
                ),
              ],

              48.toColumnSpace(),

              Row(
                children: [
                  const Expanded(child: PropertyListingBackButton()),
                  40.toRowSpace(),
                  Expanded(child: CustomButtonWidget(
                    onClick: () {
                      if ([eventCenterAgentType, shortletAgentType].contains(registerasagentprovider.agentType)) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AgentRegistrationContactScreen()));
                      } else {
                        if (registerasagentprovider.professionalProfilePhoto.isEmpty) {
                          getIt<IAlertInteraction>().showErrorAlert("Please provide a picture/logo to continue");
                          return;
                        }
                        if (registerasagentprovider.aboutController.text.isEmpty) {
                          getIt<IAlertInteraction>().showErrorAlert("Please provide a description about you.");
                          return;
                        }
                        if (registerasagentprovider.agentType == agentAgentType) {
                          if (registerasagentprovider.specialityController.text.isEmpty) {
                            getIt<IAlertInteraction>().showErrorAlert("Please provide your specialties");
                            return;
                          }
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AgentRegistrationContactScreen()));
                      }
                    },
                    color: appColor.primary,
                    child: const Center(child: Text("Next"),),
                  )),
                ],
              ),
              20.toColumnSpace(),
            ],
          ),
        ),
      ),
    );
  }
}