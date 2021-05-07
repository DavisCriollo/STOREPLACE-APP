// To parse this JSON data, do
//
//     final searchUsuarios = searchUsuariosFromJson(jsonString);

import 'dart:convert';

SearchUsuarios searchUsuariosFromJson(String str) => SearchUsuarios.fromJson(json.decode(str));

String searchUsuariosToJson(SearchUsuarios data) => json.encode(data.toJson());

class SearchUsuarios {
    SearchUsuarios({
        this.usuarios,
    });

    List<UsuarioSearch> usuarios;

    factory SearchUsuarios.fromJson(Map<String, dynamic> json) => SearchUsuarios(
        usuarios: List<UsuarioSearch>.from(json["usuarios"].map((x) => UsuarioSearch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}

class UsuarioSearch {
    UsuarioSearch({
        this.id,
        this.nombres,
        this.cedula,
        this.celular,
        this.email,
        this.codigo,
        this.rol,
        this.password,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    String nombres;
    String cedula;
    String celular;
    String email;
    String codigo;
    String rol;
    String password;
    DateTime createdAt;
    DateTime updatedAt;

    factory UsuarioSearch.fromJson(Map<String, dynamic> json) => UsuarioSearch(
        id: json["_id"],
        nombres: json["nombres"],
        cedula: json["cedula"],
        celular: json["celular"],
        email: json["email"],
        codigo: json["codigo"],
        rol: json["rol"],
        password: json["password"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombres": nombres,
        "cedula": cedula,
        "celular": celular,
        "email": email,
        "codigo": codigo,
        "rol": rol,
        "password": password,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
