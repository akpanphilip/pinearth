import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

class RegistrationFieldWidget extends ConsumerWidget {
  const RegistrationFieldWidget({
    super.key,
    required this.controller,
    required this.label
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        22.toColumnSpace(),
        LabelTitle(text: '$label'),
        10.toColumnSpace(),
        CustomTextField(
          obscureText: false,
          hintText: "e.g Buyers agent, 3 years listing agent",
          controller: ref.read(registerAsAgentProvider).specialityController,
        ),
      ],
    );
  }
}