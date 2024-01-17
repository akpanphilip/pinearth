import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/providers/properties/search_property_provider.dart';
import 'package:pinearth/screens/find_agent/find_agent_screen.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/empty_state_widget.dart';
import 'package:pinearth/screens/widgets/input_fields/search_input_field.dart';
import 'package:pinearth/screens/widgets/property_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import '../../backend/application/servicies/localstorage/hive.local_storage.service.dart';
import '../../backend/domain/services/i_local_storage_service.dart';
import '../../utils/constants/local_storage_keys.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<String> items = [];

  // String selected = 'All';

  void onTap(String selected) {
    if (selected == 'Agents') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const FindAgentScreen(type: agentAgentType)));
    } else if (selected == 'Landlord') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const FindAgentScreen(type: landlordAgentType)));
    } else if (selected == 'Hotel') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const FindAgentScreen(type: hotelAgentType)));
    } else if (selected == 'Developer') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const FindAgentScreen(type: developerAgentType)));
    } else if (selected == 'Event Center') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const FindAgentScreen(type: eventCenterAgentType)));
    } else if (selected == 'Shortlet') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const FindAgentScreen(type: shortletAgentType)));
    } else {
      ref.read(searchPropertyProvider).updatePropertyStatus = selected;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      items = [
        'All',
        'For Rent',
        'For Sale',
        'House loans',
        if (await HiveLocalStorageService()
                .getItem(userDataBoxKey, userTokenKey, defaultValue: null) !=
            null) ...[
          'Developer',
          'Event Center',
          'Shortlet',
          'Hotel',
          'Agents',
          'Landlord',
        ]
      ];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          56.toColumnSpace(),
          Row(
            children: [
              38.toRowSpace(),
              const Icon(
                Icons.close,
                color: Colors.transparent,
              ),
              Expanded(
                child: Text(
                  "What are you looking for?",
                  style: TextStyle(
                      fontSize: 16.toFontSize(),
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close)),
              38.toRowSpace(),
            ],
          ),
          30.toColumnSpace(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer(
              builder:
                  (BuildContext context, WidgetRef widgetRef, Widget? child) {
                final ref = widgetRef.watch(searchPropertyProvider);

                return Wrap(
                  runSpacing: 23,
                  spacing: 30,
                  alignment: WrapAlignment.center,
                  children: [
                    ...items.map((e) => InkWell(
                          onTap: () {
                            onTap(e);
                            // setState(() {
                            //   selected = e;
                            // });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 9, horizontal: 12),
                            decoration: BoxDecoration(
                                color: e == ref.propertyStatus
                                    ? appColor.primary
                                    : Colors.black.withOpacity(.5),
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.toFontSize(),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ))
                  ],
                );
              },
            ),
          ),
          57.toColumnSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SearchPropertyFieldWidget(
                controller:
                    ref.read(searchPropertyProvider).searchParamController),
          ),
          10.toColumnSpace(),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final searchProvider = ref.watch(searchPropertyProvider);
                final propertySearchState =
                    searchProvider.allPropertySearchResult;
                if (searchProvider.searchParamController.text.isEmpty) {
                  return const Center(
                    child: Text("Start typing to search..."),
                  );
                }
                if (propertySearchState.isLoading()) {
                  return Container(
                    color: Colors.black.withOpacity(.01),
                    child: Center(
                      child: Image.asset(
                        'loading_logo'.png,
                        height: 50,
                        width: 50,
                      )
                          .animate(
                            autoPlay: true,
                            onComplete: (controller) => controller.repeat(),
                          )
                          .fade(
                              duration: const Duration(milliseconds: 600),
                              end: .5,
                              curve: Curves.easeInOut),
                    ),
                  );
                }
                if (propertySearchState.isError()) {
                  return CustomErrorWidget(
                      message: propertySearchState.message,
                      onReload: () => searchProvider.searchProperty());
                }

                final data = propertySearchState.data ?? [];

                if (data.isEmpty) {
                  return EmptyStateWidget(
                    onReload: () => searchProvider.searchProperty(),
                    message:
                        "There is no property with the provided search query.",
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: PropertyWidget(
                        property: data[index],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
