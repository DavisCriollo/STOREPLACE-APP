import 'package:flutter/material.dart';
// import 'package:storePlace/src/data/providers/autentication_provider.dart';

class UserController with ChangeNotifier {
  String _cedula = "", _nombres = "",_celular = "", _email = "", _codigo = "", _rol = "";

  // final _api = AutenticationProvider();

  void onCedulaChange(String text) {
    _cedula = text;
  }

  void onNombreChange(String text) {
    _nombres = text;
  }
  void onCelularChange(String text) {
    _celular = text;
  }

  void onEmailChange(String text) {
    _email = text;
  }

  void onCodigoChange(String text) {
    _codigo = text;
  }

  void onrolChange(String text) {
    _rol = text;
  }

  List<String> _roles = ['Administrador', 'Standar'];

  String _rolSeleccionado;

  List<String> get getRol => _roles;
  String get selected => _rolSeleccionado;

  void setSelectedItem(String value) {
    _rolSeleccionado = value;
    notifyListeners();
  }

}