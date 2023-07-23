import 'package:drug_info_app/Application/Cubits/home/home_cubit_state.dart';
import 'package:drug_info_app/Application/Services/drugService.dart';
import 'package:drug_info_app/Application/Services/user_drug_service.dart';
import 'package:drug_info_app/core/components/customSnackBar.dart';
import 'package:drug_info_app/models/drugModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeCubitState>{
  
  DrugModel? _success;
  List<DrugModel>? _successList = [];
  final IDrugService _drugService;
  final IUserDrugService _userDrugService;
  HomeCubit(IDrugService drugService,IUserDrugService userDrugService,userId,context) : _drugService = drugService,_userDrugService = userDrugService, super(HomeCubitState()){
    if(state.isSearch == false){
    getSearchedDrugs(context,userId);

    }
  }


  Future<void> getDrugByName(context,String name) async{
    final response = await _drugService.getDrugByName(name: name);
    response.when((success) {
      _success = success;
      emit(state.copyWith(isSuccess: true, isSearch: true, searchData: _success));
    }, (error) {
      emit(state.copyWith(isSuccess: false, isSearch: false, searchData: null));
      CustomSnackBar().show(context,error);
    });
    
  }

  Future<void> getSearchedDrugs(context,String userId) async{
    final response = await _userDrugService.getAllDrugByUserId(userId);
    response.when((success) => _successList = success, (error) => CustomSnackBar().show(context, error));
    emit(state.copyWith(isSuccess: true, isSearch: false, searchedData: _successList));
  }

  Future<void> changeTextField() async{
  emit(state.copyWith(isShowTextField: !state.isShowTextField));
  }

  Future<void> changeSearch({required value}) async{
  emit(state.copyWith(isSearch:value));
  }


}