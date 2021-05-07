// To parse this JSON data, do
//
//     final registerUsuario = registerUsuarioFromJson(jsonString);

import 'dart:convert';

RegisterUser registerUsuarioFromJson(String str) => RegisterUser.fromJson(json.decode(str));

String registerUsuarioToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
    RegisterUser({
        this.token,
        this.rol,
        this.id,
    });

    String token;
    String rol;
    String id;

    factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
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
