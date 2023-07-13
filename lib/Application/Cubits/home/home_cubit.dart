import 'package:drug_info_app/Application/Cubits/home/home_cubit_state.dart';
import 'package:drug_info_app/Application/Services/drugService.dart';
import 'package:drug_info_app/core/components/customSnackBar.dart';
import 'package:drug_info_app/models/drugModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeCubitState>{
  DrugModel? _success;
  List<DrugModel>? _successList = [];
  final IDrugService _drugService;
  HomeCubit(IDrugService drugService) : _drugService = drugService, super(HomeCubitState());

  Future<void> getDrugByName(context,String name) async{
    final response = await _drugService.getDrugByName(name: name);
    response.when((success) {
      _success = success;
    }, (error) {
      CustomSnackBar().show(context,error);
    });
    emit(state.copyWith(isSuccess: true));
  }


}