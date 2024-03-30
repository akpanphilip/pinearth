class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String? lastName;
  final String? middleName;
  final DateTime? dOB;
  final bool? hasRole;
  final String? role;
  Profile? profile;
  Tokens? tokens;
  final bool googleUser;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    this.lastName,
    this.middleName,
    this.dOB,
    this.hasRole,
    this.role,
    this.profile,
    this.tokens,
    this.googleUser = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      hasRole: json["has_role"],
      role: json["role"] ?? "",
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      middleName: json["middle_name"],
      dOB: (json["d_o_b"] == null) ? null : DateTime.parse(json["d_o_b"]),
      profile:
          json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      tokens: json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null,
      googleUser: json["google_user"] ?? false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "has_role": hasRole,
        "role": role,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "d_o_b": (dOB == null)
            ? null
            : "${dOB?.year.toString().padLeft(4, '0')}-${dOB?.month.toString().padLeft(2, '0')}-${dOB?.day.toString().padLeft(2, '0')}",
        "profile": profile?.toJson(),
        "tokens": tokens?.toJson(),
        "google_user": googleUser,
      };
}

class Profile {
  final dynamic avatar;
  final String? phoneNo;
  final String? address;
  final String? uploadId;

  Profile({
    this.avatar,
    this.phoneNo,
    this.address,
    this.uploadId,
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

class Tokens {
  String? refresh;
  String? access;

  Tokens({this.refresh, this.access});

  Tokens.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    return data;
  }
}
