import 'package:flutter/material.dart';

class PerfilController with ChangeNotifier {
  // final _api = AutenticationProvider();
  String _id = "",
      _cedula = "",
      _nombres = "",
      _celular = "",
      _email = "",
      _codigo = "",
      _rol = "";

  // final _api = AutenticationProvider();
  void onIdChange(String text) {
    _id = text;
    print(_id);
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

//=============================================//
  // Future<Usuario> getPerfilUsuario() async {
  //   // final  response= await _api.getUsuario(_id);

  //   // if (response!=null) {
  //   print('_cedula=> $_id');
  //   print('_cedula=> $_cedula');
  //   print('_nombre=> $_nombres');
  //   print('_telefono=> $_celular');
  //   print('_correo=> $_email');
  //   print('_direccion=> $_codigo');
  //   print('_observacion=> $_rol');
  //   //   return response;
  //   // } else {
  //   //   return null;
  //   // }
  // }
}
