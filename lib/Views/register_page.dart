import 'package:drug_info_app/Application/Cubits/register/register_cubit.dart';
import 'package:drug_info_app/Application/Cubits/register/register_cubit_state.dart';
import 'package:drug_info_app/Application/Services/auth_service.dart';
import 'package:drug_info_app/Views/login_page.dart';
import 'package:drug_info_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterPage extends StatelessWidget {

   final form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)]),
      'first_name': FormControl<String>(
        validators: [Validators.required]),

        'last_name': FormControl<String>(
        validators: [Validators.required,]),
  });
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocProvider<RegisterCubit>(create:(context) => RegisterCubit(LoginService.instance),
    child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Register Page"),
        ),
        body: Center(
            child: BlocSelector<RegisterCubit,RegisterCubitState,bool>(
              selector: (state) {
                return state.isLoading;
              },
              builder: (context, state) {
                return BlocBuilder<RegisterCubit,RegisterCubitState>(builder: (context, state) {
                 return  AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: state.isLoading ? 1 : 0.3,
                child: ReactiveForm(
                        formGroup: this.form,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                              width:100 ,
                              child: ReactiveTextField(
                                  formControlName: 'first_name',
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                  ),
                                  validationMessages: {
                                    'required': (error) =>
                                        "The first name must not be empty"
                                  }),
                            ),
                              SizedBox(width: 10,),
                             SizedBox(
                              width:100 ,
                              child: ReactiveTextField(
                                  formControlName: 'last_name',
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                  ),
                                  validationMessages: {
                                    'required': (error) =>
                                        "The last name must not be empty"
                                  }),
                            ),
                            ],),
                            
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
                            SizedBox(height: 18,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text("If you have already account, ", style: GoogleFonts.poppins(),),
                              GestureDetector(onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),child: Text("Login" , style: GoogleFonts.poppins(fontWeight: FontWeight.bold),))
                            ],),
                            SizedBox(height: 20,),
                            BlocConsumer<RegisterCubit,RegisterCubitState>(builder: (context, state) {
                              return ElevatedButton(onPressed: (){
                                if(this.form.valid){
                                  context.read<RegisterCubit>().login(context,form.control("first_name").value,form.control("last_name").value,form.control("email").value,form.control("password").value);
                                }
                              }, child: Text("Register"));
                            }, listener: (context, state) {
                              if(state.isAuth == true && state.tokenModel != null){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                              }
                            },),
                            
                          ],
                        )),
              );
                });
              },
            ))),
     );
  }
}