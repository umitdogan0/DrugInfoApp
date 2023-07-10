import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drug_info_app/core/utilities/APIConnection.dart';
import 'package:drug_info_app/models/token_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DioInterceptor extends Interceptor{
  final _storage = GetStorage();
  final _dio = Dio();
  String? _token;
  final _apiConnection = ApiConnection.instance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    String _token = _storage.read("token");
    String refreshToken = _storage.read("refreshToken");
    String client = _storage.read("client");
    if(refreshToken == null){
       handler.next(options);
    }
    var userId =await JwtDecoder.decode(_token)["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
    DateTime expire = JwtDecoder.getExpirationDate(_token);
    if(expire.isBefore(DateTime.now()) || expire.difference(DateTime.now()).inMinutes < 5){
      var result =await _dio.post("${_apiConnection.url}Auth/RefreshToken", data: {
        "refreshToken": refreshToken,
        "userId": userId,
        "client": client
      });
        
        var token = TokenModel.fromJson(result.data);
        _storage.write("token", token.token);
        _storage.write("client", token.clientId);
        _storage.write("refreshToken", token.refreshToken);
        _token = token.token;
    }
    options.headers['Authorization'] = " Bearer ${_token}";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}