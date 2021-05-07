import 'package:flutter/material.dart';
import 'package:storePlace/src/data/models/searchClientes.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';


class SearchClienteController extends ChangeNotifier {
  final _api = AutenticationProvider();
  String _nameSearch = "";
  String get nameSearch => _nameSearch;
  List<SearchClientes> _getClientesSearch = [];
  List<SearchClientes> get getClientesSearch => _getClientesSearch;

  void onSearchText(String data) {
    _nameSearch = data;
  }

  Future<SearchClientes> searchClientesAll() async {
    if (_nameSearch.length >= 1) {
      final response = await _api.searchClientes(_nameSearch);
      if (response != null) {
        _getClientesSearch.add(response);

        notifyListeners();
        return response;
      }
    }
    return null;
  }
//===================BOTON SEARCH CLIENTE==========================//

  bool _btnSearch = false;
  bool get btnSearch => _btnSearch;

  void setBtnSearch(bool action) {
    _btnSearch = action;
    notifyListeners();
  }
//===================================================//

}
