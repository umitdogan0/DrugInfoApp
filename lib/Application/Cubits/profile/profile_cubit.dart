import 'package:drug_info_app/Application/Cubits/home/home_cubit_state.dart';
import 'package:drug_info_app/Application/Cubits/profile/profile_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  final box = GetStorage();
  ProfileCubit() : super(ProfileCubitState());


  Future<void> change() async{
    box.write("darkMode", !box.read("darkMode") as bool);
    emit(ProfileCubitState().copyWith(isChange: !state.isChange) );
  }

  Future<void> obsecureTextChange() async{
    emit(ProfileCubitState().copyWith(isObsecureText : !state.isObsecureText) );
  }
  
}