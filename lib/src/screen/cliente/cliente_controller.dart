import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:storePlace/src/data/models/clientesAll.dart';
import 'package:storePlace/src/data/models/session.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/data/providers/auth_storage.dart';

class ClienteController with ChangeNotifier {
  // final _api = AutenticationProvider(httpClient);
  final _api = AutenticationProvider();

  List<ClienteAll> _clientes = [];

  get clientes => _clientes;

  String _id = "",
      _cedula = "",
      _nombre = "",
      _telefono = "",
      _correo = "",
      _direccion = "",
      _observacion = "",
      _coordenadas = "";

  void getSesion() async {
    final Session session = await Auth.instance.getSession();
    _id = session.id;
  }

  String get getIduser => _id;
  void onCedulaChange(String text) {
    _cedula = text;
  }

  void onNombreChange(String text) {
    _nombre = text;
  }

  void onTelefonoChange(String text) {
    _telefono = text;
  }

  void onCorreoChange(String text) {
    _correo = text;
  }

  void onDireccionChange(String text) {
    _direccion = text;
  }

  void onObservacionesChange(String text) {
    _observacion = text;
  }

  void onCoordenadasChange(String text) {
    _coordenadas = text;
  }

//========================== GEOLOCATOR =======================//
  Geolocator.Position _position;
  Geolocator.Position get position => this._position;
  String _selectCoords = "";
  String get selectCoords => _selectCoords;

  Future<void> getCurrentPosition() async {
    this._position = await Geolocator.GeolocatorPlatform.instance.getCurrentPosition(
      desiredAccuracy: Geolocator.LocationAccuracy.bestForNavigation,
    );
    _position = position;
    _selectCoords = ('${position.latitude},${position.longitude}');
    _coordenadas = _selectCoords;
    notifyListeners();
  }

//========================== NEW CLIENTE =======================//
  Future<String> nuevoCliente() async {
    print('_cedula=> $_cedula');
    print('_nombre=> $_nombre');
    print('_telefono=> $_telefono');
    print('_correo=> $_correo');
    print('_direccion=> $_direccion');
    print('_observacion=> $_observacion');
    print('_coordenadas=> $_coordenadas');

    final response = await _api.newCliente(
        _cedula, _nombre.toUpperCase(), _telefono, _correo, _direccion, _observacion, _coordenadas);
    return response.error;
  }

  // Future<void> getClientes() async {
  //   final response = await _api.listarClientes();
  //   if (response.data != null) {
  //     _clientes = response.data.clientes;
  //     notifyListeners();
  //   }
  // }
}
