import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtHelper {
  final _storage = GetStorage();
  JwtHelper._();
  static JwtHelper? _instance; 
  static JwtHelper get instance {
    _instance ??= JwtHelper._();
    return _instance!;
  }

  Future<bool> isTokenExpired(String token) async{
    final expiration = JwtDecoder.getExpirationDate(token);
    if(expiration.isBefore(DateTime.now()) || expiration.difference(DateTime.now()).inMinutes < 5){
      return true;
    } 
    return false;
  }

  bool isTokenExpiredSync(String token){
    final expiration = JwtDecoder.getExpirationDate(token);
    if(expiration.isBefore(DateTime.now()) || expiration.difference(DateTime.now()).inMinutes < 5){
      return true;
    } 
    return false;
  }

  Future<String?> getUserId(String token) async {
    return await JwtDecoder.decode(token)["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
  }

  String? getUserIdsync(String token) {
    return JwtDecoder.decode(token)["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
  }

  Future<String?> getToken() async{
    return await _storage.read("token");
  }

  String? getTokenSync(){
    return _storage.read("token");
  }
  
  Future<String?> getRefreshToken() async{
    return await _storage.read("refreshToken");
  }

  String getRefreshTokenSync(){
    return _storage.read("refreshToken");
  }

  Future<String?> getClient() async{
    return await _storage.read("client");
  }

  String? getClientSync(){
    return _storage.read("client");
  }

  Future<void> setToken(String token) async{
  await _storage.write("token",token);
  }
  
  Future<void> setRefreshToken(String refreshToken) async{
  await _storage.write("refreshToken", refreshToken);
  }

  Future<void> setClient(String client) async{
  await _storage.write("client",client);
  }

}