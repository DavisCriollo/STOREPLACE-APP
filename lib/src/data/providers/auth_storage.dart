import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:meta/meta.dart' show required;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storePlace/src/data/models/codeLogin.dart';
// import 'package:storePlace/src/data/models/codeLogin.dart';
import 'package:storePlace/src/data/models/session.dart';
// import 'package:sgaapp/src/Models/infoLoginModel.dart';

class Auth {
  Auth.internal();
  static Auth _instance = Auth.internal();
  static Auth get instance => _instance;

  final _storage = FlutterSecureStorage();
  final key = 'SESSION';

  

// GUARDO LA INFORMACION EN EL DISPOSITIVO
  Future<void> setSession(CodeLogin data) async {
    final Session session = Session(
      token: data.token,
      id: data.id,
      rol: data.rol,
      //   // createAt: DateTime.now()
    );

// CONVERTIMOS  LA INFORMACION  A STRING PARA GUARDAR AL DISPOSITIVO
    final String value = jsonEncode(session.toJson());
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await this._storage.write(key: key, value: value);
  }

// OBTEMENOS LA INFORMACION DEL DISPOSITIVO
  Future<Session> getSession() async {
    final String value = await this._storage.read(key: key);
    if (value != null) {
      final Map<String, dynamic> json = jsonDecode(value);
      final session = Session.fromJson(json);
      return session;
    }
    return null;
  }
  // CIERRO SESSION
  Future<void> logOut(BuildContext context) async {
    await this._storage.deleteAll();
    Navigator.pushNamedAndRemoveUntil(context, 'code', (_) => false);
  }
}
