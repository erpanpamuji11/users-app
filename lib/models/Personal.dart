import 'dart:convert';

Personal personalFromJson(String str) => Personal.fromJson(json.decode(str));

String personalToJson(Personal data) => json.encode(data.toJson());

class Personal {
    String name;
    String email;
    String avatar;
    String id;

    Personal({
        required this.name,
        required this.email,
        required this.avatar,
        required this.id,
    });

    factory Personal.fromJson(Map<String, dynamic> json) => Personal(
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "avatar": avatar,
        "id": id,
    };
}