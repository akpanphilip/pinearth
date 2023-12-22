import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/providers/agent/find_agent_provider.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

import 'agent_widget.dart';

class FeaturedAgentWidget extends ConsumerWidget {
  const FeaturedAgentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentState = ref.read(findAgentProvider).agentsState;
    final agents = agentState.data ?? [];
    return Container(
      // height: 266,
      padding: const EdgeInsets.only(left: 13.0, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 34, width: 102,
            decoration: BoxDecoration(
              color: appColor.chipBackground,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: Text("Featured", style: TextStyle(
                fontSize: 12.toFontSize(),
                fontWeight: FontWeight.w400,
                color: appColor.primary
              ),),
            ),
          ),
          22.toColumnSpace(),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...agents.take(3).map((e) {
                  return Container(
                    width: 300,
                    padding: const EdgeInsets.only(right: 22.0, top: 10, bottom: 10, left: 10),
                    child: AgentWidget(
                      agent: e,
                    ),
                  );
                }).toList()
              ],
            ),
          )
        ],
      ),
    );
  }
}