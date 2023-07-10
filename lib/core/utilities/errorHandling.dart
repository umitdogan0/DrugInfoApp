import 'package:dio/dio.dart';
import 'package:drug_info_app/models/API_error_model.dart';

final class ErrorHandling {
  String handle({ required DioError error}){
    if(error.response?.statusCode == 401 || error.response?.statusCode == 403){
      return "You are not authanticated to access this resource";
  }
  else{
    var error1 =APIErrorModel.fromJson(error.response?.data);
    return error1.Detail.toString();
  }
}
}