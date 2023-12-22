class LoginResponse {
    final String? email;
    final int? id;
    final String? firstName;
    final String? lastName;
    final String? middleName;
    final bool? hasRole;
    final String? role;
    final String? dOB;
    final Profile? profile;
    final Tokens? tokens;

    LoginResponse({
        this.email,
        this.id,
        this.firstName,
        this.lastName,
        this.hasRole,
        this.role,
        this.middleName,
        this.dOB,
        this.profile,
        this.tokens,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) {
      // print(json['tokens']);
      return LoginResponse(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        hasRole: json["has_role"],
        role: json["role"],
        middleName: json["middle_name"],
        dOB: json["d_o_b"],
        profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
      );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "has_role": hasRole,
        "middle_name": middleName,
        "d_o_b": dOB,
        "profile": profile?.toJson(),
        "tokens": tokens?.toJson(),
    };
}

class Profile {
    final String? avatar;
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
        avatar: json["avatar"],
        phoneNo: json["phone_no"],
        address: json["address"],
        uploadId: json["upload_id"],
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "phone_no": phoneNo,
        "address": address,
        "upload_id": uploadId,
    };
}

class Tokens {
    final String? access;
    final String? refresh;

    Tokens({
        this.access,
        this.refresh,
    });

    factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: json["access"],
        refresh: json["refresh"],
    );

    Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
    };
}
