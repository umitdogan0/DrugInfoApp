// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class HomeCubitState extends Equatable {
  final bool isSuccess;
  // final List<Drug> userDrugs;
  HomeCubitState({
    this.isSuccess = false,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [isSuccess];
  
  

  HomeCubitState copyWith({
    bool? isSuccess,
  }) {
    return HomeCubitState(
      isSuccess: isSuccess ?? false,
    );
  }
}
