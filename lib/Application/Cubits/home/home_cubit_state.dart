// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:drug_info_app/models/drugModel.dart';

class HomeCubitState extends Equatable {
  bool isSuccess;
  bool isSearch;
  bool isShowTextField;
  List<DrugModel>? searchedData;
  DrugModel? searchData;
  HomeCubitState({
    this.isSuccess = false,
    this.isSearch = false,
    this.isShowTextField = false,
    this.searchedData,
    this.searchData,
  });

  @override
  List<Object?> get props => [isSuccess, isSearch ,isShowTextField,searchedData, searchData];
  

  HomeCubitState copyWith({
    bool? isSuccess,
    bool? isSearch,
    bool? isShowTextField,
    List<DrugModel>? searchedData,
    DrugModel? searchData,
  }) {
    return HomeCubitState(
      isSuccess: isSuccess ?? this.isSuccess,
      isSearch: isSearch ?? false,
      isShowTextField: isShowTextField ?? this.isShowTextField,
      searchedData: searchedData ?? this.searchedData,
      searchData: searchData ?? null,
    );
  }
}
