// To parse this JSON data, do
//
//     final searchClientes = searchClientesFromJson(jsonString);

import 'dart:convert';

SearchClientes searchClientesFromJson(String str) =>
    SearchClientes.fromJson(json.decode(str));

String searchClientesToJson(SearchClientes data) => json.encode(data.toJson());

class SearchClientes {
  SearchClientes({
    this.clientes,
  });

  List<ClienteSearch> clientes;

  factory SearchClientes.fromJson(Map<String, dynamic> json) => SearchClientes(
        clientes: List<ClienteSearch>.from(
            json["clientes"].map((x) => ClienteSearch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clientes": List<dynamic>.from(clientes.map((x) => x.toJson())),
      };
}

class ClienteSearch {
  ClienteSearch({
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

  factory ClienteSearch.fromJson(Map<String, dynamic> json) => ClienteSearch(
        id: json["_id"],
        cedula: json["cedula"],
        nombres: json["nombres"],
        email: json["email"],
        celular: json["celular"],
        direccion: json["direccion"],
        observacion: json["observacion"],
        coordenadas: json["coordenadas"],
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

  // @override
  // String toString() {
  //   return 'Instance of Cliente:$nombres';
  // }
}
