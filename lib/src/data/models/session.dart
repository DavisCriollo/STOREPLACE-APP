// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

import 'dart:convert';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
    Session({
        this.token,
        this.rol,
        this.id,
    });

    String token;
    String rol;
    String id;

    factory Session.fromJson(Map<String, dynamic> json) => Session(
        token: json["token"],
        rol: json["rol"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "rol": rol,
        "id": id,
    };
}
