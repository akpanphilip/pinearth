import 'package:flutter/material.dart';
import 'package:pinearth/utils/styles/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.child,
    required this.onClick,
    this.color = const Color.fromARGB(162, 0, 0, 0),
    this.radius = 8
  });

  final Widget child;
  final Function onClick;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
      onPressed: () => onClick(),
      child: child
    );
  }
}

class CustomOutlineButtonWidget extends StatelessWidget {
  const CustomOutlineButtonWidget({
    super.key,
    required this.child,
    required this.onClick,
    this.color = const Color.fromARGB(162, 0, 0, 0),
    this.borderColor = Colors.black,
  });

  final Widget child;
  final Function onClick;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: borderColor,
            width: 1
          ),
        ),
        side: BorderSide(
          color: borderColor
        )
      ),
      onPressed: () => onClick(),
      child: child,
    );
  }
}