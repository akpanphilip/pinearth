
class UserSearchResultModel {
    final int id;
    final String email;
    final String firstName;
    final String lastName;
    final dynamic middleName;
    final bool hasRole;
    final String role;
    final Profile? profile;

    UserSearchResultModel({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.middleName,
        required this.hasRole,
        required this.role,
        required this.profile,
    });

    factory UserSearchResultModel.fromJson(Map<String, dynamic> json) => UserSearchResultModel(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        hasRole: json["has_role"],
        role: json["role"] ?? "",
        profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "has_role": hasRole,
        "role": role,
        "profile": profile?.toJson(),
    };
}

class Profile {
    final String avatar;
    final String phoneNo;
    final String address;
    final String uploadId;

    Profile({
        required this.avatar,
        required this.phoneNo,
        required this.address,
        required this.uploadId,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        avatar: json["avatar"] ?? "",
        phoneNo: json["phone_no"],
        address: json["address"],
        uploadId: json["upload_id"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "phone_no": phoneNo,
        "address": address,
        "upload_id": uploadId,
    };
}
