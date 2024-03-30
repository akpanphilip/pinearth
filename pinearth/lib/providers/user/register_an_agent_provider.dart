import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/models/core/failure.dart';
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/auth/login_screen.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/screens/registration/register_as_agent/registration_complete_screen.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class RegisterAsAgentProvider extends BaseProvider {
  final IUserRepo userRepo;
  final IAlertInteraction alert;
  final ProfileProvider profileProvider;

  bool isEdit = false;

  void setIsEdit(bool edit) {
    isEdit = edit;
    if (isEdit == true) {
      if (agentType == bankAgentType) {
        // nameController.text = profileProvider.profileState.data!.;
      } else {
        final agentProfile = profileProvider.agentProfileState.data!;
        print("AgentProfile $agentProfile");
        nameController.text = agentProfile['name'] ?? '';
        emailAddressController.text = agentProfile['email'] ?? '';
        companyNameController.text = agentProfile['company_name'] ?? '';
        companyRegNoController.text = agentProfile['company_reg'] ?? '';
        phoneNumberController.text = agentProfile['phone_no'] ?? '';
        addressController.text = agentProfile['address'] ?? '';
        websiteController.text = agentProfile['website'] ?? '';
        aboutController.text = agentProfile['about_you'] ?? '';
        specialityController.text = agentProfile['specialties'] ?? '';
        professionalProfilePhoto =
            [null, ''].contains(agentProfile['profile_photo'])
                ? []
                : [agentProfile['profile_photo']];
        idCard = [null, ''].contains(agentProfile['upload_id'])
            ? []
            : [agentProfile['upload_id']];
        companyId = [null, ''].contains(agentProfile['company_id'])
            ? []
            : [agentProfile['company_id']];
        // companyId =
      }
    }
    notifyListeners();
  }

  RegisterAsAgentProvider(
    this.userRepo,
    this.alert,
    this.profileProvider,
  );

  List<String> professionalProfilePhoto = [];
  List<String> companyId = [];
  List<String> idCard = [];
  List<String> eventCenterImages = [];

  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final specialityController = TextEditingController();
  final aboutController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final hallCapacityController = TextEditingController();
  final parkingSpaceController = TextEditingController();
  final websiteController = TextEditingController();
  final companyIdController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyRegNoController = TextEditingController();
  final pricePerDayController = TextEditingController();
  final propertyAddressController = TextEditingController();
  final additionalServices = TextEditingController();
  final appliancesController = TextEditingController();

  String agentType = "Agent";
  String hasSecurity = "No";
  String selectedState = "Rivers state";

  set updateSelectedState(String state) {
    selectedState = state;
    notifyListeners();
  }

  set updateHasSecurityStatus(String status) {
    hasSecurity = status;
    notifyListeners();
  }

  void selectProfessionalPictures({bool allowMultiple = true}) async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: allowMultiple, type: FileType.image);
    if (res != null) {
      professionalProfilePhoto = res.files.map((e) => e.path!).toList();
      notifyListeners();
    }
  }

  void selectCompanyId() async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (res != null) {
      companyId = res.files.map((e) => e.path!).toList();
      notifyListeners();
    }
  }

  void selectIdCard() async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (res != null) {
      idCard = res.files.map((e) => e.path!).toList();
      notifyListeners();
    }
  }

  void selectEventCenter() async {
    final res = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (res != null) {
      eventCenterImages = res.files.map((e) => e.path!).toList();
      notifyListeners();
    }
  }

  void register(BuildContext context, {String? id}) async {
    try {
      alert.showLoadingAlert('');
      String type = '';
      if (agentType == agentAgentType) {
        type = "an agent";
      }
      if (agentType == landlordAgentType) {
        type = "a landlord";
      }
      if (agentType == developerAgentType) {
        type = "a developer";
      }
      if (agentType == bankAgentType) {
        type = "a bank";
      }
      if (agentType == hotelAgentType) {
        type = "a hotel";
      }
      if (agentType == eventCenterAgentType) {
        type = "an event center";
      }
      if (agentType == shortletAgentType) {
        type = "a short-let";
      }

      final profile = profileProvider.profileState.data;
      Either<IFailure, bool> res;

      if (isEdit) {
        final agentProfile = profileProvider.agentProfileState.data;
        res = await userRepo.agentProfileUpdate(
            id ?? agentProfile['id'].toString(),
            type,
            id ?? profile!.id.toString(),
            FormData.fromMap({
              'name': nameController.text,
              'iname': "",
              'about_you': aboutController.text,
              'specialties': specialityController.text,
              'email': emailAddressController.text,
              'phone_no': phoneNumberController.text.addCountryCode,
              'address': addressController.text,
              'website': websiteController.text.isEmpty
                  ? null
                  : websiteController.text.addHttp(),
              'profile_photo': professionalProfilePhoto.first.startsWith('http')
                  ? null
                  : await MultipartFile.fromFile(
                      professionalProfilePhoto.first),
              'company_id': companyId.first.startsWith('http')
                  ? null
                  : await MultipartFile.fromFile(companyId.first),
              'company_reg': companyRegNoController.text,
              'company_name': companyNameController.text,
              'state': stateController.text,
              'hall_capacity': hallCapacityController.text,
              'is_security': hasSecurity,
              'additional_services': additionalServices.text,
              'price_per_day': pricePerDayController.text,
              'id_upload': idCard.isNotEmpty
                  ? idCard.first.startsWith('http')
                      ? null
                      : await MultipartFile.fromFile(idCard.first)
                  : null,
            }));
      } else {
        res = await userRepo.agentRegistration(
            type,
            profile!.id.toString(),
            FormData.fromMap({
              'name': nameController.text,
              'about_you': aboutController.text,
              'iname': "s",
              'specialties': specialityController.text,
              'email': emailAddressController.text,
              'phone_no': phoneNumberController.text.addCountryCode,
              'address':
                  addressController.text.isEmpty ? "" : addressController.text,
              'website': websiteController.text.isEmpty
                  ? null
                  : websiteController.text.addHttp(),
              'profile_photo':
                  await MultipartFile.fromFile(professionalProfilePhoto.first),
              'company_id': companyId.isEmpty
                  ? null
                  : companyId.first.startsWith('http')
                      ? null
                      : await MultipartFile.fromFile(companyId.first),
              'company_reg': companyRegNoController.text,
              'company_name': nameController.text, //companyNameController.text
              'state': selectedState,
              'id_upload': idCard.isNotEmpty
                  ? await MultipartFile.fromFile(idCard.first)
                  : null,
              'hall_capacity': hallCapacityController.text,
              'is_security': hasSecurity,
              'additional_services': additionalServices.text,
              'price_per_day': pricePerDayController.text,
            }));
      }
      alert.closeAlert();
      res.fold((l) {
        if (l.message.toLowerCase().contains('unauthorized')) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        } else {
          alert.showErrorAlert(l.message);
        }
      }, (r) {
        profileProvider.initialize(context, failSilently: true);
        alert.showSuccessAlert(
            isEdit ? 'Update successful' : 'Registration successful');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const AgentRegistrationCompleteScreen()),
            (r) => false);
        // clear();
      });
    } catch (error) {
      alert.closeAlert();
      alert.showErrorAlert("Error: $error");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
      rethrow;
    }
  }

  void clear() {
    professionalProfilePhoto = [];
    nameController.clear();
    aboutController.clear();
    specialityController.clear();
    emailAddressController.clear();
    phoneNumberController.clear();
    addressController.clear();
    websiteController.clear();
    companyIdController.clear();
    companyNameController.clear();
    companyRegNoController.clear();
    idCard = [];
    isEdit = false;
    notifyListeners();
  }
}

final registerAsAgentProvider =
    ChangeNotifierProvider((ref) => RegisterAsAgentProvider(
          getIt<IUserRepo>(),
          getIt<IAlertInteraction>(),
          ref.read(profileProvider),
        ));
