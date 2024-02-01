import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/repositories/i_property_repo.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/screens/auth/login_screen.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';

class MyPropertyListingProvider extends BaseProvider {
  final IPropertyRepo propertyRepo;
  final IAlertInteraction alert;

  MyPropertyListingProvider(this.propertyRepo, this.alert) {
    initialize();
  }

  final myListingState = ProviderActionState<List<PropertyModel>>();
  final savedPropertyState = ProviderActionState<List<PropertyModel>>();

  void initialize() async {
    try {
      myListingState.toLoading();
      notifyListeners();

      final res = await propertyRepo.myProperties();

      res.fold((l) {
        myListingState.toError("Error: ${l.message}");
        notifyListeners();
      }, (r) {
        myListingState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      myListingState.toError("Error: $error");
      notifyListeners();
    }
  }

  Future<void> getSavedProperties() async {
    try {
      savedPropertyState.toLoading();
      notifyListeners();
      final res = await propertyRepo.savedProperties();
      res.fold((l) {
        savedPropertyState.toError("Error: ${l.message}");
        notifyListeners();
      }, (r) {
        savedPropertyState.toSuccess(r);
        notifyListeners();
      });
    } catch (error) {
      savedPropertyState.toError("Error: $error");
      notifyListeners();
    }
  }

  void togglePropertyAvailability(String id, bool available) async {
    try {
      alert.showLoadingAlert("");
      final res = await propertyRepo.changePropertyAvailability(id, available);
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert(l.message);
      }, (r) {
        alert.showSuccessAlert("Property availability changed");
        initialize();
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Unable to change property availability");
    }
  }

  void saveProperty(String id) async {
    try {
      alert.showLoadingAlert("");
      final res = await propertyRepo.saveProperty(id);
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert(l.message);
      }, (r) {
        alert.showSuccessAlert("Property saved successfully");
        getSavedProperties();
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Unable to change property availability");
    }
  }

  void unSaveProperty(String id) async {
    try {
      alert.showLoadingAlert("");
      final res = await propertyRepo.unSaveProperty(id);
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert(l.message);
      }, (r) {
        alert.showSuccessAlert("Property removed from saved successfully");
        getSavedProperties();
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Unable to change property availability");
    }
  }

  bool isSaved(String id) {
    return (savedPropertyState.data ?? [])
        .where((element) => element.id.toString() == id)
        .isNotEmpty;
  }
}

final myPropertyListingProvider = ChangeNotifierProvider.autoDispose((ref) {
  return MyPropertyListingProvider(
      getIt<IPropertyRepo>(), getIt<IAlertInteraction>());
});
