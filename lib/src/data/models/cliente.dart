// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
    Cliente({
        this.id,
        this.cedula,
        this.nombres,
        this.email,
        this.celular,
        this.direccion,
        this.observacion,
        this.coordenadas,
    });

    String id;
    String cedula;
    String nombres;
    String email;
    String celular;
    String direccion;
    String observacion;
    String coordenadas;

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["_id"],
        cedula: (json["cedula"]==null)?'No data':json["cedula"],
        nombres: (json["nombres"]==null)?'No data':json["nombres"],
        email: (json["email"]==null)?'No data':json["email"],
        celular: (json["celular"]==null)?'No data':json["celular"],
        direccion: (json["direccion"]==null)?'No data':json["direccion"],
        observacion: (json["observacion"]==null)?'No data':json["observacion"],
        coordenadas: (json["coordenadas"]==null)?'No data':json["coordenadas"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "cedula": cedula,
        "nombres": nombres,
        "email": email,
        "celular": celular,
        "direccion": direccion,
        "observacion": observacion,
        "coordenadas": coordenadas,
    };
}
