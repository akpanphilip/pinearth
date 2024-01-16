import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:pinearth/backend/domain/models/core/failure.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/login_request.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/login_response.dart';
import 'package:pinearth/backend/domain/models/dtos/auth/update_profile_request.dart';
import 'package:pinearth/backend/domain/models/entities/user_model.dart';
import 'package:pinearth/backend/domain/models/entities/user_search_result_model.dart';

import '../models/dtos/auth/register_request.dart';
import '../models/dtos/auth/register_with_social_provider.dart';
import '../models/entities/notification_model.dart';

abstract class IUserRepo {
  // Login 
  Future<Either<IFailure, LoginResponse>> login(LoginRequest request);
  // Register
  Future<Either<IFailure, bool>> register(RegisterRequest request);
  Future<Either<IFailure, UserModel>> registerWithSocialProvider(Map<String,dynamic> request);
  Future<Either<IFailure, bool>> uploadId(String file);
  Future<Either<IFailure, dynamic>> changePassword(String id, String oldPass, String newPass);
  // Get user profile
  Future<Either<IFailure, UserModel>> profile();
  Future<Either<IFailure, dynamic>> agentProfile();
  // Notifications
  Future<Either<IFailure, List<NotificationModel>>> notifications();
  Future<Either<IFailure, dynamic>> requestPasswordReset(String email);
  // 
  Future<Either<IFailure, LoginResponse>> updateProfile(String uid, UpdateProfileRequest request);
  // Agent registration
  Future<Either<IFailure, bool>> agentRegistration(String type, String profileId, FormData detail);

  Future<Either<IFailure, bool>> agentProfileUpdate(String agentId, String type, String profileId, FormData detail);


  Future<Either<IFailure, List<UserSearchResultModel>>> searchUser(String param);
}