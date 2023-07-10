import 'dart:ui';

import 'package:drug_info_app/Application/Cubits/login/login_cubit.dart';
import 'package:drug_info_app/Application/Cubits/login/login_cubit_state.dart';
import 'package:drug_info_app/Application/Services/auth_service.dart';
import 'package:drug_info_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatelessWidget {
  final form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)]),
  });
  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(create:(context) => LoginCubit(LoginService.instance),
    child: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: Center(
            child: BlocSelector<LoginCubit,LoginCubitState,bool>(
              selector: (state) {
                return state.isLoading;
              },
              builder: (context, state) {
                return BlocBuilder<LoginCubit,LoginCubitState>(builder: (context, state) {
                 return  AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: state.isLoading ? 1 : 0.3,
                child: ReactiveForm(
                        formGroup: this.form,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:200 ,
                              child: ReactiveTextField(
                                  formControlName: 'email',
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                  ),
                                  validationMessages: {
                                    'required': (error) =>
                                        "The email must not be empty",
                                    "email": (error) =>
                                        'The email value must be a valid email',
                                  }),
                            ),
                            SizedBox(
                              width: 200,
                              child: ReactiveTextField(
                                formControlName: 'password',
                                obscureText: true,
                                validationMessages: {
                                  'required': (error) =>
                                      "The password must not be empty",
                                  "minLength": (error) =>
                                      'The password must be at least 6 characters',
                                },
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                            SizedBox(height: 40,),
                            BlocConsumer<LoginCubit,LoginCubitState>(builder: (context, state) {
                              return ElevatedButton(onPressed: (){
                                if(this.form.valid){
                                  context.read<LoginCubit>().login(context,form.control("email").value,form.control("password").value);
                                }
                              }, child: Text("Login"));
                            }, listener: (context, state) {
                              if(state.isAuth == true && state.tokenModel != null){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                              }
                            },)
                            
                          ],
                        )),
              );
                });
              },
            ))),
     );
  }
}
