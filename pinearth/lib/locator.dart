
import 'package:get_it/get_it.dart';
import 'package:pinearth/backend/application/repositories/api/repository_impl/api.agent.repo.dart';
import 'package:pinearth/backend/application/repositories/api/repository_impl/api.properties.repo.dart';
import 'package:pinearth/backend/application/repositories/api/repository_impl/api.user.repo.dart';
import 'package:pinearth/backend/application/repositories/api/services/dio.api.service.dart';
import 'package:pinearth/backend/application/repositories/api/services/i_api.service.dart';
import 'package:pinearth/backend/application/servicies/localstorage/hive.local_storage.service.dart';
import 'package:pinearth/backend/domain/repositories/i_agent_repo.dart';
import 'package:pinearth/backend/domain/repositories/i_property_repo.dart';
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:pinearth/backend/domain/services/i_local_storage_service.dart';
import 'package:pinearth/screens/feedback_alert/bot_toast_feedback_alert.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';

final getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerSingleton<ILocalStorageService>(HiveLocalStorageService());
  getIt.registerSingleton<IAlertInteraction>(BotToastAlert());

  getIt.registerSingleton<IApiService>(DioApiService(
    getIt()
  ));
  getIt.registerSingleton<IUserRepo>(ApiUserRepo(
    getIt()
  ));
  getIt.registerSingleton<IPropertyRepo>(ApiPropertyRepo(
    getIt()
  ));
  getIt.registerSingleton<IAgentRepo>(ApiAgentRepo(
    getIt()
  ));
}