// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:drug_info_app/models/drugModel.dart';

class HomeCubitState extends Equatable {
  bool isSuccess;
  List<DrugModel>? searchedData;
  DrugModel? searchData;
  HomeCubitState({
    this.isSuccess = false,
    this.searchedData,
    this.searchData,
  });
  @override
  List<Object?> get props => [isSuccess, searchedData, searchData];
  

  HomeCubitState copyWith({
    bool? isSuccess,
    List<DrugModel>? searchedData,
    DrugModel? searchData,
  }) {
    return HomeCubitState(
      isSuccess: isSuccess ?? false,
      searchedData: searchedData ?? this.searchedData,
      searchData: searchData ?? this.searchData,
    );
  }
}
