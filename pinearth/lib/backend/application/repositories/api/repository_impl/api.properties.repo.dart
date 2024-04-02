import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pinearth/backend/application/repositories/api/services/i_api.service.dart';
import 'package:pinearth/backend/domain/models/core/failure.dart';
import 'package:pinearth/backend/domain/models/dtos/property/schedule_visit_request.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/backend/domain/repositories/i_property_repo.dart';

import '../../../../domain/models/entities/user_model.dart';

class ApiPropertyRepo implements IPropertyRepo {
  final IApiService apiService;

  ApiPropertyRepo(this.apiService);

  @override
  Future<Either<IFailure, List<PropertyModel>>> properties() async {
    try {
      final res = await apiService.get("property/view/", requireToken: false);

      if (res.status == true) {
        return Right(List.from(res.data).map((e) {
          print("res data --------------- $e\n\n\n}");

          return PropertyModel.fromJson(e);
        }).toList());
      }
      return Left(RepoFailure(res.message ?? "could not complete request try again"));
    } catch (error) {
      // rethrow;
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, dynamic>> scheduleVisit(
      role, ScheduleVisitRequest request) async {
    try {
      final res = await apiService.post(
          "user/contact/agent/", request.toJson(), //user/contact/$role
          requireToken: true);
      if (res.status == true) {
        return const Right(true);
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, dynamic>> listProperty(FormData request) async {
    try {
      final res = await apiService.post("property/create/", request,
          requireToken: true,
          useFormData: false,
          extraHeader: {'Content-Type': 'multipart/form-data'});
      if (res.status == true) {
        return const Right(true);
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, List<PropertyModel>>> myProperties() async {
    try {
      final res = await apiService.get("property/viewmy/", requireToken: true);
      if (res.status == true) {
        return Right(
            List.from(res.data).map((e) => PropertyModel.fromJson(e)).toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, List<PropertyModel>>> searchProperties(
      {String? address,
      String? propertyStatus,
      String? state,
      String? propertyType,
      String? propertyPrice}) async {
    //property/search/?address=$address&property_status=$propertyStatus&property_type=$propertyType&property_price=$propertyPrice

    try {
      final res = await apiService.get(
          "property/search/?address=$address&property_status=$propertyStatus&state=$state&property_type=$propertyType",
          requireToken: false);
      if (res.status == true) {
        return Right(
            List.from(res.data).map((e) => PropertyModel.fromJson(e)).toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, bool>> changePropertyAvailability(
      String id, bool available) async {
    try {
      final res = await apiService.post(
          "property/status/$id/${available ? 'True' : 'False'}/", {},
          requireToken: true);
      if (res.status == true) {
        return const Right(true);
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, dynamic>> removeProperty(String id) async {
    try {
      final res =
          await apiService.put("property/remove/$id/", {}, requireToken: true);
      if (res.status == true) {
        return const Right(true);
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, dynamic>> saveProperty(String id) async {
    try {
      final res =
          await apiService.post("property/save/$id/", {}, requireToken: true);
      if (res.status == true) {
        return const Right(true);
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, List<PropertyModel>>> savedProperties() async {
    try {
      final res =
          await apiService.get("property/view_saved/", requireToken: true);
      if (res.status == true) {
        return Right(
            List.from(res.data).map((e) => PropertyModel.fromJson(e)).toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, PropertyModel>> getProperty(String id) async {
    try {
      final res =
          await apiService.get("property/view/$id/", requireToken: false);
      if (res.status == true) {
        return Right(PropertyModel.fromJson(res.data));
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, dynamic>> unSaveProperty(String id) async {
    try {
      final res =
          await apiService.put("property/save/$id/", {}, requireToken: true);
      if (res.status == true) {
        return const Right(true);
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }

  @override
  Future<Either<IFailure, ReviewModel>> commentOnProperty(
      int propertyId, String comment) async {
    try {
      final res = await apiService.post(
          "property/comment/$propertyId/",
          {
            "comment": comment,
            "review": comment,
          },
          requireToken: true);
      if (res.status == true) {
        return Right(ReviewModel.fromJson(res.data));
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      return Left(RepoFailure("Error: $error"));
    }
  }
}
