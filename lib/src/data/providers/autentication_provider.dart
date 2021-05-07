// import 'package:logger/logger.dart';
// import 'dart:io';

import 'package:logger/logger.dart';
// import 'package:storePlace/src/data/models/codeLogin.dart';
import 'package:meta/meta.dart' show required;
import 'package:dio/dio.dart';
import 'package:storePlace/src/data/models/cliente.dart';
import 'package:storePlace/src/data/models/clientesAll.dart';
import 'package:storePlace/src/data/models/searchClientes.dart';
import 'package:storePlace/src/data/models/searchUsuarios.dart';

import 'package:storePlace/src/data/models/usuario.dart';
import 'package:storePlace/src/data/models/usuariosAll.dart';
import 'package:storePlace/src/helpers/http.dart';
// import 'package:storePlace/src/helpers/exceptions.dart';

import 'package:storePlace/src/helpers/http_response.dart';

class AutenticationProvider {
  // =================== INSTANCIO LA CLASE DIO  =======================//
  final Dio _dio = new Dio(
    BaseOptions(
      baseUrl: 'https://storeplace.gerverd.com/api',
    ),
  );


  // Http _http;
  // AutenticationProvider(this._http);

  final Logger _logger = Logger();
  // =================== LOGIN DEL USUARIO-CODE  =======================//
  Future<HttpResponse> loginCode({
    @required String code,
  }) async {
    try {
      final Response response = await this._dio.post(
        '/auth/login',
        data: {
          "codigo": code,
        },
      );
      // _logger.i(response.data);
      // print(response.data);
      return HttpResponse.success(response.data);
      // return response.data;
    } catch (e) {
      _logger.e(e);
      // Si perdimos la conexion de internet
      int statusCode = -1;
      String message = 'Error desconocido';
      dynamic data;
      if (e is DioError) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response.statusCode;
          message = e.response.statusMessage;
          data = e.response.data;
        }
      }

      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }

//===================================================================//
  //=========================RESGISTROS CLIENTES=======================//
  //===================================================================//
  Future<Clientes> listarClientes() async {
    try {
      final response = await this._dio.get(
            '/clientes/',
          );
      final data = Clientes.fromJson(response.data);
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }
  // Future<HttpResponse<Clientes>> listarClientes() async {
  //   final response = await _http.request<Clientes>('/clientes/', method: 'GET',parser:(data){
  //     return Clientes.fromJson(data);
  //   } );
  //   return response;
  // }

  //===================================================================//
  Future<Cliente> getCliente(String id) async {
    try {
      final response = await this._dio.get('/clientes/' + id);

      final data = Cliente.fromJson(response.data);
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //===================================================================//
  Future<bool> newCliente(String ced, String nom, String tel, String email,
      String dir, String obs, String coord) async {
    try {
      final response = await this._dio.post('/clientes/new', data: {
        "cedula": ced,
        "nombres": nom,
        "email": email,
        "celular": tel,
        "direccion": dir,
        "observacion": obs,
        "coordenadas": coord
      });
      _logger.i(response.data);
      // final data = Cliente.fromJson(response.data);
      // print(response.data);
      return true;
    } catch (e) {
      // return null;

    }
    return null;
  }

  //===================================================================//
  Future<bool> uptadeCliente(String id, String ced, String nom, String tel,
      String email, String dir, String obs, String coord) async {
    try {
      final response = await this._dio.put('/clientes/' + id, data: {
        "cedula": ced,
        "nombres": nom,
        "email": email,
        "celular": tel,
        "direccion": dir,
        "observacion": obs,
        "coordenadas": coord
      });
      _logger.i(response.data);

      return true;
    } catch (e) {
      // return null;

    }
    return null;
  }

  //===================================================================//
  Future<bool> deleteCliente(String id) async {
    try {
      final response = await this._dio.delete('/clientes/' + id);
      _logger.i(response.data);
      // final data = Cliente.fromJson(response.data);
      // print(response.data);
      return true;
    } catch (e) {
      // return null;

    }
    return null;
  }

  //===================================================================//
  //=========================RESGISTROS USUARIOS=======================//
  //===================================================================//
  Future<UsuariosAll> listarUsuarios() async {
    try {
      final response = await this._dio.get(
            '/usuarios/',
          );

      final data = UsuariosAll.fromJson(response.data);

      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Usuario> getUsuario(String id) async {
    try {
      final response = await this._dio.get('/usuarios/' + id);

      final data = Usuario.fromJson(response.data);
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //===================================================================//
  Future<SearchClientes> searchClientes(String name) async {
    try {
      final response = await this._dio.post('/clientes', data: {
        "nombres": name,
      });
      final data = SearchClientes.fromJson(response.data);
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //===================================================================//
  Future<bool> newUsuario(String cedula, String nombre, String celular,
      String email, String codigo, String rol) async {
    try {
      final response = await this._dio.post('/auth/new', data: {
        "cedula": cedula,
        "nombres": nombre,
        "celular": celular,
        "email": email,
        "codigo": codigo,
        "rol": rol
      });
      _logger.i(response.data);
      // final data = RegisterUser.fromJson(response.data);
      // print(response.data);
      return true;
    } catch (e) {
      // _logger.e(e);
      // Si perdimos la conexion de internet
      // int statusCode = -1;
      // String message = 'Error desconocido';
      // dynamic data;
      if (e is DioError) {
        // print(e.message);
        // message = e.message;
        // if (e.response != null) {
        //   statusCode = e.response.statusCode;
        //   message = e.response.statusMessage;
        //   data = e.response.data;
        //   print(message.hashCode);
        // }
        return e.response.data;
        //     print('${e.response.data["msg"]}');
        //   return e.response.data;
        // }
        //
      }
      return null;
    }
  }

  //===================================================================//
  Future<bool> deleteUsuario(String id) async {
    try {
      final response = await this._dio.delete('/usuarios/' + id);
      _logger.i(response.data);
      // final data = Cliente.fromJson(response.data);
      // print(response.data);
      return true;
    } catch (e) {
      // return null;

    }
    return null;
  }

  //===================================================================//
  Future<bool> uptadeUsuario(String id, String nombre, String celular,
      String email, String codigo, String rol) async {
    try {
      final response = await this._dio.put('/usuarios/' + id, data: {
        "nombres": nombre,
        "celular": celular,
        "email": email,
        "codigo": codigo,
        "rol": rol
      });
      _logger.i(response.data);
      // final data = Cliente.fromJson(response.data);
      // print(response.data);
      return true;
    } catch (e) {
      // return null;
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      // print('====> $errorMessage');
    }
    return null;
  }

  //===================================================================//
  Future<SearchUsuarios> searchUsuarios(String name) async {
    try {
      final response = await this._dio.post('/usuarios', data: {
        "nombres": name,
      });
      // print('${response.data}');
      final data = SearchUsuarios.fromJson(response.data);
      // print('${data.clientes}');
      return data;
    } catch (e) {
      // print(e);
      return null;
    }
  }
}
