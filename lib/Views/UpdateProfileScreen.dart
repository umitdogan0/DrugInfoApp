import 'package:drug_info_app/Application/Cubits/profile/profile_cubit.dart';
import 'package:drug_info_app/Application/Cubits/profile/profile_cubit_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);
  final form = FormGroup({
    'fullname': FormControl<String>(
        validators: []),
    'password': FormControl<String>(
        validators: [Validators.minLength(6)]),

        'email': FormControl<String>(
        validators: [Validators.minLength(1500)]),

     'phone_number': FormControl<String>(
        validators: []),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.arrowtriangle_left)),
        title: Text("tEditProfile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Text("text") ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                      child: const Icon(CupertinoIcons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              ReactiveForm(formGroup: form,
               child: Column(
                  children: [
                    ReactiveTextField(
                      formControlName: "fullname",
                      decoration: const InputDecoration(
                          label: Text("tFullName"), prefixIcon: Icon(CupertinoIcons.person_alt)),
                    ),
                    const SizedBox(height: 80 - 20),
                    ReactiveTextField(
                      formControlName: "email",
                      readOnly: true,
                      decoration: const InputDecoration(
                          label: Text("tEmail"), prefixIcon: Icon(CupertinoIcons.info_circle)),
                    ),
                    const SizedBox(height: 80 - 20),
                    ReactiveTextField(
                     formControlName: "phone_number",
                      decoration: const InputDecoration(
                          label: Text("tPhoneNo"), prefixIcon: Icon(CupertinoIcons.phone)),
                    ),
                    const SizedBox(height: 80 - 20),
                    BlocBuilder<ProfileCubit,ProfileCubitState>(builder: (context,state){
                      return ReactiveTextField(
                      formControlName: "password",
                      obscureText: state.isObsecureText,
                      decoration: InputDecoration(
                        label: const Text("tPassword"),
                        prefixIcon: const Icon(Icons.fingerprint_sharp),
                        suffixIcon:
                        IconButton(icon: Icon(state.isObsecureText? CupertinoIcons.eye_slash : CupertinoIcons.eye ), onPressed: () {context.read<ProfileCubit>().obsecureTextChange();}),
                      ),
                    );
                    }),
                    
                     const SizedBox(height: 100),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => UpdateProfileScreen()),
                        style: ElevatedButton.styleFrom(
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("tEditProfile",),
                      ),
                    ),
                    const SizedBox(height: 100),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: "tJoined",
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: "tJoinedAt",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text("tDelete"),
                        ),
                      ],
                    )
                  ],
                ),
               )
            ],
          ),
        ),
      ),
    );
  }
}