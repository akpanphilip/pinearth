// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? password;
  final String? password2;
  final DateTime? dOB;
  final String? address;
  final String? uploadId;
  // final String? givenName;
  // final String? familyName;
  // final String? profilePicture;

  RegisterRequest({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.password2,
    this.middleName,
    this.dOB,
    this.address,
    this.uploadId,
    // this.givenName,
    // this.familyName,
    // this.profilePicture,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        password: json["password"],
        password2: json["password2"],
        dOB: DateTime.parse(json["d_o_b"]),
        address: json["address"],
        uploadId: json["upload_id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "password": password,
        "password2": password2,
          "d_o_b":
              "${dOB?.year.toString().padLeft(4, '0')}-${dOB?.month.toString().padLeft(2, '0')}-${dOB?.day.toString().padLeft(2, '0')}",
        "address": address,
        "upload_id": uploadId,
        // "given_name": givenName,
        // "family_name": familyName,
        // "profile_picture": profilePicture,
      };
}

class Profile {
  final String address;
  final String uploadId;

  Profile({
    required this.address,
    required this.uploadId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        address: json["address"],
        uploadId: json["upload_id"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "upload_id": uploadId,
      };
}
