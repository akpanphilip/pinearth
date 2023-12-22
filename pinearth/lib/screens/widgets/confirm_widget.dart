import 'package:flutter/material.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class CustomConfirmWidget extends StatelessWidget {
  CustomConfirmWidget({
    super.key,
    this.title = "Alert", 
    this.message = "Some Message to know",
    this.okayButtonText = "Proceed",
    this.cancelButtonText = "Cancel",
    this.showCancelButton = true,
    required this.onOkay
  });

  final String title;
  final String message;
  final String okayButtonText;
  final String cancelButtonText;
  bool showCancelButton;
  Function onOkay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appColor.primary.withOpacity(.5)
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: TextStyle(
            fontSize: 16.toFontSize(), fontWeight: FontWeight.w700,
            color: Colors.white
          ),),
          11.toColumnSpace(),
          Text(message, style: TextStyle(
            fontSize: 14.toFontSize(), fontWeight: FontWeight.w400,
            color: Colors.white
          ),),
          26.toColumnSpace(),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    onOkay();
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: appColor.primary,
                      borderRadius: BorderRadius.circular(3)
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    child: Center(
                      child: Text(okayButtonText, style: TextStyle(
                        fontSize: 14.toFontSize(),
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),),
                    ),
                  ),
                ),
              ),
              if (showCancelButton) ...[
                5.toRowSpace(),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.8),
                        borderRadius: BorderRadius.circular(3)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: Center(
                        child: Text(cancelButtonText, style: TextStyle(
                          fontSize: 14.toFontSize(),
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          )
        ],
      ),
    );
  }
}