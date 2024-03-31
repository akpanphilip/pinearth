import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pinearth/backend/domain/models/core/failure.dart';
import 'package:pinearth/backend/domain/models/dtos/property/schedule_visit_request.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';

import '../models/entities/user_model.dart';

abstract class IPropertyRepo {
  Future<Either<IFailure, List<PropertyModel>>> properties();
  Future<Either<IFailure, List<PropertyModel>>> searchProperties(
      {String? address,
      String? state,
      String? propertyStatus,
      String? propertyType,
      String? propertyPrice});
  Future<Either<IFailure, List<PropertyModel>>> myProperties();
  Future<Either<IFailure, List<PropertyModel>>> savedProperties();
  Future<Either<IFailure, bool>> changePropertyAvailability(
      String id, bool available);
  Future<Either<IFailure, dynamic>> scheduleVisit(
      String role, ScheduleVisitRequest request);
  Future<Either<IFailure, dynamic>> listProperty(FormData request);
  Future<Either<IFailure, dynamic>> saveProperty(String id);
  Future<Either<IFailure, dynamic>> unSaveProperty(String id);
  Future<Either<IFailure, dynamic>> removeProperty(String id);
  Future<Either<IFailure, PropertyModel>> getProperty(String id);
  Future<Either<IFailure, ReviewModel>> commentOnProperty(
      int propertyId, String comment);
}
