class ScheduleVisitRequest {
    final String recipient;
    final String name;
    final String phoneNo;
    final String email;
    final String message;
    // final String role;

    ScheduleVisitRequest({
        required this.recipient,
        required this.name,
        required this.phoneNo,
        required this.email,
        required this.message,
        // required this.role,
    });

    factory ScheduleVisitRequest.fromJson(Map<String, dynamic> json) => ScheduleVisitRequest(
        recipient: json["recipient"],
        name: json["name"],
        phoneNo: json["phone_no"],
        email: json["email"],
        message: json["message"],
        // role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "recipient": recipient,
        "name": name,
        "phone_no": phoneNo,
        "email": email,
        "message": message,
        // "role": role,
    };
}
