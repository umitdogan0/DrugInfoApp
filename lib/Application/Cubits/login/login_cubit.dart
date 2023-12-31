import 'package:drug_info_app/Application/Cubits/login/login_cubit_state.dart';
import 'package:drug_info_app/Application/Services/auth_service.dart';
import 'package:drug_info_app/Views/login_page.dart';
import 'package:drug_info_app/core/components/customSnackBar.dart';
import 'package:drug_info_app/core/utilities/local_storage.dart';
import 'package:drug_info_app/models/token_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  TokenModel? _success;
  final ILoginService _loginService;
  final local = LocalStorage.instance;
  LoginCubit(ILoginService loginService) : _loginService = loginService, super(LoginCubitState());

  Future<void> login(context,String email,String password) async{
    emit(state.copyWith(isLoading: false, isAuth: false, tokenModel: null));
    final response =await _loginService.login(email, password);
    response.when((success) {
      _success = success;
    } , (error) {
      CustomSnackBar().show(context, error);
    }  );
    emit(state.copyWith(isAuth: true,tokenModel: _success,isLoading: true));
  }

  Future<void> logout(context) async{
    await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    await local.deleteAllAsync();
  }
  
}