import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/models/entities/notification_model.dart';
import 'package:pinearth/backend/domain/models/entities/user_model.dart';
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:pinearth/backend/domain/services/i_local_storage_service.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';
import 'package:pinearth/screens/auth/login_screen.dart';
import 'package:pinearth/utils/constants/local_storage_keys.dart';

import '../../backend/domain/models/entities/agent_model.dart';
import '../../screens/feedback_alert/bot_toast_feedback_alert.dart';

class ProfileProvider extends BaseProvider {
  final IUserRepo userRepo;
  final ILocalStorageService localStorage;

  ProfileProvider(this.userRepo, this.localStorage);

  final profileState = ProviderActionState<UserModel>();
  final agentProfileState = ProviderActionState<dynamic>();
  final developerProfileState = ProviderActionState<AgentModel>();
  final notificationState = ProviderActionState<List<NotificationModel>>();
  final sendCompaintState = ProviderActionState<bool>();

  bool canList = false;
  String newProfilePic = "";

  final BotToastAlert botToastAlert = BotToastAlert();

  void setProfileState(UserModel res) {
    profileState.toSuccess(res);
  }

  void updateProfilePicture() async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (res != null) {
      newProfilePic = res.files[0].path ?? "";
      notifyListeners();
    }
  }

  void initialize(BuildContext context, {bool failSilently = false}) async {
    try {
      profileState.toLoading();
      notifyListeners();
      // final email = await localStorage.getItem(userDataBoxKey, userEmailKey, defaultValue: null);
      final res = await userRepo.profile();
      res.fold((l) {
        if (!failSilently) {
          toLogin(context);
        }
      }, (r) {
        print("role is ${r.role} ************* ");
        canList =
            ['Agent', 'Developer', 'Short let', 'Short-let'].contains(r.role);
        loadAgentProfile(context);
        if (r.role != null && r.role!.contains("Developer")) {
          loadDeveloperProfile(context);
        }
        profileState.toSuccess(r);

        notifyListeners();
      });
    } catch (error) {
      if (!failSilently) {
        toLogin(context);
      }
    }
  }

  void loadAgentProfile(BuildContext context) async {
    try {
      agentProfileState.toLoading();
      notifyListeners();
      // final email = await localStorage.getItem(userDataBoxKey, userEmailKey, defaultValue: null);
      final res = await userRepo.agentProfile();
      res.fold((l) {
        // toLogin(context);
      }, (r) {
        agentProfileState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      rethrow;
    }
  }

  void loadDeveloperProfile(BuildContext context) async {
    try {
      developerProfileState.toLoading();
      notifyListeners();
      final res = await userRepo.getBusinessProfile();
      res.fold((l) {
        developerProfileState.toError(l.message);

        // toLogin(context);
      }, (r) {
        developerProfileState.toSuccess(r);
      });
      notifyListeners();
    } catch (error) {
      developerProfileState.toError("No internet connection");

      rethrow;
    }
  }

  void loadNotifications(BuildContext context) async {
    try {
      notificationState.toLoading();
      notifyListeners();
      // final email = await localStorage.getItem(userDataBoxKey, userEmailKey, defaultValue: null);
      final res = await userRepo.notifications();
      res.fold((l) {
        notificationState.toError(l.message);
        notifyListeners();
      }, (r) {
        notificationState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      notificationState.toError("an unknown error has occurred");
      rethrow;
    }
  }

  void sendComplaint(Map<String, String> data) async {
    try {
      botToastAlert.showLoadingAlert("");

      sendCompaintState.toLoading();
      notifyListeners();

      final res = await userRepo.sendComplaint(data);
      botToastAlert.closeAlert();

      res.fold((l) {
        botToastAlert.showErrorAlert(l.message);
        sendCompaintState.toError(l.message);
      }, (r) {
        botToastAlert.showSuccessAlert("Message sent successfully");
        sendCompaintState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      botToastAlert.closeAlert();
      botToastAlert.showSuccessAlert("unknown error");

      sendCompaintState.toError("unknown error");

      // rethrow;
    }
  }

  void logout(BuildContext context) async {
    localStorage.setItem(userDataBoxKey, userTokenKey, "");
    localStorage.setItem(userDataBoxKey, userRefreshTokenKey, "");
    initialize(context);
  }

  void toLogin(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}

final profileProvider = ChangeNotifierProvider((ref) =>
    ProfileProvider(getIt<IUserRepo>(), getIt<ILocalStorageService>()));
