import 'package:dio/dio.dart';
import 'package:drug_info_app/core/utilities/APIConnection.dart';
import 'package:drug_info_app/core/utilities/dio_client.dart';
import 'package:drug_info_app/core/utilities/errorHandling.dart';
import 'package:drug_info_app/models/drugModel.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IDrugService {
  Future<Result<DrugModel,String>> getDrugByName({required String name});
  Future<Result<List<DrugModel>?,String>> getDrugByUser({required String userId});
}

class DrugService extends IDrugService{

  

  Dio dio = DioClient().dio;
  ApiConnection ac = ApiConnection.instance;
  @override
  Future<Result<DrugModel,String>> getDrugByName({required String name}) async{
    try {
      var drugData = await dio.get("https://localhost:7091/api/Drugs/GetByNameDrug?Name=advil");
      print("drugData");
      var data = DrugModel.fromJson(drugData.data);
      return Success(data);
    }on DioError catch (e) {
      return Error(ErrorHandling().handle(error: e));

    }
      
    }
    
      @override
      Future<Result<List<DrugModel>?, String>> getDrugByUser({required String userId}) async{
       try{
        var drugData = await dio.get("https://localhost:7091/api/Drugs/GetAllByUserIdDrug?UserId=$userId");
        if(!drugData.data){
          return Success(null);
        }
        var data = (drugData.data as List).map((e) => DrugModel.fromJson(e)).toList();
        return Success(data);
       } on DioError catch (e) {
        return Error(ErrorHandling().handle(error: e));
       }
      }
  }