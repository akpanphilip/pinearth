
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/backend/domain/repositories/i_property_repo.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';

class SearchPropertyProvider extends BaseProvider {
  final IPropertyRepo propertyRepo;

  SearchPropertyProvider(
    this.propertyRepo
  ) {
    searchParamController.addListener(() {
      if (searchTimer != null) searchTimer!.cancel();
      final searchParam = searchParamController.text;
      if (searchParam.isNotEmpty && searchParam != lastText) {
        lastText = searchParam;
        searchTimer = Timer(const Duration(milliseconds: 500), () => searchProperty());
      }
    });
  }

  final searchParamController = TextEditingController();
  String lastText = "";
  Timer? searchTimer;
  final allPropertySearchResult = ProviderActionState<List<PropertyModel>>();

  Future<void> searchProperty() async {
    try {
      allPropertySearchResult.toLoading();
      notifyListeners();
      final res = await propertyRepo.searchProperties(
        address: searchParamController.text,
        propertyPrice: searchParamController.text,
        propertyStatus: searchParamController.text,
        propertyType: searchParamController.text
      );
      res.fold((l) {
        allPropertySearchResult.toError(l.message);
        notifyListeners();
      }, (r) {
        allPropertySearchResult.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      allPropertySearchResult.toError("Error: $error");
      notifyListeners();
    }
  }

}

final searchPropertyProvider = ChangeNotifierProvider.autoDispose((ref) {
  return SearchPropertyProvider(
    getIt<IPropertyRepo>()
  );
});