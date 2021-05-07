 import 'package:dio/dio.dart';
import 'package:storePlace/src/helpers/http.dart';


final Http httpClient = Http(dio:new Dio(
    BaseOptions(
      baseUrl: 'https://storeplace.gerverd.com/api',
    ),
  ));