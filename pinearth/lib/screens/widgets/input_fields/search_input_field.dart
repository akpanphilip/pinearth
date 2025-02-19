import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

class SearchPropertyFieldWidget extends StatelessWidget {
  const SearchPropertyFieldWidget({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.onClick,
    this.onChanged,
  });

  final TextEditingController controller;
  final bool readOnly;
  final Function? onClick;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black, fontSize: 13),
      readOnly: readOnly,
      controller: controller,
      onTap: () {
        if (onClick != null) {
          onClick!();
        }
      },
      onChanged: (String? str) {
        if (str != null && str.trim() != "" && onChanged != null) {
          onChanged!();
        }
      },
      decoration: InputDecoration(
          hintText: 'Enter an address, neighborhood or state',
          hintStyle: TextStyle(
              fontSize: 12.toFontSize(),
              fontWeight: FontWeight.w400,
              color: Colors.black),
          prefixIcon: const Icon(
            IconlyLight.search,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10000),
          ),
          constraints: const BoxConstraints(maxHeight: 40, minHeight: 40),
          filled: true,
          fillColor: const Color(0xFFEEEEEE),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16)),
    );
  }
}
