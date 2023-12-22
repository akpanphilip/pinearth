
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinearth/screens/widgets/confirm_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

import 'i_feedback_alert.dart';


class BotToastAlert implements IAlertInteraction {

  @override
  showSuccessAlert(String message, {Function? onClick}) {
    BotToast.cleanAll();
    BotToast.showCustomNotification(
      toastBuilder: (cc) => Material(
        color: Colors.transparent,
        child: Container(
            margin: const EdgeInsets.only(top: 5, right: 16, left: 16),
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline_rounded, color: Colors.white,),
                8.toRowSpace(),
                Expanded(
                    child: Text(message, style: const TextStyle(
                        color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400
                    ),)
                ),
                InkWell(
                    onTap: () => cc(),
                    child: const Icon(Icons.cancel, color: Colors.white)
                )
              ],
            )
        ),
      ),
      align: Alignment.topCenter,
      duration: const Duration(seconds: 4),
    );
  }


  @override
  showInfoAlert(String message, {Function? onClick}) {
    BotToast.cleanAll();
    BotToast.showCustomNotification(
      toastBuilder: (cc) => Material(
        color: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
            margin: const EdgeInsets.only(top: 5, right: 16, left: 16),
            decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: Colors.white,),
                8.toRowSpace(),
                Expanded(
                    child: Text(message, style: const TextStyle(
                        color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400
                    ),)
                ),
                InkWell(
                  child: const Icon(Icons.cancel, color: Colors.white),
                  onTap: () => cc(),
                )
              ],
            )
        ),
      ),
      align: Alignment.topCenter,
      duration: const Duration(seconds: 5),
    );
  }


  @override
  showErrorAlert(String message) {
    BotToast.showCustomNotification(toastBuilder: (cancelFunc) {
      return Material(
        color: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
            margin: const EdgeInsets.only(top: 5, right: 16, left: 16),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: Colors.white,),
                8.toRowSpace(),
                Expanded(
                    child: Text(message, style: const TextStyle(
                        color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400
                    ),)
                ),
                InkWell(
                    onTap: () => cancelFunc(),
                    child: const Icon(Icons.close, color: Colors.white)
                )
              ],
            )
        ),
      );
    }, duration: const Duration(seconds: 8), align: Alignment.topCenter);
  }

  @override
  showLoadingAlert(String message) {
    BotToast.cleanAll();
    BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) {
        return Container(
          color: Colors.black.withOpacity(.5),
          child: Center(
            child: Image.asset('loading_logo'.png, height: 50, width: 50,).animate(
              autoPlay: true,
              onComplete: (controller) => controller.repeat(),
            ).fade(
              duration: const Duration(milliseconds: 600),
              end: .5,
              curve: Curves.easeInOut
            ),
          ),
        );
      },
    );
  }

  @override
  showConfirmAlert(BuildContext context, String message, Function onOkay, {
    String title = "Alert", 
    bool showCancelButton = true,
    String okayButtonText = "Proceed",
    String cancelButtonText = "Cancel"
  }) {

    showDialog(
      // backgroundColor: Colors.transparent,
      context: context, builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          elevation: 0,
          child: CustomConfirmWidget(
            title: title,
            message: message,
            onOkay: onOkay,
            showCancelButton: showCancelButton,
            okayButtonText: okayButtonText,
            cancelButtonText: cancelButtonText,
          ),
        );
      // return AlertDialog(
      //   backgroundColor: Colors.white,
      //   content: Text(message, style: const TextStyle(
      //       fontSize: 16, fontWeight: FontWeight.w500
      //   ), textAlign: TextAlign.center,),
      //   actions: [
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       style: ButtonStyle(
      //           padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(22, 10, 22, 10)),
      //           backgroundColor: MaterialStateProperty.all(const Color(0xFF6C7E95).withOpacity(.60)),
      //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(5)
      //           ))
      //       ),
      //       child: const Text("Cancel"),
      //     ),
      //     // const Gap(5),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //         onOkay();
      //       },
      //       style: ButtonStyle(
      //           padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(22, 10, 22, 10)),
      //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(5)
      //           ))
      //       ),
      //       child: const Text("Confirm"),
      //     )
      //   ],
      //   actionsAlignment: MainAxisAlignment.center,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(15)
      //   ),
      // );
    },);
  }


  @override
  closeAlert() {
    // Navigator.of(context).pop();
    BotToast.closeAllLoading();
    // BotToast.
  }
}


class OptionAlertItem {
  String name;
  Function onclick;
  Color? color;


  OptionAlertItem({required this.name, required this.onclick});
}