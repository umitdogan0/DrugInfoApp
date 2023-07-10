import 'package:drug_info_app/Application/Cubits/home/home_cubit_state.dart';
import 'package:drug_info_app/Application/Services/drugService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeCubitState>{
  final IDrugService _drugService;
  HomeCubit(IDrugService drugService) : _drugService = drugService, super(HomeCubitState());

  Future<void> getDrugByName(String name) async{
    final response = await _drugService.getDrugByName(name: name);
    // response.when(success: (data) {
    //   emit(state.copyWith(drug: data));
    // }, error: (error) {
    //   emit(state.copyWith(error: error));
    // });
    emit(state.copyWith(isSuccess: true));
  }


}