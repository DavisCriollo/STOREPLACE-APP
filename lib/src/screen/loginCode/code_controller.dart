import 'package:flutter/material.dart';

class CodeController extends ChangeNotifier {
  String _position = 'Seleccione Ubicación';

  String get position => this._position;

  set position(String newPositon) {
    _position = newPositon;
    notifyListeners();
  }
}
