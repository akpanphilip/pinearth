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

class ProfileProvider extends BaseProvider {
  final IUserRepo userRepo;
  final ILocalStorageService localStorage;

  ProfileProvider(this.userRepo, this.localStorage);

  final profileState = ProviderActionState<UserModel>();
  final agentProfileState = ProviderActionState<dynamic>();
  final notificationState = ProviderActionState<List<NotificationModel>>();

  bool canList = false;
  String newProfilePic = "";

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
        loadAgentProfile(context);
        profileState.toSuccess(r);
        canList = ['Agent', 'Developer', 'Short let'].contains(r.role);
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

  void loadNotifications(BuildContext context) async {
    try {
      notificationState.toLoading();
      notifyListeners();
      // final email = await localStorage.getItem(userDataBoxKey, userEmailKey, defaultValue: null);
      final res = await userRepo.notifications();
      res.fold((l) {
        toLogin(context);
      }, (r) {
        notificationState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      toLogin(context);
      rethrow;
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
