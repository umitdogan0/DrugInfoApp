import 'package:drug_info_app/Application/Cubits/register/register_cubit_state.dart';
import 'package:drug_info_app/Application/Services/auth_service.dart';
import 'package:drug_info_app/Views/login_page.dart';
import 'package:drug_info_app/core/components/customSnackBar.dart';
import 'package:drug_info_app/core/utilities/local_storage.dart';
import 'package:drug_info_app/models/token_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  TokenModel? _success;
  final ILoginService _loginService;
  final local = LocalStorage.instance;
  RegisterCubit(ILoginService loginService) : _loginService = loginService, super(RegisterCubitState());

  Future<void> login(context,String first_name,String last_name,String email,String password) async{
    emit(state.copyWith(isLoading: false, isAuth: false, tokenModel: null));
    final response =await _loginService.register(first_name,last_name,email, password);
    response.when((success) {
      _success = success;
    } , (error) {
      CustomSnackBar().show(context, error);
    }  );
    emit(state.copyWith(isAuth: true,tokenModel: _success,isLoading: true));
  }
  
}