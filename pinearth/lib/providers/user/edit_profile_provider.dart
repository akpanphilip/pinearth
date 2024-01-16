import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/update_profile_request.dart';
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';

class EditProfileProvider extends BaseProvider {
  final IUserRepo userRepo;
  final IAlertInteraction alert;
  final ProfileProvider profileProvider;
  EditProfileProvider(this.userRepo, this.alert, this.profileProvider) {
    final profile = profileProvider.profileState.data;
    firstNameController.text = profile?.firstName ?? "";
    lastNameController.text = profile?.lastName ?? "";
    middleNameController.text = profile?.middleName ?? "";
    emailController.text = profile?.email ?? "";
    addressController.text =
        profile?.profile == null ? "" : profile?.profile?.address ?? "";
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  void updateProfile(BuildContext context) async {
    try {
      if (firstNameController.text.isEmpty) {
        alert.showErrorAlert("Please provide your first name");
        return;
      }
      if (lastNameController.text.isEmpty) {
        alert.showErrorAlert("Please provide your last name");
        return;
      }
      if (addressController.text.isEmpty) {
        alert.showErrorAlert("Please provide your address");
        return;
      }
      alert.showLoadingAlert("");
      final profile = profileProvider.profileState.data!;
      final res = await userRepo.updateProfile(
          profile.id.toString(),
          UpdateProfileRequest(
              email: emailController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              middleName: middleNameController.text,
              address: addressController.text));
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert(l.message);
      }, (r) {
        alert.showSuccessAlert("Profile updated successfully");
        profileProvider.initialize(context);
        Navigator.pop(context);
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Error: unable to update profile");
    }
  }
}

final editProfileProvider = ChangeNotifierProvider((ref) => EditProfileProvider(
    getIt<IUserRepo>(), getIt<IAlertInteraction>(), ref.read(profileProvider)));
