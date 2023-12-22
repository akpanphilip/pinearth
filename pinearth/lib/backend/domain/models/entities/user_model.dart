class UserModel {
    final int id;
    final String email;
    final String firstName;
    final String lastName;
    final String middleName;
    final DateTime dOB;
    final bool hasRole;
    final String role;
    Profile? profile;

    UserModel({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.middleName,
        required this.dOB,
        required this.hasRole,
        required this.role,
        this.profile,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        hasRole: json["has_role"],
        role: json["role"] ?? "",
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        dOB: DateTime.parse(json["d_o_b"]),
        profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "has_role": hasRole,
        "role": role,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "d_o_b": "${dOB.year.toString().padLeft(4, '0')}-${dOB.month.toString().padLeft(2, '0')}-${dOB.day.toString().padLeft(2, '0')}",
        "profile": profile?.toJson(),
    };
}

class Profile {
    final dynamic avatar;
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
        phoneNo: json["phone_no"] ?? "",
        address: json["address"] ?? "",
        uploadId: json["upload_id"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "phone_no": phoneNo,
        "address": address,
        "upload_id": uploadId,
    };
}