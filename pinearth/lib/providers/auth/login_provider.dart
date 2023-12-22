
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/login_request.dart';
import 'package:pinearth/backend/domain/models/entities/user_model.dart';
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:pinearth/backend/domain/services/i_local_storage_service.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/root_screen.dart';
import 'package:pinearth/utils/constants/local_storage_keys.dart';

class LoginProvider extends ChangeNotifier {
  final IUserRepo userRepo;
  final ILocalStorageService localStorage;
  final IAlertInteraction alert;
  final ProfileProvider profileProvider;
  LoginProvider(
    this.userRepo, this.alert, this.localStorage,
    this.profileProvider
  );

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordIsVisible = false;

  void togglePasswordVisibility() {
    passwordIsVisible = !passwordIsVisible;
    notifyListeners();
  }


  void login(BuildContext context) async {
    try {
      if (emailController.text.isEmpty) {
        alert.showErrorAlert("Please provide your email address");
        return;
      }
      if (passwordController.text.isEmpty) {
        alert.showErrorAlert("Please provide your password");
        return;
      }
      primaryFocus!.unfocus();
      alert.showLoadingAlert("Please wait...");
      final res = await userRepo.login(LoginRequest(
        email: emailController.text, password: passwordController.text
      ));
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert(l.message);
      }, (r) {
        alert.showSuccessAlert("Login successful");
        localStorage.setItem(userDataBoxKey, userEmailKey, emailController.text);
        localStorage.setItem(userDataBoxKey, userTokenKey, r.tokens!.access);
        localStorage.setItem(userDataBoxKey, userRefreshTokenKey, r.tokens!.refresh);
        print(r.toJson());
        final user = UserModel.fromJson(r.toJson());
        profileProvider.setProfileState(user);
        _reset();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RootScreen()), (r) => false);
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Error: $error");
      rethrow;
    }
  }

  void _reset() {
    emailController.text = "";
    passwordController.text = "";
    notifyListeners();
  }

}

final loginProvider = ChangeNotifierProvider((ref) => LoginProvider(
  getIt<IUserRepo>(),
  getIt<IAlertInteraction>(),
  getIt<ILocalStorageService>(),
  ref.read(profileProvider)
));