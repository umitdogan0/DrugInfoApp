import 'dart:convert';

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:drug_info_app/core/utilities/APIConnection.dart';
import 'package:drug_info_app/core/utilities/jwt_helper.dart';
import 'package:drug_info_app/core/utilities/local_storage.dart';
import 'package:drug_info_app/models/token_model.dart';
import 'package:http/http.dart' as http;

class GraphQLInterceptor implements http.BaseClient {
  final http.Client _httpClient = http.Client();
  final _jwtHelper = JwtHelper.instance;
  final _storage = LocalStorage.instance;
  final _dio = Dio();
  final _apiConnection = ApiConnection.instance;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    var response;
    String? _token =await _jwtHelper.getToken();
    String? _refreshToken =await _jwtHelper.getRefreshToken();
    String? _client =await _jwtHelper.getClient();
    if(_refreshToken == null){
       response = await _httpClient.send(request);
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
    request.headers['Authorization'] = " Bearer ${_token}";
    response = await _httpClient.send(request);

    return response;
  }

  @override
  void close() {
    _httpClient.close();
  }

  @override
  Future<http.Response> delete(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    // TODO: implement head
    throw UnimplementedError();
  }

  @override
  Future<http.Response> patch(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<http.Response> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    // TODO: implement readBytes
    throw UnimplementedError();
  }
}
