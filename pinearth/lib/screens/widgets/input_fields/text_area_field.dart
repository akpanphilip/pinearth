import 'package:flutter/material.dart';

class TextAreaField extends StatelessWidget {
  const TextAreaField({
    super.key,
    this.controller,
    this.hintText = "Type your message here...",
    this.height = 5
  });
  
  final String hintText;
  final TextEditingController? controller;
  final int height;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: const Color(0xffeeeeee),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none
        ),
        hintText: hintText
      ),
      maxLines: height,
      minLines: height,
    );
  }
}