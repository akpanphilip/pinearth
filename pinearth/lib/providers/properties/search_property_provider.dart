import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/backend/domain/repositories/i_property_repo.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';

class SearchPropertyProvider extends BaseProvider {
  final IPropertyRepo propertyRepo;

  SearchPropertyProvider(this.propertyRepo) {
    searchParamController.addListener(() {
      if (searchTimer != null) searchTimer!.cancel();
      final searchParam = searchParamController.text;
      if (searchParam.isNotEmpty && searchParam != lastText) {
        lastText = searchParam;
        searchTimer =
            Timer(const Duration(milliseconds: 500), () => searchProperty());
      }
    });
  }

  final searchParamController = TextEditingController();
  String lastText = "";
  String propertyStatus = "";
  String propertyType = "";
  Timer? searchTimer;
  final allPropertySearchResult = ProviderActionState<List<PropertyModel>>();

  set updatePropertyStatus(String status) {
    propertyStatus = status;
    notifyListeners();
  }
  
  set updatePropertyType(String type) {
    propertyType = type;
    notifyListeners();
  }

  Future<void> searchProperty() async {
    try {
      allPropertySearchResult.toLoading();
      notifyListeners();

      // await Future.delayed(Duration(seconds: 10), () {
      //   allPropertySearchResult.toSuccess([]);
      //   notifyListeners();
      // });

      // return;
      final res = await propertyRepo.searchProperties(
          address: searchParamController.text,
          propertyPrice: searchParamController.text,
          state: searchParamController.text,
          propertyStatus: (propertyStatus == "All") ? "" : propertyStatus,
          propertyType: propertyType);
      res.fold((l) {
        allPropertySearchResult.toError(l.message);
        notifyListeners();
      }, (r) {
        allPropertySearchResult.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      print("error \t\t $error");
      allPropertySearchResult.toError("Error: $error");
      notifyListeners();
    }
  }
}

final searchPropertyProvider = ChangeNotifierProvider.autoDispose((ref) {
  return SearchPropertyProvider(getIt<IPropertyRepo>());
});
