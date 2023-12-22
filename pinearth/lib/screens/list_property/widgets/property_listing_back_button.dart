import 'package:flutter/material.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';

class PropertyListingBackButton extends StatelessWidget {
  const PropertyListingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButtonWidget(
      onClick: () => Navigator.pop(context),
      child: const Center(child: Text("Back"),),
      color: const Color.fromARGB(162, 0, 0, 0),
    );
  }
}