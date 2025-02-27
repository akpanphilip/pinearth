import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pinearth/backend/application/repositories/api/services/i_api.service.dart';
import 'package:pinearth/backend/domain/models/core/failure.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/login_request.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/login_response.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/register_request.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/update_profile_request.dart';
import 'package:pinearth/backend/domain/models/entities/notification_model.dart';
import 'package:pinearth/backend/domain/models/entities/user_model.dart';
import 'package:pinearth/backend/domain/models/entities/user_search_result_model.dart';
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:dio/dio.dart';

import '../../../../domain/models/dtos/auth/register_with_social_provider.dart';
import '../../../../domain/models/entities/agent_model.dart';

class ApiUserRepo implements IUserRepo {
  final IApiService apiService;

  ApiUserRepo(this.apiService);

  @override
  Future<Either<IFailure, LoginResponse>> login(LoginRequest request) async {
    try {
      final res = await apiService.post("user/login/", request.toJson(),
          requireToken: false);
      if (res.status == true) {
        return Right(LoginResponse.fromJson(res.data));
      }
      return Left(RepoFailure(res.message ?? 'Unable to login'));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, bool>> register(
    RegisterRequest request,
  ) async {
    try {
      final data = {
        ...request.toJson(),
        'upload_id': await MultipartFile.fromFile(request.uploadId!)
      };
      // data.remove('upload_id');
      final res = await apiService.post("user/register/", data,
          requireToken: false, useFormData: true);
      if (res.status == true) {
        // return Right(UserModel.fromJson(res.data));
        return const Right(true);
      }
      return Left(RepoFailure(res.message ?? 'Unable to register'));
    } catch (error) {
      print("error ---------- $error");
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, UserModel>> registerWithSocialProvider(
      Map<String, dynamic> request) async {
    try {
      final data = request;
      // data.remove('upload_id');
      final res = await apiService.post("user/auth/google/login/app/", data,
          requireToken: false,
          useFormData: true,
          extraHeader: {"Content-Type": "multipart/form-data"});

      print("json is ${res.data["data"]}");

      if (res.status == true) {
        return Right(UserModel.fromJson(res.data["data"]));
      }

      if (res.statusCode == 500) {
        return Left(
            RepoFailure("User already registered with email and password"));
      }

      return Left(RepoFailure(res.message ?? 'Unable to register'));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, bool>> uploadId(String file) async {
    try {
      final data = {'upload_id': await MultipartFile.fromFile(file)};

      final res = await apiService.post("user/auth/google/login/app/", data,
          requireToken: true,
          useFormData: true,
          extraHeader: {"Content-Type": "multipart/form-data"});

      if (res.status == true) {
        return const Right(true);
      }

      return Left(RepoFailure(res.message ?? 'Unable to upload id'));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, UserModel>> profile() async {
    try {
      final res = await apiService.get("user/info/", requireToken: true);
      if (res.status == true) {
        return Right(UserModel.fromJson(res.data));
      }
      return Left(RepoFailure(res.message ?? 'Unable get profile'));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
      // rethrow;
    }
  }

  @override
  Future<Either<IFailure, dynamic>> agentProfile() async {
    try {
      final res = await apiService.get("property/roles/", requireToken: true);
      if (res.status == true) {
        return Right(res.data);
      }
      return Left(RepoFailure(res.message ?? 'Unable get profile'));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
      // rethrow;
    }
  }

  @override
  Future<Either<IFailure, LoginResponse>> updateProfile(
      String uid, UpdateProfileRequest request) async {
    final data = {...request.toJson()};
    final res = await apiService.put("user/$uid/update/", data,
        requireToken: true, useFormData: false);
    if (res.status == true) {
      return Right(LoginResponse.fromJson(res.data));
    }
    return Left(RepoFailure(res.message ?? 'Unable to register'));
  }

  @override
  Future<Either<IFailure, bool>> agentRegistration(
      String type, String profileId, FormData detail) async {
    final res = await apiService.post("role/$type/", detail,
        requireToken: true,
        useFormData: false,
        extraHeader: {'Content-Type': 'multipart/form-data'});

    if (res.status == true) {
      return const Right(true);
    }
    return Left(RepoFailure(res.message ?? 'Unable to register'));
  }

  @override
  Future<Either<IFailure, List<NotificationModel>>> notifications() async {
    try {
      final res = await apiService.get("notif/view/", requireToken: true);
      if (res.status == true) {
        if (res.data.isEmpty || res.data["messages"] == null) {
          return const Right([]);
        } else {
          return Right(List.from(res.data["messages"])
              .map((e) => NotificationModel.fromJson(e))
              .toList());
        }
      }
      return Left(RepoFailure(res.message ?? 'Unable get messages'));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
      // rethrow;
    }
  }

  @override
  Future<Either<IFailure, dynamic>> changePassword(
      String id, String oldPass, String newPass) async {
    try {
      final res = await apiService.put(
          "user/change_password/$id/",
          {
            "old_password": "$oldPass",
            "password": "$newPass",
            "password2": "$newPass"
          },
          requireToken: true);
      if (res.status == true) {
        return Right(true);
      }
      return Left(RepoFailure(res.message ?? 'Unable get messages'));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, dynamic>> requestPasswordReset(String email) async {
    try {
      final res = await apiService.post(
          "user/reset_request/",
          {
            "email": "$email",
          },
          requireToken: false);
      if (res.status == true) {
        return const Right(true);
      }
      return Left(RepoFailure(res.message ?? 'Unable get messages'));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, bool>> agentProfileUpdate(
      String agentId, String type, String profileId, FormData detail) async {
    try {
      final res = await apiService.put(
          "role/${type.replaceAll('an ', '').replaceAll('a ', '')}/$agentId/update/",
          detail,
          requireToken: true,
          useFormData: false,
          extraHeader: {'Content-Type': 'multipart/form-data'});

      if (res.status == true) {
        return const Right(true);
      }
      return Left(RepoFailure(res.message ?? 'Unable to update profile'));
    } catch (error) {
      return Left(RepoFailure('Unable to update profile'));
    }
  }

  @override
  Future<Either<IFailure, List<UserSearchResultModel>>> searchUser(
      String param) async {
    try {
      final res = await apiService.get("user/search/?search=$param",
          requireToken: true);
      if (res.status == true) {
        return Right(List.from(res.data)
            .map((e) => UserSearchResultModel.fromJson(e))
            .toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Either<IFailure, AgentModel>> getBusinessProfile() async {
    try {
      final res =
          await apiService.get("/property/a developer/", requireToken: true);

      if (res.status == true) {
        return Right(AgentModel.fromJson(res.data));
      } else {
        return Left(RepoFailure(res.message!));
      }
    } catch (error) {
      // rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }

  @override
  Future<Either<IFailure, AgentModel>> getBusinessAccount(
      String accountType) async {
    print("url is /property/$accountType/}");
    try {
      final res =
          await apiService.get("/property/$accountType/", requireToken: true);

      if (res.status == true) {
        return Right(AgentModel.fromJson(res.data));
      } else {
        return Left(RepoFailure(res.message!));
      }
    } catch (error) {
      // rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }

  @override
  Future<Either<IFailure, bool>> sendComplaint(
      Map<String, String> message) async {
    try {
      final res =
          await apiService.post("/user/support/", message, requireToken: true);

      if (res.status == true) {
        return const Right(true);
      } else {
        return Left(RepoFailure(res.message!));
      }
    } catch (error) {
      // rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }
}
