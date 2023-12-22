
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/models/entities/user_search_result_model.dart';
import 'package:pinearth/backend/domain/repositories/i_property_repo.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:dio/dio.dart';
import 'package:pinearth/screens/list_property/listed_complete_screen.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class ListPropertyProvider extends BaseProvider {
  final IAlertInteraction alert;
  final IPropertyRepo propertyRepo;
  final ProfileProvider profileProvider;
  ListPropertyProvider(this.alert, this.propertyRepo, this.profileProvider);
  

  String listingOption = "";
  final propertyNameController = TextEditingController();
  final propertyPriceController = TextEditingController();
  final propertyDescriptionController = TextEditingController();
  List<String> propertyImages = [];
  List<String> livingRoomImages = [];
  List<String> bedRoomImages = [];
  List<String> toiletImages = [];
  List<String> kitchenImages = [];
  final propertyTypeController = TextEditingController();
  final numberOfRoomsController = TextEditingController();
  final numberOfBathroomController = TextEditingController();
  final propertyLotSizeController = TextEditingController();
  final propertyAddressController = TextEditingController();
  final propertyIncomePerYearController = TextEditingController();
  final propertyYearBuiltController = TextEditingController();
  final propertyYearRenovatedController = TextEditingController();
  final propertyYearReconstructedController = TextEditingController();
  final propertyHasPackingSpaceController = TextEditingController();
  final propertyHasAppliancesController = TextEditingController();
  final propertyGoogleMapController = TextEditingController();
  final ownerController = TextEditingController();
  List<String> documentFiles = [];
  List<String> housePlanImages = [];
  List<String> propertySizeImages = [];
  UserSearchResultModel? owner;

  void reset() {
    propertyImages = [];
    livingRoomImages = [];
    toiletImages = [];
    bedRoomImages = [];
    kitchenImages = [];
    listingOption = "";
    propertyNameController.clear();
    propertyPriceController.clear();
    propertyDescriptionController.clear();
    propertyAddressController.clear();
    propertyTypeController.clear();
    numberOfRoomsController.clear();
    numberOfBathroomController.clear();
    propertyLotSizeController.clear();
    propertyIncomePerYearController.clear();
    propertyYearBuiltController.clear();
    propertyYearRenovatedController.clear();
    propertyYearReconstructedController.clear();
    propertyHasPackingSpaceController.clear();
    propertyHasAppliancesController.clear();
    propertyGoogleMapController.clear();
    ownerController.clear();
    documentFiles = [];
    housePlanImages = [];
    propertySizeImages = [];
    owner = null;
  }

  void setLisingOption(String option) {
    listingOption = option;
    notifyListeners();
  }
  void setOwner(UserSearchResultModel selectedUser) async {
    owner = selectedUser;
    ownerController.text = "${selectedUser.firstName} ${selectedUser.lastName}";
    notifyListeners();
  }
  void selectPropertyDocuments() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (res != null) {
      documentFiles = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }
  void selectHousePlanDocuments() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (res != null) {
      housePlanImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }
  void selectPropertySize() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (res != null) {
      propertySizeImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }
  void selectPropertyImages() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (res != null) {
      propertyImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }
  void selectLivingRoomImages() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (res != null) {
      livingRoomImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }
  void selectBedRoomImages() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (res != null) {
      bedRoomImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }
  void selectToiletImages() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (res != null) {
      toiletImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }
  void selectKitchenImages() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (res != null) {
      kitchenImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }

  void listProperty(BuildContext context) async {
    try {
      alert.showLoadingAlert("");
      final profile = profileProvider.profileState.data!;
      String status = "Sale";
      if (profile.role == "Landlord") {
        status = "Rent";
      }
      final res = await propertyRepo.listProperty(FormData.fromMap({
        'title': propertyNameController.text,
        'desc': propertyDescriptionController.text,
        'property_type': propertyTypeController.text,
        'no_of_rooms': numberOfRoomsController.text,
        'no_of_bathrooms': numberOfBathroomController.text,
        'lot_size': propertyLotSizeController.text,
        'address': propertyAddressController.text,
        'property_status': "For $status",
        'property_price': propertyPriceController.text,
        'income_per_month': propertyIncomePerYearController.text,
        'years_built': propertyYearBuiltController.text,
        'years_renovated': propertyYearRenovatedController.text,
        'years_reconstructed': propertyYearReconstructedController.text,
        'parking_space': propertyHasPackingSpaceController.text,
        'appliance': propertyHasAppliancesController.text,
        'location': propertyGoogleMapController.text.addHttp(),
        'role': profile.role.toLowerCase(),
        'available': true,
        'uhouse_view': await Future.wait(propertyImages.map((e) async => await MultipartFile.fromFile(e))),
        'uliving_room': await Future.wait(livingRoomImages.map((e) async => await MultipartFile.fromFile(e))),
        'ubed_room': await Future.wait(bedRoomImages.map((e) async => await MultipartFile.fromFile(e))),
        'utoilet': await Future.wait(toiletImages.map((e) async => await MultipartFile.fromFile(e))),
        'ukitchen': await Future.wait(kitchenImages.map((e) async => await MultipartFile.fromFile(e))),
        'udocuments': await Future.wait(documentFiles.map((e) async => await MultipartFile.fromFile(e))),
        'uhouse_plan': await Future.wait(housePlanImages.map((e) async => await MultipartFile.fromFile(e))),
        'usize': await Future.wait(propertySizeImages.map((e) async => await MultipartFile.fromFile(e))),
        'owner_name': owner == null ? "" : "${owner!.firstName} ${owner!.lastName}",
        "owner_email": owner == null ? "" : "${owner!.email}",
      }));
      alert.closeAlert();
      res.fold((l) {
        alert.showErrorAlert(l.message);
      }, (r) {
        alert.showSuccessAlert("Property listed successfully");
        reset();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ListedComplete()),
        );
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Unable to list property");
    }
  }

}

final listPropertyProvider = ChangeNotifierProvider.autoDispose((ref) {
  return ListPropertyProvider(
    getIt<IAlertInteraction>(),
    getIt<IPropertyRepo>(),
    ref.watch(profileProvider)
  );
});