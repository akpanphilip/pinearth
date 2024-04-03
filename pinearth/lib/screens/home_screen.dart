import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/providers/properties/properties_list_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/search/search_screen.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/side_bar_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../backend/application/servicies/localstorage/hive.local_storage.service.dart';
import '../backend/domain/models/entities/agent_model.dart';
import '../providers/agent/find_agent_provider.dart';
import '../providers/base_provider.dart';
import '../utils/constants/local_storage_keys.dart';
import 'auth/register/personal_id_screen.dart';
import 'find_agent/widget/agent_widget.dart';
import 'widgets/custom_button_widget.dart';
import 'widgets/empty_state_widget.dart';
import 'widgets/housing_agent_card_widget.dart';
import 'widgets/input_fields/search_input_field.dart';
import 'widgets/property_category_tile_widget.dart';
import 'widgets/property_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String currentClass = "All";
  final localStorage = HiveLocalStorageService();
  // bool? value = true; //user has seen how to

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {

    // if (mounted) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // ref.read(profileProvider).initialize(context, failSilently: true);

      final value = await localStorage.getItem(userDataBoxKey, seenHowToKey,
          defaultValue: false);

      final user = ref.read(profileProvider).profileState.data;

      if ((user != null && user.hasRole == false) && !value) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (mounted) {
            if (!Scaffold.of(context).isDrawerOpen) {
              Scaffold.of(context).openDrawer();
            }
          }
        });
      }

      ref.read(propertyListProvider).loadProperties();

      if (user != null) {
        if (user.profile?.uploadId == null ||
            user.profile?.uploadId!.trim() == "") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PersonalID(
                      uploadId: true,
                    )),
          );
        } else {
          // if (user.hasRole == true && value == null || value == "") {
          //   if (mounted) {
          //     if (!Scaffold.of(context).isDrawerOpen){
          //       Scaffold.of(context).openDrawer();
          //     }
          //   }
          // }
        }
        ref.read(findAgentProvider).loadAgents();
      }
    });
    // }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final propertyListP = ref.watch(propertyListProvider);
    final agentListP = ref.watch(findAgentProvider);
    final propertyListState = propertyListP.propertyListState;
    final agentListState = agentListP.agentsState;
    final user = ref.watch(profileProvider).profileState.data;
    final isLoggedIn = user != null;

    // final user = ref.watch(profileProvider);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(children: [
          Container(
            color: const Color.fromARGB(255, 5, 113, 201),
            height: 125,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Consumer(builder: (ctx, ref, child) {
                      // final user = ref.watch(profileProvider).profileState.data;

                      // const hasRole = false;
                      final hasRole = isLoggedIn && user.hasRole == true;
                      return !isLoggedIn
                          ? const SizedBox.shrink()
                          : (!hasRole
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          Scaffold.of(context).openDrawer(),
                                      child: const Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                      ),
                                    ),
                                    11.toRowSpace(),
                                  ],
                                )
                              : const SizedBox.shrink());
                    }),
                    Expanded(
                      child: GestureDetector(
                        child: SearchPropertyFieldWidget(
                          controller: propertyListP.searchParamController,
                          readOnly: true,
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchScreen()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                PropertyClassTileWidget(
                  onClassChange: (String propertyClass) {
                    setState(() {
                      currentClass = propertyClass;
                    });
                  },
                  currentClass: currentClass,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // ref.read(propertyListProvider).loadProperties();
                final user = ref.watch(profileProvider).profileState.data;
                ref.read(propertyListProvider).loadProperties();
                if (user != null) {
                  ref.read(findAgentProvider).loadAgents();
                }
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(children: [
                  Builder(
                    builder: (context) {
                      if (propertyListState.isLoading() ||
                          (isLoggedIn && agentListState.isLoading())) {
                        // return Center(
                        //   child: CircularProgressIndicator.adaptive(),
                        // );
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...[1, 2, 3].map((e) {
                                return const Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: LoadingPropertyWidget(),
                                );
                              })
                            ],
                          ),
                        );
                      }
                      if (propertyListState.isError() ||
                          agentListState.isError()) {
                        return Center(
                            child: CustomErrorWidget(
                                message: genericHttpRequestErrorMessage,
                                onReload: () {
                                  final user = ref
                                      .watch(profileProvider)
                                      .profileState
                                      .data;
                                  ref
                                      .read(propertyListProvider)
                                      .loadProperties();
                                  if (user != null) {
                                    ref.read(findAgentProvider).loadAgents();
                                  }
                                  // propertyListP.loadProperties();
                                }));
                      }

                      //on success

                      List<PropertyModel> data = propertyListState.data ?? [];
                      // print("data length is ${data}");
                      List<dynamic> agents = agentListState.data ?? [];
                      // print("agents length ${agents.length}");

                      if (currentClass != 'All') {
                        data = data.where((element) {
                          if (currentClass.toLowerCase() == "shortlet") {
                            return element.propertyStatus?.toLowerCase() ==
                                "For Shortlet".toLowerCase();
                          } else if (currentClass.toLowerCase() == "hotel") {
                            return element.role?.toLowerCase() ==
                                developerAgentType;
                          } else if (currentClass.toLowerCase() ==
                                  "event center" ||
                              currentClass.toLowerCase() == "bank") {
                            return element.role?.toLowerCase() ==
                                currentClass.toLowerCase();
                          } else {
                            return element.propertyStatus?.toLowerCase() ==
                                currentClass.toLowerCase();
                          }
                        }).toList();
                      }

                      if (data.isEmpty) {
                        return EmptyStateWidget(
                          message: propertyListState.message,
                          onReload: () => propertyListP.loadProperties(),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (agents.isNotEmpty)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...agents
                                      .map((e) => SizedBox(
                                            width: 300,
                                            height: 250,
                                            child: AgentWidget(
                                              agent: e,
                                              showBookNow: true,
                                            ),
                                          ))
                                      .toList()
                                ],
                              ),
                            ),
                          const SizedBox(height: 15),
                          prop(),
                          const SizedBox(height: 15),
                          Center(
                            child: Text(
                              currentClass == 'All'
                                  ? 'Featured Listings'
                                  : currentClass,
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          30.toColumnSpace(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...data.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: PropertyWidget(
                                      property: e,
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                          if (currentClass == "All")
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.toColumnSpace(),
                                  prop(),
                                  20.toColumnSpace(),
                                  Center(
                                    child: Text(
                                      "For Sale",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: const Color(0xff000000),
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  20.toColumnSpace(),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ...data.where((element) {
                                          return (element.propertyStatus
                                                  ?.toLowerCase() ==
                                              "for sale");
                                        }).map((e) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: PropertyWidget(
                                              property: e,
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  20.toColumnSpace(),
                                  prop(),
                                  20.toColumnSpace(),
                                  Center(
                                    child: Text(
                                      "For rent",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: const Color(0xff000000),
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  20.toColumnSpace(),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ...data.where((element) {
                                          return (element.propertyStatus
                                                  ?.toLowerCase() ==
                                              "for rent");
                                        }).map((e) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: PropertyWidget(
                                              property: e,
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  20.toColumnSpace(),
                                  prop(),
                                  20.toColumnSpace(),
                                  Center(
                                    child: Text(
                                      "Shortlet",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: const Color(0xff000000),
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  20.toColumnSpace(),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ...data.where((element) {
                                          return (element.propertyStatus
                                                  ?.toLowerCase() ==
                                              "For Shortlet".toLowerCase());
                                        }).map((e) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: PropertyWidget(
                                              property: e,
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  // 20.toColumnSpace(),
                                  // if (agents.isEmpty)
                                  // Column(
                                  //   children: [
                                  // Center(
                                  //   child: Container(
                                  //     width: 104,
                                  //     height: 34,
                                  //     decoration: BoxDecoration(
                                  //         borderRadius:
                                  //             BorderRadius.circular(20),
                                  //         color: const Color(0xffE6F1F7)),
                                  //     child: Center(
                                  //       child: Text(
                                  //         'Agents',
                                  //         style: GoogleFonts.nunito(
                                  //             color: const Color(0xff1173AB)),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 15),
                                  // Center(
                                  //   child: Text(
                                  //     "Agents",
                                  //     style: GoogleFonts.nunito(
                                  //         fontSize: 16,
                                  //         color: const Color(0xff000000),
                                  //         fontWeight: FontWeight.w700),
                                  //     textAlign: TextAlign.center,
                                  //   ),
                                  // ),
                                  // 30.toColumnSpace(),

                                  // ...List.generate(
                                  //     agents.length,
                                  //     (index) => Container(
                                  //           padding:
                                  //               const EdgeInsets.symmetric(
                                  //                   horizontal: 10,
                                  //                   vertical: 10),
                                  //           // width: 300,
                                  // child: AgentWidget(
                                  //   agent: agents[index],
                                  // ),
                                  //         ))
                                  //   ],
                                  // ),
                                ])
                        ],
                      );
                    },
                  )
                ]),
              ),
            ),
          ),
        ])));
  }

  Center prop() {
    return Center(
      child: Container(
        width: 104,
        height: 34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xffE6F1F7)),
        child: Center(
          child: Text(
            'Properties',
            style: GoogleFonts.nunito(color: const Color(0xff1173AB)),
          ),
        ),
      ),
    );
  }
}
