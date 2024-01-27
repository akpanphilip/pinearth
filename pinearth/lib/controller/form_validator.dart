import 'package:flutter/material.dart';

import '../utils/styles/colors.dart';

class Validator {
  static String? validateEmptyField(String? str) {
    if (str == null || str.trim().isEmpty) {
      return "Field cannot be empty";
    } else {
      return null;
    }
  }
}

class TextEditingControllerEdit extends TextEditingController {
  // final TextEditingController controller;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    String text = super.value.text;

    // Split the text into words
    List<String> words = text.split(' ');

    // Build the TextSpan for the updated text
    List<TextSpan> spans = [];

    //highlight the next word
    int highlightIndex = -1;

    if (words.isNotEmpty) {
      for (int index = 0; index <= words.length - 1; index++) {
        if (words[index].startsWith("@") && (index != words.length - 1)) {
          //Color the next index
          highlightIndex = index + 1;
        }

        if (words[index].startsWith("@") || highlightIndex == index) {
          spans.add(TextSpan(
              text: "${words[index]} ",
              style: TextStyle(color: appColor.green1)));
        } else {
          spans.add(TextSpan(
              text: "${words[index]} ",
              style: const TextStyle(color: Colors.black)));
        }
      }
    }
    return TextSpan(children: spans);
  }
}
