// To parse this JSON data, do
//
//     final clientes = clientesFromJson(jsonString);

import 'dart:convert';

Clientes clientesFromJson(String str) => Clientes.fromJson(json.decode(str));

String clientesToJson(Clientes data) => json.encode(data.toJson());

class Clientes {
    Clientes({
        this.clientes,
    });

    List<ClienteAll> clientes;

    factory Clientes.fromJson(Map<String, dynamic> json) => Clientes(
        clientes: List<ClienteAll>.from(json["clientes"].map((x) => ClienteAll.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "clientes": List<dynamic>.from(clientes.map((x) => x.toJson())),
    };
}

class ClienteAll {
    ClienteAll({
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

    factory ClienteAll.fromJson(Map<String, dynamic> json) => ClienteAll(
        id: json["_id"],
        cedula: json["cedula"],
        nombres: (json["nombres"]==null)?'No data':json["nombres"],
        email: (json["email"]==null)?'No data':json["email"],
        celular: (json["celular"]==null)?'No data':json["celular"],
        direccion: (json["direccion"]==null)?'No data':json["direccion"],
        observacion: (json["observacion"]==null)?'No data':json["observacion"],
        coordenadas:(json["coordenadas"]==null)?'No data': json["coordenadas"],
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
