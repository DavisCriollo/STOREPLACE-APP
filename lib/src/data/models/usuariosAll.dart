// To parse this JSON data, do
//
//     final usuariosAll = usuariosAllFromJson(jsonString);

import 'dart:convert';

UsuariosAll usuariosAllFromJson(String str) => UsuariosAll.fromJson(json.decode(str));

String usuariosAllToJson(UsuariosAll data) => json.encode(data.toJson());

class UsuariosAll {
    UsuariosAll({
        this.usuarios,
    });

    List<UsuarioAll> usuarios;

    factory UsuariosAll.fromJson(Map<String, dynamic> json) => UsuariosAll(
        usuarios: List<UsuarioAll>.from(json["usuarios"].map((x) => UsuarioAll.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}

class UsuarioAll {
    UsuarioAll({
        this.id,
        this.cedula,
        this.nombres,
        this.celular,
        this.email,
        this.codigo,
        this.rol,
        this.password,
    });

    String id;
    String cedula;
    String nombres;
    String celular;
    String email;
    String codigo;
    String rol;
    String password;

    factory UsuarioAll.fromJson(Map<String, dynamic> json) => UsuarioAll(
        id: json["_id"],
        cedula: (json["cedula"]==null)?'No data':json["cedula"],
        nombres: (json["nombres"]==null)?'No data':json["nombres"],
        celular: (json["celular"]==null)?'No data':json["celular"],
        email: (json["email"]==null)?'No data':json["email"],
        codigo: (json["codigo"]==null)?'No data':json["codigo"],
        rol: (json["rol"]==null)?'No data':json["rol"],
        password: (json["password"]==null)?'No data':json["password"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "cedula": cedula,
        "nombres": nombres,
        "celular": celular,
        "email": email,
        "codigo": codigo,
        "rol": rol,
        "password": password,
    };
}
