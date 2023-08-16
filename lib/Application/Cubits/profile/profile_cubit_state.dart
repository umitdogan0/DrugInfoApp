import 'package:equatable/equatable.dart';

class ProfileCubitState extends Equatable {
  bool isChange;
  bool isObsecureText;
  ProfileCubitState({
    this.isChange = false,
    this.isObsecureText = true,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>[isChange , isObsecureText];
  

  ProfileCubitState copyWith({
    bool? isChange,
    bool? isObsecureText,
  }) {
    return ProfileCubitState(
      isChange: isChange ?? this.isChange ,
      isObsecureText: isObsecureText ?? this.isObsecureText,
    );
  }
}
