import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/providers/agent/find_agent_provider.dart';
import 'package:pinearth/screens/find_agent/widget/agent_widget.dart';
import 'package:pinearth/screens/widgets/custom_chip_widget.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/empty_state_widget.dart';
import 'package:pinearth/screens/widgets/input_fields/search_input_field.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

import '../widgets/property_widget.dart';
import 'widget/featured_agents_widget.dart';

class FindAgentScreen extends ConsumerStatefulWidget {
  const FindAgentScreen({super.key, required this.type});

  final String type;

  @override
  ConsumerState<FindAgentScreen> createState() => _FindAgentScreenState();
}

class _FindAgentScreenState extends ConsumerState<FindAgentScreen> {
  Timer? timer;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final findAgentRef = ref.read(findAgentProvider);
      findAgentRef.setAgentType(widget.type);
      findAgentRef.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        backgroundColor: Colors.white,
        title: AppbarTitle(
          text: 'Find ${widget.type}',
        ),
        centerTitle: false,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            ref.read(findAgentProvider).reset();
            ref.read(findAgentProvider).loadAgents();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          ref.read(findAgentProvider).reset();
          ref.read(findAgentProvider).loadAgents();
          return Future.value(true);
        },
        child: Column(
          children: [
            56.toColumnSpace(),
            Center(
              child: Text(
                "Find  ${("aeiou".contains(widget.type[0].toLowerCase())) ? "an" : "a"} ${widget.type.toLowerCase()} in your area",
                style: TextStyle(
                    fontSize: 20.toFontSize(),
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            23.toColumnSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31.0),
              child: SearchPropertyFieldWidget(
                controller: ref.watch(findAgentProvider).searchParamController,
                onChanged: () {
                  if (timer != null) timer!.cancel();
                  timer = Timer(const Duration(milliseconds: 500),
                      () => ref.read(findAgentProvider).initialize());
                },
              ),
            ),
            41.toColumnSpace(),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final agentState = ref.watch(findAgentProvider).agentsState;
                if (agentState.isLoading()) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (agentState.isError()) {
                  return Center(
                    child: CustomErrorWidget(
                        message: agentState.message,
                        onReload: () =>
                            ref.read(findAgentProvider).initialize()),
                  );
                }
                // print(agentState.data);
                final data = agentState.data ?? [];
                if (data.isEmpty) {
                  return EmptyStateWidget(
                    onReload: () => ref.read(findAgentProvider).initialize(),
                    message: "No ${widget.type} found.",
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const FeaturedAgentWidget(),
                      22.toColumnSpace(),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 13.0),
                      //   child: CustomChipWidget(
                      //     label: widget.type.capitalizeFirst(),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "${widget.type.capitalizeFirst()}s",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      22.toColumnSpace(),
                      ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          // if (widget.type == shortletAgentType) {
                          //   return PropertyWidget(
                          //     property: data[index],
                          //   );
                          // }

                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: AgentWidget(
                                agent: data[index], showBookNow: false),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
