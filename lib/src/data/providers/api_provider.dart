import 'package:storePlace/src/data/models/cliente.dart';
import 'package:storePlace/src/helpers/http.dart';
import 'package:storePlace/src/helpers/http_response.dart';

class ApiProvider {
  Http _http;

  ApiProvider(this._http);
  // Future<HttpResponse<Cliente>> getCliente(String id) async {
  Future<HttpResponse<Cliente>> getCliente() async {
    final String id = '6088addf353982d361455204';
    return _http.request<Cliente>('/clientes/' + id, method: 'GET',
        parser: (data) {
      return Cliente.fromJson(data);
    });
  }
}
