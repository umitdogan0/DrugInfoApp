import 'package:dio/dio.dart';
import 'package:drug_info_app/core/utilities/APIConnection.dart';
import 'package:drug_info_app/core/utilities/dio_client.dart';
import 'package:drug_info_app/core/utilities/errorHandling.dart';
import 'package:drug_info_app/models/drugModel.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IUserDrugService{
  Future<Result<List<DrugModel>,String>> getAllDrugByUserId(String userId);
}
class UserDrugService extends IUserDrugService{
  UserDrugService._();
  static UserDrugService? _instance;
  static UserDrugService get instance {
    _instance ??= UserDrugService._();
    return _instance!;
  }

  final ac = ApiConnection.instance;
  final _dio = DioClient().dio;
  Future<Result<List<DrugModel>,String>> getAllDrugByUserId(String userId) async{
    try {
      var result =await _dio.get(ApiConnection.instance.nodeUrl);
      var data = (result.data as List).map((e) => DrugModel.fromJson(e)).toList();
      return Success(data);
    }on DioError catch (e) {
      return Error(ErrorHandling().handle(error: e));
    }
  } 
}