
import 'package:flutter/material.dart';

abstract class IAlertInteraction {
  void showSuccessAlert(String message, {Function? onClick});
  void showErrorAlert(String message);
  void showInfoAlert(String message, {Function? onClick});
  void showLoadingAlert(String message);
  void showConfirmAlert(BuildContext context, String message, Function onOkay, {
    String title = "Alert", 
    bool showCancelButton = true,
    String okayButtonText = "Proceed",
    String cancelButtonText = "Cancel"
  });
  void closeAlert();
}