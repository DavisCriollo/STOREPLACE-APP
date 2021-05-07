// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.id,
        this.nombres,
        this.cedula,
        this.celular,
        this.email,
        this.codigo,
        this.rol,
        this.password,
    });

    String id;
    String nombres;
    String cedula;
    String celular;
    String email;
    String codigo;
    String rol;
    String password;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        nombres:  (json["nombres"]==null)?'No data':json["nombres"],
        cedula:  (json["cedula"]==null)?'No data':json["cedula"],
        email:  (json["email"]==null)?'No data':json["email"],
        celular:  (json["celular"]==null)?'No data':json["celular"],
        codigo:  (json["codigo"]==null)?'No data':json["codigo"],
        rol:  (json["rol"]==null)?'No data':json["rol"],
        password: (json["password"]==null)?'No data':json["password"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombres": nombres,
        "cedula": cedula,
        "email": email,
        "celular": celular,
        "codigo": codigo,
        "rol": rol,
        "password": password,
    };
}
