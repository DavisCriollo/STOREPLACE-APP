import 'package:flutter/widgets.dart' show ChangeNotifier;

import '../../data/models/clientesAll.dart';
import '../../data/providers/autentication_provider.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._authenticationProvider) {
    init();
  }

  final AutenticationProvider _authenticationProvider;
  bool _error; // sera nulo la primera vez
  bool get error => _error;

  List<ClienteAll> _clientes = [];
  List<ClienteAll> get clientes => _clientes;

  String _searchText = '';
  String get searchText => _searchText;

  Future<void> init() async {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
    final apiResponse = await _authenticationProvider.listarClientes();

    // _clientes = clientes?.clientes;
    _error = apiResponse.error != null;
    if (!_error) {
      _clientes = apiResponse.data.clientes;
    }
    notifyListeners();
  }

  void onSearchTextChanged(String text) {
    _searchText = text;
    notifyListeners();
  }
}
