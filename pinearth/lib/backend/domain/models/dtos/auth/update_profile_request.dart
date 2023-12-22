
class UpdateProfileRequest {
    final String email;
    final String firstName;
    final String lastName;
    final String middleName;
    final String address;

    UpdateProfileRequest({
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.middleName,
        required this.address,
    });

    factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) => UpdateProfileRequest(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "address": address,
    };
}

class Profile {
    final String address;

    Profile({
        required this.address,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        address: json["address"]
    );

    Map<String, dynamic> toJson() => {
        "address": address
    };
}
