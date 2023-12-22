
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/login_request.dart' as lgR;
import 'package:pinearth/backend/domain/models/dtos/auth/register_request.dart';
import 'package:pinearth/backend/domain/models/entities/user_model.dart' as usr;
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:pinearth/backend/domain/services/i_local_storage_service.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/auth/register/account_success_screen.dart';
import 'package:pinearth/screens/auth/register/register_link_sent_screen.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/utils/constants/local_storage_keys.dart';

class RegisterProvider extends ChangeNotifier {
  final IUserRepo userRepo;
  final IAlertInteraction alert;
  final ILocalStorageService localStorage;
  final ProfileProvider profileProvider;
  RegisterProvider(
    this.userRepo, this.alert, this.localStorage,
    this.profileProvider
  );

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  String? idFile;
  DateTime? dateOfBirth;
  bool passwordIsVisible = false;

  void togglePasswordVisibility() {
    passwordIsVisible = !passwordIsVisible;
    notifyListeners();
  }

  void setDateOfBirth(DateTime dob) {
    dateOfBirth = dob;
    dateOfBirthController.text = DateFormat("yyyy-MM-dd").format(dob);
    notifyListeners();
  }

  bool checkBeforeAddress() {
    if (firstNameController.text.isEmpty) {
      alert.showErrorAlert("Please provide your first name");
      return false;
    }
    if (lastNameController.text.isEmpty) {
      alert.showErrorAlert("Please provide your last name");
      return false;
    }
    if (emailController.text.isEmpty) {
      alert.showErrorAlert("Please provide your email address");
      return false;
    }
    if (dateOfBirth == null) {
      alert.showErrorAlert("Please provide your date of birth");
      return false;
    }
    if (passwordController.text.isEmpty) {
      alert.showErrorAlert("Please provide your password");
      return false;
    }
    if (passwordController.text.length < 8) {
      alert.showErrorAlert("Password length must be 8 characters long.");
      return false;
    }



    return true;
  }

  bool checkAddress() {
    if (addressController.text.isEmpty) {
      alert.showErrorAlert("Please provide your address");
      return false;
    }

    return true;
  }

  void selectDocument() async {
    try {
      final file = await FilePicker.platform.pickFiles();
      if (file != null) {
        idFile = file.files.first.path!;
        notifyListeners();
      }
    } catch (error) {
      alert.showErrorAlert("Unable to select file");
    }
  }
  
  void changeDocument() {
    idFile = null;
    notifyListeners();
  }

  void register(BuildContext context) async {
    try {
      primaryFocus!.unfocus();
      alert.showLoadingAlert("Please wait...");
      final res = await userRepo.register(RegisterRequest(
        dOB: dateOfBirth!,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        middleName: middleNameController.text,
        password2: passwordController.text,
        password: passwordController.text,
        address: addressController.text, 
        uploadId: idFile!,
      ));
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert("${l.message}");
      }, (r) {
        alert.showSuccessAlert("Registration successful");
        // localStorage.setItem(userDataBoxKey, userTokenKey, r.tokens!.access);
        // localStorage.setItem(userDataBoxKey, userRefreshTokenKey, r.tokens!.refresh);
        // final user = usr.UserModel.fromJson(r.toJson());
        // profileProvider.setProfileState(user);

        emailController.clear();
        firstNameController.clear();
        lastNameController.clear();
        middleNameController.clear();
        passwordController.clear();
        addressController.clear();
        idFile = null;
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterLinkSentScreen()),
        );
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Error: $error");
      rethrow;
    }
  }



}

final registerProvider = ChangeNotifierProvider((ref) => RegisterProvider(
  getIt<IUserRepo>(),
  getIt<IAlertInteraction>(),
  getIt<ILocalStorageService>(),
  ref.read(profileProvider)
));