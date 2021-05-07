import 'package:dio/dio.dart';
// import 'package:logger/logger.dart';
// import 'package:flutter_api_rest/helpers/http_response.dart';
// import 'package:flutter_api_rest/utils/logs.dart';
import 'package:meta/meta.dart' show required;

import 'package:storePlace/src/helpers/http_response.dart';
// import 'package:storePlace/src/utils/logs.dart';

class Http {
  Dio _dio;

  Http({
    @required Dio dio,
  }) {
    _dio = dio;
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = "GET",
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
    // Map<String, dynamic> formData,
    Map<String, String> headers,
    T Function(dynamic data) parser,
  }) async {
    try {
      final response = await _dio.request(path,
          options: Options(
            method: method,
            headers: headers,
          ),
          queryParameters: queryParameters,
          data: data);

      if (parser != null) {
        return HttpResponse.success(parser(response.data));
      }
      return HttpResponse.success(response.data);
    } catch (e) {
      int statusCode = 0; //
      String message = "unknown error";
      dynamic data;

      if (e is DioError) {
        statusCode = -1; //
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
}
