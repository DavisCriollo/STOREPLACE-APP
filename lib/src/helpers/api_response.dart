import 'package:dio/dio.dart';

class ApiResponse<T> {
  final T data;
  final String error;
  ApiResponse(this.data, this.error);
}

String apiErrorMessage(dynamic e) {
  print(e);
  String error = "Error desconicido";
  if (e is DioError) {
    if (e.response != null) {
      error = e.response.data['msg'];
    }
  }
}
