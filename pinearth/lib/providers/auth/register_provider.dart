import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/login_request.dart'
    as lgR;
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

import '../../backend/domain/models/entities/user_model.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register/home_address.dart';
import '../../screens/root_screen.dart';

class RegisterProvider extends ChangeNotifier {
  final IUserRepo userRepo;
  final IAlertInteraction alert;
  final ILocalStorageService localStorage;
  final ProfileProvider profileProvider;

  RegisterProvider(
      this.userRepo, this.alert, this.localStorage, this.profileProvider);

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  bool loginWithGoogle = false;
  bool loadingGoogleInfo = false;
  String? email;
  String? givenName;
  String? familyName;
  String? profilePicture;
  String? idFile;
  DateTime? dateOfBirth;
  bool passwordIsVisible = false;
  String selectedState = "Rivers state";

  set updateSelectedState(String state) {
    selectedState = state;
    notifyListeners();
  }

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

  bool checkId() {
    if (idFile == null) {
      alert.showErrorAlert("Please provide a valid identification");
      return false;
    }

    return true;
  }

  void selectDocument() async {
    try {
      final file = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ["jpg", "png", "jpeg", "pdf"]);
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

  // void getGoogleUserInfo(BuildContext context) async {
  //   try {
  //     loadingGoogleInfo = true;
  //     notifyListeners();
  //
  //     final googleSignIn = GoogleSignIn();
  //
  //     if (await googleSignIn.isSignedIn()) {
  //       googleSignIn.disconnect();
  //     }
  //
  //     await googleSignIn.signIn().then((googleSignInAccount) {
  //       loadingGoogleInfo = false;
  //       notifyListeners();
  //
  //       if (googleSignInAccount != null) {
  //         final displayName = googleSignInAccount.displayName;
  //         final id = googleSignInAccount.id;
  //
  //         givenName = displayName?.split(" ")[0];
  //         familyName =
  //             (displayName != null && displayName.split(" ").length > 1)
  //                 ? displayName.split(" ")[1]
  //                 : null;
  //         profilePicture = googleSignInAccount.photoUrl;
  //         email = googleSignInAccount.email;
  //
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const HomeAddress()),
  //         );
  //
  //         // registerWithSocialProvider(context);
  //       } else {
  //         debugPrint("sign in account is null");
  //         // throw Exception();
  //       }
  //     });
  //   } catch (e) {
  //     debugPrint("error $e");
  //     loadingGoogleInfo = false;
  //     notifyListeners();
  //     alert.closeAlert();
  //     alert.showErrorAlert("Error: could not register using google");
  //   }
  // }

  void registerWithGoogle(BuildContext context, {bool isLogin = false}) async {
    try {
      loadingGoogleInfo = true;
      notifyListeners();

      final googleSignIn = GoogleSignIn();

      if (await googleSignIn.isSignedIn()) {
        googleSignIn.disconnect();
      }

      await googleSignIn.signIn().then((googleSignInAccount) {
        loadingGoogleInfo = false;
        notifyListeners();

        if (googleSignInAccount != null) {
          final displayName = googleSignInAccount.displayName;
          final id = googleSignInAccount.id;

          givenName = displayName?.split(" ")[0];
          familyName =
              (displayName != null && displayName.split(" ").length > 1)
                  ? displayName.split(" ")[1]
                  : null;
          profilePicture = googleSignInAccount.photoUrl;
          email = googleSignInAccount.email;

          registerWithSocialProvider(context, isLogin: isLogin);
        } else {
          debugPrint("sign in account is null");
          // throw Exception();
        }
      });
    } catch (e) {
      debugPrint("error $e");
      loadingGoogleInfo = false;
      notifyListeners();
      alert.closeAlert();
      alert.showErrorAlert("Error: could not register using google");
    }
  }

  void register(
    BuildContext context,
  ) async {
    try {
      primaryFocus?.unfocus();
      alert.showLoadingAlert("Please wait...");
      final res = await userRepo.register(RegisterRequest(
        dOB: dateOfBirth,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        middleName: middleNameController.text,
        password2: passwordController.text,
        password: passwordController.text,
        address: addressController.text,
        uploadId: idFile,
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
          MaterialPageRoute(
              builder: (context) => const RegisterLinkSentScreen()),
        );
      });
    } catch (error) {
      print("exception caught $error");
      alert.closeAlert();
      alert.showErrorAlert("Error: $error");
      rethrow;
    }
  }

  void uploadId(
    BuildContext context,
  ) async {
    try {
      primaryFocus?.unfocus();
      alert.showLoadingAlert("Please wait...");

      final res = await userRepo.uploadId(idFile!);

      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert("${l.message}");
      }, (r) {
        alert.showSuccessAlert("Upload successfull");

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => RootScreen()),
            (v) => false);
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Error: $error");
      rethrow;
    }
  }

  void registerWithSocialProvider(BuildContext context,
      {bool isLogin = false}) async {
    try {
      primaryFocus?.unfocus();
      alert.showLoadingAlert("Please wait...");

      final res = await userRepo.registerWithSocialProvider({
        "email": email,
        "given_name": givenName,
        "family_name": familyName,
        "profile_picture": profilePicture,
      });
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert("${l.message}");
      }, (r) {
        alert.showSuccessAlert(
            isLogin ? "Login successful" : "Registration successful");

        // print("profile upload id is ${r.profile?.uploadId}");

        // if (r.profile?.uploadId == null || r.profile?.uploadId!.trim() == "") {
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(builder: (context) => const HomeAddress()),
        //       (r) => false);
        // } else {
        localStorage.setItem(userDataBoxKey, userEmailKey, email);
        localStorage.setItem(userDataBoxKey, userTokenKey, r.tokens!.access);
        localStorage.setItem(
            userDataBoxKey, userRefreshTokenKey, r.tokens!.refresh);
        // print(r.toJson());
        final user = UserModel.fromJson(r.toJson());
        profileProvider.setProfileState(user);
        //
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => RootScreen()),
            (v) => false);
        // }
      });
    } catch (error) {
      print("in provider error ------------------------- $error");
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
    ref.read(profileProvider)));
