import 'package:dio/dio.dart';
import 'package:drug_info_app/core/utilities/dio_interceptor.dart';

class DioClient {
  final _dio = Dio(); 

  DioClient(){
    _dio.interceptors.add(DioInterceptor());
  }
  Dio get dio => _dio;
}