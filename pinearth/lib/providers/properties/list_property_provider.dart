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

  String listingOption = "sale";
  String rentDuration = "month";
  String? hasALivingRoom;
  String? hasWifi = "yes";
  final propertyNameController = TextEditingController();
  final propertyPriceController = TextEditingController();
  final propertyDescriptionController = TextEditingController();
  List<String> propertyImages = [];
  List<String> livingRoomImages = [];
  List<String> bedRoomImages = [];
  List<String> toiletImages = [];
  List<String> kitchenImages = [];
  List<String> appliances = [];
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
  final appliancesController = TextEditingController();
  List<String> documentFiles = [];
  List<String> housePlanImages = [];
  List<String> propertySizeImages = [];
  UserSearchResultModel? owner;
  String selectedState = "Rivers state";

  set updateSelectedState(String state) {
    selectedState = state;
    notifyListeners();
  }

  void reset() {
    selectedState = "Rivers state";
    propertyImages = [];
    livingRoomImages = [];
    toiletImages = [];
    bedRoomImages = [];
    kitchenImages = [];
    appliances = [];
    listingOption = "sale";
    rentDuration = "month";
    hasWifi = "yes";
    hasALivingRoom = null;
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

  void addAppliance(String appliance) {
    appliances.add(appliance);
    notifyListeners();
  }

  void removeAppliance(String appliance) {
    appliances.removeWhere(
      (element) => element == appliance,
    );
    notifyListeners();
  }

  void setHasWifi(String status) {
    hasWifi = status;
    notifyListeners();
  }

  void setHasALivingRoom(String status) {
    hasALivingRoom = status;
    notifyListeners();
  }

  void setRentDuration(String duration) {
    rentDuration = duration;
    notifyListeners();
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

  void selectPropertyDocuments({FileType fileType = FileType.any}) async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileType);
    if (res != null) {
      documentFiles = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }

  void selectHousePlanDocuments({FileType fileType = FileType.any}) async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileType);
    if (res != null) {
      housePlanImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }

  void selectPropertySize({FileType fileType = FileType.any}) async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileType);
    if (res != null) {
      propertySizeImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }

  void selectPropertyImages({FileType fileType = FileType.any}) async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileType);
    if (res != null) {
      propertyImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }

  void selectLivingRoomImages({FileType fileType = FileType.any}) async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileType);
    if (res != null) {
      livingRoomImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }

  void selectBedRoomImages({FileType fileType = FileType.any}) async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileType);
    if (res != null) {
      bedRoomImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }

  void selectToiletImages({FileType fileType = FileType.any}) async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileType);
    if (res != null) {
      toiletImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }

  void selectKitchenImages({FileType fileType = FileType.any}) async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileType);
    if (res != null) {
      kitchenImages = res.files.map((e) => (e.path!)).toList();
      notifyListeners();
    }
  }

  void listProperty(BuildContext context) async {
    // final profile = profileProvider.profileState.data!;
    // //TODO check this code properly to see if commenting it out breaks the app.
    // // String status = "Sale";
    // // if (profile.role == "Landlord") {
    // //   status = "Rent";
    // // }

    // String status = listingOption;

    // return;

    try {
      alert.showLoadingAlert("");
      final profile = profileProvider.profileState.data!;

      // String status = "Sale";
      // if (profile.role == "Landlord") {
      //   status = "Rent";
      // }

      String status = listingOption;

      print("listing property");

      final res = await propertyRepo.listProperty(FormData.fromMap({
        "state": selectedState,
        'title': propertyNameController.text,
        'desc': propertyDescriptionController.text,
        'property_type': propertyTypeController.text,
        'no_of_rooms': numberOfRoomsController.text,
        'no_of_bathrooms': numberOfBathroomController.text,
        'lot_size': propertyLotSizeController.text,
        'address': propertyAddressController.text,
        'duration': rentDuration,
        'property_status': "For $status",
        'property_price': propertyPriceController.text,
        'income_per_month': propertyIncomePerYearController.text,
        'years_built': propertyYearBuiltController.text,
        'years_renovated': propertyYearRenovatedController.text,
        'years_reconstructed': propertyYearReconstructedController.text,
        'parking_space': propertyHasPackingSpaceController.text,
        'appliance': propertyHasAppliancesController.text,
        'location': propertyGoogleMapController.text.addHttp(),
        'role': profile.role?.toLowerCase(),
        'available': true,
        'uappliances': appliancesController.text.trim() == ""
            ? ["none"]
            : appliancesController.text.split(","),
        'uhouse_view': await Future.wait(
            propertyImages.map((e) async => await MultipartFile.fromFile(e))),
        'uliving_room': await Future.wait(
            livingRoomImages.map((e) async => await MultipartFile.fromFile(e))),
        'ubed_room': await Future.wait(
            bedRoomImages.map((e) async => await MultipartFile.fromFile(e))),
        'utoilet': await Future.wait(
            toiletImages.map((e) async => await MultipartFile.fromFile(e))),
        'ukitchen': await Future.wait(
            kitchenImages.map((e) async => await MultipartFile.fromFile(e))),
        'udocuments': await Future.wait(
            documentFiles.map((e) async => await MultipartFile.fromFile(e))),
        'uhouse_plan': await Future.wait(
            housePlanImages.map((e) async => await MultipartFile.fromFile(e))),
        'usize': await Future.wait(propertySizeImages
            .map((e) async => await MultipartFile.fromFile(e))),
        'owner_name':
            owner == null ? "" : "${owner!.firstName} ${owner!.lastName}",
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
  return ListPropertyProvider(getIt<IAlertInteraction>(),
      getIt<IPropertyRepo>(), ref.watch(profileProvider));
});
