// To parse this JSON data, do
//
//     final agentModel = agentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:pinearth/backend/domain/models/entities/user_model.dart';

AgentModel agentModelFromJson(String str) => AgentModel.fromJson(json.decode(str));

String agentModelToJson(AgentModel data) => json.encode(data.toJson());

class AgentModel {
    final int id;
    final String? name;
    final String companyName;
    final String companyId;
    final String companyReg;
    final UserModel user;
    final String profilePhoto;
    final String aboutYou;
    final String specialties;
    final String email;
    final String phoneNo;
    final List<dynamic> property;
    final String address;
    final String website;
    final List<dynamic> review;

    AgentModel({
        required this.id,
        required this.name,
        required this.companyId,
        required this.companyName,
        required this.companyReg,
        required this.user,
        required this.profilePhoto,
        required this.aboutYou,
        required this.specialties,
        required this.email,
        required this.phoneNo,
        required this.property,
        required this.address,
        required this.website,
        required this.review,
    });

    factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
        id: json["id"],
        name: json["name"],
        companyId: json["company_id"] ?? "",
        companyName: json["company_name"] ?? "",
        companyReg: json["company_reg"] ?? "",
        user: UserModel.fromJson(json["user"]),
        profilePhoto: json["profile_photo"],
        aboutYou: json["about_you"],
        specialties: json["specialties"] ?? "",
        email: json["email"] ?? "",
        phoneNo: json["phone_no"],
        property: List<dynamic>.from((json["property"] ?? []).map((x) => x)),
        address: json["address"],
        website: json["website"] ?? "",
        review: List<dynamic>.from(json["review"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "company_name": companyName,
        "company_id": companyId,
        "company_reg": companyReg,
        "user": user.toJson(),
        "profile_photo": profilePhoto,
        "about_you": aboutYou,
        "specialties": specialties,
        "email": email,
        "phone_no": phoneNo,
        "property": List<dynamic>.from(property.map((x) => x)),
        "address": address,
        "website": website,
        "review": List<dynamic>.from(review.map((x) => x)),
    };
}
