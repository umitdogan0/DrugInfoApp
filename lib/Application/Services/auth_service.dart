import 'package:dio/dio.dart';
import 'package:drug_info_app/core/utilities/APIConnection.dart';
import 'package:drug_info_app/core/utilities/errorHandling.dart';
import 'package:drug_info_app/models/token_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ILoginService {
  Future<Result<TokenModel, String>> login(String email, String password);
  Future<Result<TokenModel,String>> register(String firstName, String lastName, String email, String password);
}

class LoginService extends ILoginService {
  LoginService._();
  static LoginService? _instance;
  final ac = ApiConnection.instance;
  static LoginService get instance {
    _instance ??= LoginService._();
    return _instance!;
  }
  final _getStorage = GetStorage(); 
  final _dio = Dio();
  @override
  Future<Result<TokenModel, String>> login(String email, String password) async{
    final data = {
      "email": email,
      "password": password
    };
    
    try {
      var returnData =await _dio.post("${ac.url}Auth/Login", data: data);
      var _success = TokenModel.fromJson(returnData.data);
      _getStorage.write("token", _success.token.toString());
      _getStorage.write("refreshToken", _success.refreshToken.toString());
      _getStorage.write("client", _success.clientId.toString());
      _getStorage.write("isLogin", true);
     return Success(_success);
    } on DioError catch (e) {
     return Error(ErrorHandling().handle(error: e));
    }
    
    }

    @override
 Future<Result<TokenModel,String>> register(String firstName, String lastName, String email, String password) async{
     var data = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    };
    try {
      var returnData =await _dio.post("${ac.url}auth/register");
      var _success = TokenModel.fromJson(returnData.data);
      _getStorage.write("token", _success.token.toString());
      _getStorage.write("refreshToken", _success.refreshToken.toString());
      _getStorage.write("client", _success.clientId.toString());
      _getStorage.write("isLogin", true);
      return Success(_success);
    } on DioError catch (e) {
      return Error(ErrorHandling().handle(error: e));
    }
    
  }
    
  }

  