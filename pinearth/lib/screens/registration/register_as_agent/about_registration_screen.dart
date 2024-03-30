import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/screens/registration/register_as_agent/agent_detail_screen.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class AboutAgentRegistrationScreen extends ConsumerStatefulWidget {
  const AboutAgentRegistrationScreen(
      {super.key, required this.agentType, this.isEdit = false});

  final String agentType;
  final bool isEdit;

  @override
  ConsumerState<AboutAgentRegistrationScreen> createState() =>
      _AboutAgentRegistrationScreenState();
}

class _AboutAgentRegistrationScreenState
    extends ConsumerState<AboutAgentRegistrationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.refresh(registerAsAgentProvider);
      ref.read(registerAsAgentProvider).setIsEdit(widget.isEdit);
      ref.read(registerAsAgentProvider).agentType = widget.agentType;
      if (widget.agentType == agentAgentType) {
        title = "Agent listing";
        description =
            "Welcome to  Pinearth!\nElevate your real estate career by becoming a registered agent. Unleash the power of our platform to connect with clients, showcase your listings, and access valuable resources. Join our community of top-notch agents committed to success. Your journey to real estate excellence begins with a simple registration. Sign up now and let your achievements soar!";
        image = "agent_".png;
      }
      if (widget.agentType == landlordAgentType) {
        title = "Become a registered landlord";
        description =
            "Join our community of successful property owners and experience seamless management, verified tenant connections, and expert resources tailored just for you. Let's build your property success story together. Register now and embark on a journey to elevated real estate excellence!";
        image = "land_lord".png;
      }
      if (widget.agentType == developerAgentType) {
        title = "Are you a real estate Developer ?";
        description =
            "Embark on a groundbreaking journey with pinearth ! As a real estate developer, your vision shapes landscapes. Register now to unlock exclusive opportunities, connect with strategic partners, and showcase your projects to a global audience. Join our league of visionary developers who redefine the future of real estate. Your innovation starts here. Register as a Real Estate Developer and pave the way for unparalleled success!";
        image = "developer".png;
      }
      if (widget.agentType == bankAgentType) {
        title = "Empower Dreams, Fuel Growth! ";
        description =
            "Partner with pinearth as a registered bank specializing in mortgage loans and funding opportunities. Join forces with a dynamic real estate community, connecting with developers, aspiring homeowners, and savvy investors. Your institution plays a pivotal role in shaping real estate success stories. Register now to be a key player in building futures, one mortgage at a time. Let's create lasting legacies together!";
        image = "bank".png;
      }
      if (widget.agentType == hotelAgentType) {
        title = "Pride your hospitality!";
        description =
            "Where luxury meets opportunity! Register your hotel and showcase it’s unique charm to a global audience. Amplify your bookings, reach discerning travelers, and boost your brand visibility. Join our exclusive network of hospitality partners and unlock the full potential of your property. Elevate the guest experience – register your hotel now and let the world experience the extraordinary with you!";
        image = "hotel".png;
      }
      if (widget.agentType == shortletAgentType) {
        title = "Unleash the power of short term rentals!";
        description =
            "Unleash the power of short term rentals! Register your property on pinearth and showcase it to a world of travelers seeking unique, short-term stays. Amplify your bookings, connect with a diverse audience, and maximize your property's potential. Join our community of shortlet providers and redefine the way the world experiences hospitality. Your next guest is just a registration away. Sign up now and let your space tell it’s  own extraordinary story";
        image = "short_let".png;
      }
      if (widget.agentType == eventCenterAgentType) {
        title = "Unlock Limitless Event Possibilities";
        description =
            "Partner with Pinearth, your premier destination for exceptional event spaces and unparalleled service. Specializing in providing top-tier event venues, we invite you to join forces with a thriving events community, connecting with event planners, businesses, and individuals seeking memorable and seamless experiences. Your institution will play a crucial role in shaping unforgettable moments and successful events.";
        image = "event_center".png;
      }
      Future.delayed(Duration.zero, () {
        setState(() {

        });
      });
    });
  }

  String title = "";
  String description = "";
  String image = "";

  @override
  Widget build(BuildContext context) {
    final isEdit = ref.read(registerAsAgentProvider).isEdit;
    return WillPopScope(
      onWillPop: () async {
        ref.read(registerAsAgentProvider).clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black, // Set the desired color here
          ),
          title: AppbarTitle(
            text: isEdit
                ? 'Edit ${widget.agentType} Profile'
                : 'Register as ${widget.agentType}',
          ),
          centerTitle: false,
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              28.toColumnSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "$title",
                  style: TextStyle(
                      fontSize: 20.toFontSize(),
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1173AB)),
                ),
              ),
              29.toColumnSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "$description",
                  style: TextStyle(
                      fontSize: 16.toFontSize(),
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(.9)),
                ),
              ),
              42.toColumnSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Image.asset(
                  image,
                  height: 184,
                ),
              ),
              60.toColumnSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: CustomButtonWidget(
                  onClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AgentRegistrationDetailScreen()));
                  },
                  color: appColor.primary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 19.0),
                    child: Center(
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            fontSize: 20.toFontSize(),
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              24.toColumnSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
