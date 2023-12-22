import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final IUserRepo userRepo;
  final IAlertInteraction alert;
  final ProfileProvider profile;
  ChangePasswordProvider(this.userRepo, this.alert, this.profile);

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  bool oldPasswordIsVisible = false;
  bool newPasswordIsVisible = false;

  void toggleOldPasswordVisibility() {
    oldPasswordIsVisible = !oldPasswordIsVisible;
    notifyListeners();
  }
  void toggleNewPasswordVisibility() {
    newPasswordIsVisible = !newPasswordIsVisible;
    notifyListeners();
  }

  void changePassword(BuildContext context) async {
    try {
      if (oldPasswordController.text.isEmpty) {
        alert.showErrorAlert("Please provide your old password.");
        return;
      }
      if (newPasswordController.text.isEmpty) {
        alert.showErrorAlert("Please provide a new password.");
        return;
      }
      alert.showLoadingAlert("");
      final user = profile.profileState.data!;
      final res = await userRepo.changePassword(
        user.id.toString(), 
        oldPasswordController.text,
        newPasswordController.text
      );
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert(l.message);
      }, (r) {
        alert.showSuccessAlert("Password changed successfully");
        Navigator.pop(context);
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Unable to change your password");
    }
  }
}

final changePasswordProvider = ChangeNotifierProvider.autoDispose((ref) {
  return ChangePasswordProvider(
    getIt<IUserRepo>(),
    getIt<IAlertInteraction>(),
    ref.watch(profileProvider)
  );
});