import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drug_info_app/core/utilities/APIConnection.dart';
import 'package:drug_info_app/core/utilities/errorHandling.dart';
import 'package:drug_info_app/core/utilities/jwt_helper.dart';
import 'package:drug_info_app/models/token_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DioInterceptor extends Interceptor{
  final _jwtHelper = JwtHelper.instance;
  final _storage = GetStorage();
  final _dio = Dio();
  final _apiConnection = ApiConnection.instance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    String? _token =await _jwtHelper.getToken();
    print(_token);
    String? _refreshToken =await _jwtHelper.getRefreshToken();
    String? _client =await _jwtHelper.getClient();
    if(_refreshToken == null){
       handler.next(options);
    }
    var userId =await _jwtHelper.getUserId(_token!);
    if(await _jwtHelper.isTokenExpired(_token)){
      var result =await _dio.post("${_apiConnection.url}Auth/RefreshToken", data: {
        "refreshToken": _refreshToken,
        "userId": userId,
        "client": _client
      });
        
        var token = TokenModel.fromJson(result.data);
        _jwtHelper.setToken(token.token);
        _jwtHelper.setRefreshToken(token.refreshToken);
        _jwtHelper.setClient(token.clientId);
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
    ErrorHandling().handle(error: err);
    super.onError(err, handler);
  }
}