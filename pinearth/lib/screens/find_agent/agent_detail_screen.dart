import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinearth/backend/domain/models/entities/agent_model.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/backend/domain/repositories/i_agent_repo.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';
import 'package:pinearth/screens/find_agent/widget/start_rating_widget.dart';
import 'package:pinearth/screens/property_detail/schedule_property_visit_screen.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/empty_state_widget.dart';
import 'package:pinearth/screens/widgets/property_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentDetailScreen extends ConsumerStatefulWidget {
  const AgentDetailScreen({super.key, required this.agent});

  final AgentModel agent;

  @override
  ConsumerState<AgentDetailScreen> createState() => _AgentDetailScreenState();
}

class _AgentDetailScreenState extends ConsumerState<AgentDetailScreen> {
  final agentProperties = ProviderActionState<List>(data: []);

  bool isProperty = false;
  bool isRoom = false;

  void loadAgentProperty() async {
    final res = await getIt<IAgentRepo>()
        .getAgentPropertyes(widget.agent.id.toString());
    res.fold((l) {
      print(l.message);
      agentProperties.toError(l.message);
      setState(() {});
    }, (r) {
      print("Proeprtyies ::: $r");
      agentProperties.toSuccess(List.from(r['property']));
      setState(() {});
    });
  }

  @override
  void initState() {
    loadAgentProperty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleAVisitP = ref.watch(scheduleAVisitProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, // Set the desired color here
          ),
          backgroundColor: Colors.white,
          title: const AppbarTitle(
            text: '',
          ),
          centerTitle: false,
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              35.toColumnSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(widget.agent.profilePhoto ?? ""),
                    ),
                    31.toRowSpace(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Builder(builder: (context) {
                                String name = "";

                                if (widget.agent.user.firstName.trim() != "" &&
                                    widget.agent.user.lastName != null &&
                                    widget.agent.user.lastName!.trim() != "") {
                                  name =
                                      "${widget.agent.user.firstName} ${widget.agent.user.lastName}";
                                }

                                if (widget.agent.name != null &&
                                    widget.agent.name!.trim() != "") {
                                  name = widget.agent.name!;
                                }

                                if (widget.agent.companyName != null &&
                                    widget.agent.companyName!.trim() != "") {
                                  name = widget.agent.companyName!;
                                }

                                return Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 20.toFontSize(),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                );
                              }),
                              if (widget.agent.companyName != null &&
                                  widget.agent.companyName!.isNotEmpty &&
                                  widget.agent.isVerified != null &&
                                  widget.agent.isVerified!) ...[
                                const SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset("verified".svg),
                              ]
                            ],
                          ),
                          2.toColumnSpace(),
                          Text(
                            "${widget.agent.address}",
                            style: TextStyle(
                                fontSize: 16.toFontSize(),
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          2.toColumnSpace(),
                          Row(
                            children: [
                              StarRatingWidget(
                                rating: widget.agent.rating ?? 0,
                              ),
                              5.toRowSpace(),
                              Text(
                                '(${(widget.agent.review == null || widget.agent.review!.isEmpty) ? 'No reviews' : "${widget.agent.review!.length} reviews"})',
                                style: TextStyle(
                                    fontSize: 12.toFontSize(),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(.5)),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              28.toColumnSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About me",
                            style: TextStyle(
                                fontSize: 20.toFontSize(),
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Text(
                            widget.agent.specialties!.isEmpty
                                ? ""
                                : "Specialties: ${widget.agent.specialties}",
                            style: TextStyle(
                                fontSize: 16.toFontSize(),
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          17.toColumnSpace(),
                          Text(
                            """${widget.agent.aboutYou}""",
                            style: TextStyle(
                                fontSize: 13.toFontSize(),
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse("tel:${widget.agent.phoneNo}"));
                          },
                          child: SvgPicture.asset("call_seller_icon".svg)),
                    )
                  ],
                ),
              ),
              if (![bankAgentType].contains(widget.agent.user.role)) ...[
                48.toColumnSpace(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Listed properties",
                        style: TextStyle(
                            fontSize: 20.toFontSize(),
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      17.toColumnSpace(),
                      Builder(
                        builder: (context) {
                          if (agentProperties.isLoading()) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(3,
                                      (index) => const LoadingPropertyWidget())
                                ],
                              ),
                            );
                          }

                          if (agentProperties.isError()) {
                            return Center(
                              child: CustomErrorWidget(
                                  showErrorImage: true,
                                  message:
                                      (agentProperties.message.toLowerCase() ==
                                              "unauthorized")
                                          ? "Unauthorized, Login to view"
                                          : agentProperties.message,
                                  onReload:
                                      (agentProperties.message.toLowerCase() ==
                                              "unauthorized")
                                          ? null
                                          : () => loadAgentProperty()),
                            );
                          }

                          final data = agentProperties.data ?? [];

                          if (data.isEmpty) {
                            return EmptyStateWidget(
                              onReload: () => loadAgentProperty(),
                              message: "This agent does not have any property",
                            );
                          }

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                    data.length,
                                    (index) => PropertyWidget(
                                          property: PropertyModel.fromJson(
                                              data[index]),
                                        ))
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
              48.toColumnSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ratings & reviews (${(widget.agent.review == null) ? "0" : widget.agent.review!.length})",
                      style: TextStyle(
                          fontSize: 20.toFontSize(),
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    17.toColumnSpace(),
                    if (widget.agent.review != null)
                      Column(
                        children: [
                          ...widget.agent.review!
                              .map((review) => const Text("review"))
                              .toList(),
                          // Text(
                          //   "5/25/2023 - ryantarrant8 Helped me rent a Townhouse home in Riverside, Baltimore, MD. John did an outstanding job of helping my find an apartment. He had extensive knowledge of the area and was extremely responsive. Would 10/10 recommend him!",
                          //   style: TextStyle(
                          //     fontSize: 13.toFontSize(),
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                          // 10.toColumnSpace(),
                          // Text(
                          //   "5/25/2023 - ryantarrant8 Helped me rent a Townhouse home in Riverside, Baltimore, MD. John did an outstanding job of helping my find an apartment. He had extensive knowledge of the area and was extremely responsive. Would 10/10 recommend him!",
                          //   style: TextStyle(
                          //     fontSize: 13.toFontSize(),
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                        ],
                      )
                  ],
                ),
              ),
              45.toColumnSpace(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Professional Information",
                      style: TextStyle(
                          fontSize: 28.toFontSize(),
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    12.toColumnSpace(),
                    Text(
                      'Broker address:  ${widget.agent.address}',
                      style: TextStyle(
                          fontSize: 18.toFontSize(),
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    24.toColumnSpace(),
                    Text(
                      'Cell phone: ${widget.agent.phoneNo}',
                      style: TextStyle(
                          fontSize: 18.toFontSize(),
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    24.toColumnSpace(),
                    Text(
                      'Websites:  ${widget.agent.website}',
                      style: TextStyle(
                          fontSize: 18.toFontSize(),
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    24.toColumnSpace(),
                    Text(
                      'Member since:   03/07/2023',
                      style: TextStyle(
                          fontSize: 18.toFontSize(),
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    24.toColumnSpace(),
                    CustomButtonWidget(
                      onClick: () {
                        launchUrl(Uri.parse(
                            "mailto:support@pinearth.com?subject=Report%20${widget.agent.companyName},%20id%20${widget.agent.id}"));
                      },
                      color: appColor.red,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 23.0),
                          child: Text(
                            "Report this agent",
                            style: TextStyle(
                                fontSize: 15.toFontSize(),
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              40.toColumnSpace(),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(27),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Contact ${widget.agent.name ?? widget.agent.companyName}",
                        style: TextStyle(
                            fontSize: 28.toFontSize(),
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      42.toColumnSpace(),
                      const LabelTitle(text: 'Name'),
                      10.toColumnSpace(),
                      CustomTextField(
                        obscureText: false,
                        hintText: '',
                        controller: scheduleAVisitP.nameController,
                      ),
                      20.toColumnSpace(),
                      const LabelTitle(text: 'Phone number'),
                      10.toColumnSpace(),
                      CustomTextField(
                        obscureText: false,
                        hintText: '',
                        controller: scheduleAVisitP.phoneNumberController,
                      ),
                      20.toColumnSpace(),
                      const LabelTitle(text: 'Email'),
                      10.toColumnSpace(),
                      CustomTextField(
                        obscureText: false,
                        hintText: '',
                        controller: scheduleAVisitP.emailController,
                      ),
                      20.toColumnSpace(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LabelTitle(text: 'Message'),
                          SizedBox(width: 5),
                          Text(
                            '(Optional)',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                      14.toColumnSpace(),
                      TextField(
                        controller: scheduleAVisitP.messageController,
                        decoration: InputDecoration(
                            fillColor: const Color(0xffeeeeee),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Type your message here..."),
                        maxLines: 5,
                        minLines: 5,
                      ),
                      42.toColumnSpace(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xff1173AB),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            scheduleAVisitP.scheduleVisit(
                                context,
                                widget.agent.user.email,
                                widget.agent.user.role!);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Contact',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ));
  }
}
