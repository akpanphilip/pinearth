
import 'package:flutter/material.dart';
import 'package:pinearth/backend/domain/models/dtos/property/schedule_visit_request.dart';
import 'package:pinearth/backend/domain/repositories/i_property_repo.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';

class ScheduleAVisitProvider extends ChangeNotifier {
  final IPropertyRepo propertyRepo;
  final IAlertInteraction alert;
  ScheduleAVisitProvider(this.propertyRepo, this.alert);

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  void scheduleVisit(BuildContext context, String ownerEmail, String role) async {
    try {
      alert.showLoadingAlert("");
      final res = await propertyRepo.scheduleVisit(role, ScheduleVisitRequest(
        recipient: ownerEmail, 
        name: nameController.text, 
        phoneNo: phoneNumberController.text, 
        email: emailController.text, 
        message: messageController.text,
        // role: role
      ));
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert(l.message);
      }, (r) {
        alert.showSuccessAlert("Visit has been scheduled");
        Navigator.pop(context);
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Error: $error");
    }
  }
}
