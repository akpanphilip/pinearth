
class NotificationModel {
    final int id;
    final String role;
    final String name;
    final String text;

    NotificationModel({
        required this.id,
        required this.role,
        required this.name,
        required this.text,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        role: json["role"],
        name: json["name"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "name": name,
        "text": text,
    };
}
