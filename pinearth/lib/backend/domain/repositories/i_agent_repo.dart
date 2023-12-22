
import 'package:dartz/dartz.dart';
import 'package:pinearth/backend/domain/models/core/failure.dart';
import 'package:pinearth/backend/domain/models/entities/agent_model.dart';

abstract class IAgentRepo {
  Future<Either<IFailure, List<AgentModel>>> getOrSearchAgents([String searchParam = ""]);
  Future<Either<IFailure, List<AgentModel>>> getOrSearchLandlord([String searchParam = ""]);
  Future<Either<IFailure, List<AgentModel>>> getOrSearchDeveloper([String searchParam = ""]);
  Future<Either<IFailure, List<AgentModel>>> getOrSearchHotel([String searchParam = ""]);
  Future<Either<IFailure, List<AgentModel>>> getOrSearchBank([String searchParam = ""]);
  Future<Either<IFailure, List<AgentModel>>> getOrSearchShortLet([String searchParam = ""]);
  
  Future<Either<IFailure, dynamic>> getAgentPropertyes(String agentId);
}