import 'package:flutter/material.dart';
import 'package:storePlace/src/data/models/searchUsuarios.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';

class SearchController extends ChangeNotifier {
  final _api = AutenticationProvider();
  String _nameSearch = "";
  String get nameSearch => _nameSearch;
  List<SearchUsuarios> _getUsuarioSearch = [];
  List<SearchUsuarios> get getClientesSearch => _getUsuarioSearch;

  void onSearchText(String data) {
    _nameSearch = data;
    // notifyListeners();
  }

  Future<SearchUsuarios> searchUsuario() async {
    // print('$_nameSearch');
    if (_nameSearch.length >= 1) {
      final response = await _api.searchUsuarios(_nameSearch);
      // print('Mas de 3 caractere ==> : ${response.clientes[0].nombres}');
      if (response != null) {
        _getUsuarioSearch.add(response);
        // print('${_getClientesSearch[1].clientes}');
        notifyListeners();
        return response;
      }
    }
    return null;
  }
  //===================BOTON SEARCH USUARIO==========================//

  bool _btnSearch = false;
  bool get btnSearch => _btnSearch;

  void setBtnSearch(bool action) {
    _btnSearch = action;
    notifyListeners();
  }
//===================================================//
}
