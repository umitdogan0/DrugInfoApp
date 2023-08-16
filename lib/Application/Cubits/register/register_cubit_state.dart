// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:drug_info_app/models/token_model.dart';

class RegisterCubitState extends Equatable {
  TokenModel? tokenModel;
  bool isAuth;
  bool isLoading;
  RegisterCubitState({
    this.isAuth = false,
    this.tokenModel,
    this.isLoading = true,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>[isAuth, tokenModel];
  

  RegisterCubitState copyWith({
    TokenModel ? tokenModel,
    bool? isAuth,
    bool? isLoading,
  }) {
    return RegisterCubitState(
      tokenModel: tokenModel ?? null ,
      isAuth: isAuth ?? false,
      isLoading: isLoading ?? true,
    );
  }
}
