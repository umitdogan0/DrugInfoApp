// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:drug_info_app/models/token_model.dart';

class LoginCubitState extends Equatable {
  TokenModel? tokenModel;
  bool isAuth;
  bool isLoading;
  LoginCubitState({
    this.isAuth = false,
    this.tokenModel,
    this.isLoading = true,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>[isAuth, tokenModel];
  

  LoginCubitState copyWith({
    TokenModel ? tokenModel,
    bool? isAuth,
    bool? isLoading,
  }) {
    return LoginCubitState(
      tokenModel: tokenModel ?? null ,
      isAuth: isAuth ?? false,
      isLoading: isLoading ?? true,
    );
  }
}
