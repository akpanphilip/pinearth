import 'package:dartz/dartz.dart';
import 'package:pinearth/backend/application/repositories/api/services/i_api.service.dart';
import 'package:pinearth/backend/domain/models/core/failure.dart';
import 'package:pinearth/backend/domain/models/entities/agent_model.dart';
import 'package:pinearth/backend/domain/repositories/i_agent_repo.dart';

class ApiAgentRepo implements IAgentRepo {
  final IApiService apiService;

  ApiAgentRepo(this.apiService);

  @override
  Future<Either<IFailure, List<AgentModel>>> getOrSearchAgents(
      [String searchParam = ""]) async {
    try {
      String url = "an agent/";
      if (searchParam.isNotEmpty) {
        url = "search_agent/?search=$searchParam";
      }
      final res = await apiService.get("/role/$url", requireToken: true);
      if (res.status == true) {
        return Right(
            List.from(res.data).map((e) => AgentModel.fromJson(e)).toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      // rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }

  @override
  Future<Either<IFailure, List<AgentModel>>> getOrSearchLandlord(
      [String searchParam = ""]) async {
    try {
      String url = "a landlord/";
      if (searchParam.isNotEmpty) {
        url = "search_landlord/?search=$searchParam";
      }
      final res = await apiService.get("/role/$url", requireToken: true);
      if (res.status == true) {
        return Right(
            List.from(res.data).map((e) => AgentModel.fromJson(e)).toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }

  @override
  Future<Either<IFailure, List<AgentModel>>> getOrSearchDeveloper(
      [String searchParam = ""]) async {
    try {
      String url = "a developer/";
      if (searchParam.isNotEmpty) {
        url = "search_developer/?search=$searchParam";
      }
      final res = await apiService.get("/role/$url", requireToken: true);
      if (res.status == true) {
        return Right(
            List.from(res.data).map((e) => AgentModel.fromJson(e)).toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }

  @override
  Future<Either<IFailure, List<AgentModel>>> getOrSearchHotel(
      [String searchParam = ""]) async {
    try {
      String url = "a hotel/";
      if (searchParam.isNotEmpty) {
        url = "search_hotel?search=$searchParam";
      }
      final res = await apiService.get("/role/$url", requireToken: true);
      if (res.status == true) {
        return Right(
            List.from(res.data).map((e) => AgentModel.fromJson(e)).toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }

  @override
  Future<Either<IFailure, List<AgentModel>>> getOrSearchBank(
      [String searchParam = ""]) async {
    try {
      String url = "a bank/";
      if (searchParam.isNotEmpty) {
        url = "search_hotel?search=$searchParam";
      }
      final res = await apiService.get("/role/$url", requireToken: true);
      if (res.status == true) {
        return Right(
            List.from(res.data).map((e) => AgentModel.fromJson(e)).toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }

  @override
  Future<Either<IFailure, List<AgentModel>>> getOrSearchShortLet(
      [String searchParam = ""]) async {
    try {
      String url = "a short-let/";
      if (searchParam.isNotEmpty) {
        url = "search_hotel?search=$searchParam";
      }
      final res = await apiService.get("/role/$url", requireToken: true);
      if (res.status == true) {
        return Right(
            List.from(res.data).map((e) => AgentModel.fromJson(e)).toList());
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      // rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }

  @override
  Future<Either<IFailure, dynamic>> getAgentPropertyes(
      String agentId, bool isADeveloper) async {
    try {
      final res = await apiService.get(
          "property/${(isADeveloper) ? "a developer" : "an agent/$agentId"}",
          requireToken: true);
      if (res.status == true) {
        return Right(res.data);
      }
      return Left(RepoFailure(res.message!));
    } catch (error) {
      // rethrow;
      return Left(RepoFailure('Error: $error'));
    }
  }
}
