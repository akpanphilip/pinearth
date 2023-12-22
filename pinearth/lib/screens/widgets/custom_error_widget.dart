
import 'package:flutter/material.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.message,
    required this.onReload
  });

  final String message;
  final Function onReload;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message, style: const TextStyle(
            color: Colors.red,
          ), textAlign: TextAlign.center,),
          10.toColumnSpace(),
          InkWell(
            onTap: () => onReload(),
            child: const Text('Tap to refresh', style: TextStyle(
              color: Colors.black
            ),)
          )
        ],
      ),
    );
  }
}