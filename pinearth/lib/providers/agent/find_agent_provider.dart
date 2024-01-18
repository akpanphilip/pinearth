
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/repositories/i_agent_repo.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';
import 'package:pinearth/utils/constants/app_constants.dart';

class FindAgentProvider extends BaseProvider {
  final IAgentRepo agentRepo;
  FindAgentProvider(this.agentRepo) {
    searchParamController.addListener(() {
      initialize();
    });
  }

  String agentType = "";

  final searchParamController = TextEditingController();
  final agentsState = ProviderActionState<List>();
  final featuredAgentsState = ProviderActionState<List>();

  void setAgentType(String type) {
    agentType = type;
    initialize();
  }

  void reset() {
    searchParamController.clear();
    notifyListeners();
  }

  void initialize() async {
    if (agentType == agentAgentType) {
      loadAgents();
    }
    if (agentType == landlordAgentType) {
      _loadLandLoord();
    }
    if (agentType == bankAgentType) {
      _loadBank();
    }
    if (agentType == developerAgentType) {
      _loadDevelopers();
    }
    if (agentType == hotelAgentType) {
      _loadHotel();
    }
  }

  void loadAgents() async {
    try {
      agentsState.toLoading();
      notifyListeners();
      final res = await agentRepo.getOrSearchAgents(searchParamController.text);
      res.fold((l) {
        agentsState.toError(l.message);
        notifyListeners();
      }, (r) {
        agentsState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      agentsState.toError("Error: Unable to load agents");
      notifyListeners();
      rethrow;
    }
  }
  void _loadLandLoord() async {
    try {
      agentsState.toLoading();
      notifyListeners();
      final res = await agentRepo.getOrSearchLandlord(searchParamController.text);
      res.fold((l) {
        agentsState.toError(l.message);
        notifyListeners();
      }, (r) {
        agentsState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      agentsState.toError("Error: Unable to load agents");
      notifyListeners();
      rethrow;
    }
  }
  void _loadDevelopers() async {
    try {
      agentsState.toLoading();
      notifyListeners();
      final res = await agentRepo.getOrSearchDeveloper(searchParamController.text);
      res.fold((l) {
        agentsState.toError(l.message);
        notifyListeners();
      }, (r) {
        agentsState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      agentsState.toError("Error: Unable to load agents");
      notifyListeners();
      rethrow;
    }
  }

  void _loadHotel() async {
    try {
      agentsState.toLoading();
      notifyListeners();
      final res = await agentRepo.getOrSearchHotel(searchParamController.text);
      res.fold((l) {
        agentsState.toError(l.message);
        notifyListeners();
      }, (r) {
        agentsState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      agentsState.toError("Error: Unable to load agents");
      notifyListeners();
      rethrow;
    }
  }
  void _loadBank() async {
    try {
      agentsState.toLoading();
      notifyListeners();
      final res = await agentRepo.getOrSearchBank(searchParamController.text);
      res.fold((l) {
        agentsState.toError(l.message);
        notifyListeners();
      }, (r) {
        agentsState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      agentsState.toError("Error: Unable to load agents");
      notifyListeners();
      rethrow;
    }
  }
}


final findAgentProvider = ChangeNotifierProvider.autoDispose((ref) => FindAgentProvider(
  getIt<IAgentRepo>()
));