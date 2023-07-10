import 'package:dio/dio.dart';
import 'package:drug_info_app/models/API_error_model.dart';

final class ErrorHandling {
  String handle({ required DioError error}){
    if(error.response?.statusCode == 401 || error.response?.statusCode == 403){
      return "You are not authanticated to access this resource";
  }
  else{
    if(error.response?.data != null){
      return  APIErrorModel.fromJson(error.response?.data).Detail.toString();
    }
   return "Something went wrong";
  }
}
}