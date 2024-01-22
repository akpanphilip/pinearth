import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/backend/domain/repositories/i_property_repo.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';

import '../../backend/domain/models/entities/user_model.dart';

class PropertyListProvider extends ChangeNotifier {
  final IPropertyRepo propertyRepo;

  PropertyListProvider(this.propertyRepo) {
    searchParamController.addListener(() {
      final searchparam = searchParamController.text.toLowerCase();
      if (searchparam.isEmpty) {
        loadProperties();
      } else {
        Future.delayed(
            const Duration(milliseconds: 500), () => searchProperties());
      }
    });
  }

  final searchParamController = TextEditingController();
  final propertyListState = ProviderActionState<List<PropertyModel>>();
  final propertyDetailState = ProviderActionState<PropertyModel>();

  void loadProperties() async {
    try {
      propertyListState.toLoading();
      notifyListeners();
      final res = await propertyRepo.properties();
      res.fold((l) {
        propertyListState.toError(l.message);
        notifyListeners();
      }, (r) {
        propertyListState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      print("error fetching property $error");
      propertyListState.toError("Error: $error");
      notifyListeners();
      rethrow;
    }
  }

  void loadPropertyDetail(String id) async {
    try {
      propertyDetailState.toLoading();
      notifyListeners();
      final res = await propertyRepo.getProperty(id);
      res.fold((l) {
        propertyDetailState.toError(l.message);
        notifyListeners();
      }, (r) {
        propertyDetailState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      propertyDetailState.toError("Unable to get property detail");
      notifyListeners();
    }
  }

  void searchProperties() async {
    try {
      propertyListState.toLoading();
      notifyListeners();
      final res = await propertyRepo.searchProperties(
          address: searchParamController.text.toLowerCase(),
          propertyPrice: searchParamController.text.toLowerCase(),
          propertyStatus: searchParamController.text.toLowerCase(),
          propertyType: searchParamController.text.toLowerCase());
      res.fold((l) {
        propertyListState.toError(l.message);
        notifyListeners();
      }, (r) {
        propertyListState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      propertyListState.toError("Error: $error");
      notifyListeners();
    }
  }
}

final propertyListProvider =
    ChangeNotifierProvider<PropertyListProvider>((ref) {
  return PropertyListProvider(getIt<IPropertyRepo>());
});
