import 'package:drug_info_app/Application/Cubits/home/home_cubit.dart';
import 'package:drug_info_app/Application/Cubits/home/home_cubit_state.dart';
import 'package:drug_info_app/Application/Cubits/login/login_cubit.dart';
import 'package:drug_info_app/Application/Services/drugService.dart';
import 'package:drug_info_app/Application/Services/auth_service.dart';
import 'package:drug_info_app/Application/Services/user_drug_service.dart';
import 'package:drug_info_app/Views/login_page.dart';
import 'package:drug_info_app/core/components/customSnackBar.dart';
import 'package:drug_info_app/core/localization/LocalizationData.dart';
import 'package:drug_info_app/core/utilities/LaunchSettings.dart';
import 'package:drug_info_app/core/utilities/jwt_helper.dart';
import 'package:drug_info_app/models/drugModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() async {
  await GetStorage.init();

              LaunchSettings().Settings();

    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
  final box = GetStorage();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MultiBlocProvider(
  providers: [
  BlocProvider(create: (_) => LoginCubit(LoginService.instance)),
  BlocProvider(create: (_) =>
                  HomeCubit(DrugService.instance, UserDrugService.instance,JwtHelper.instance.getUserIdsync(JwtHelper.instance.getTokenSync()!)!,context))
        ],
        child: GetMaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          locale: box.read('language') == "en"
              ? const Locale('en', 'US')
              : const Locale('tr', 'TR'),
          translations: LocalizationData(),
          theme: box.read("darkMode") as bool
              ? ThemeData.dark().copyWith(
                  primaryColor: Colors.red,
                  textTheme: Theme.of(context).textTheme.apply(
                      displayColor: Colors.white, bodyColor: Colors.white))
              : ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor:const Color(0xFF116A7B)),
                  scaffoldBackgroundColor: const Color(0XFFdedede),
                  useMaterial3: true,
                ),
          home: box.read("isLogin") as bool ? MyHomePage() : LoginPage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  Future<void> _showMyDialog({required context,required DrugModel drugModel}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children:[
              Text(drugModel.drug_name!)
            ],
          ),
        ),
        actions:[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

 final form = FormGroup({
    'name': FormControl<String>(
        validators: []),
  });
  final token = GetStorage().read("token");

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) =>
          HomeCubit(DrugService.instance, UserDrugService.instance,JwtHelper.instance.getUserIdsync(JwtHelper.instance.getTokenSync()!)!,context),
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Color(0xFFCDC2AE),
              actions: [
                BlocSelector<HomeCubit, HomeCubitState, bool>(
                  selector: (state) {
                    return state.isShowTextField;
                  },
                  builder: (context, state) {
                    return BlocBuilder<HomeCubit, HomeCubitState>(
                        builder: (context, state) {
                      if (state.isShowTextField) {
                        return Container();
                      }
                      return Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                context.read<HomeCubit>().changeTextField();
                              },
                              icon: Icon(Icons.search)),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://picsum.photos/250?image=9'),
                            ),
                          ),
                        ],
                      );
                    });
                  },
                )
              ],
              title: BlocSelector<HomeCubit, HomeCubitState, bool>(
                  selector: (state) => state.isShowTextField,
                  builder: (context, state) {
                    return BlocBuilder<HomeCubit, HomeCubitState>(
                        builder: (context, state) {
                      if (state.isShowTextField) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReactiveForm( 
                              formGroup: this.form,
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: ReactiveTextField(
                                    formControlName: 'name',
                                    autocorrect: true,
                                    
                                    decoration: InputDecoration(
                                        hintText: 'Search'.tr,
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ))),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                      if(form.control("name").value != null && form.control("name").value != ""){
                                      context
                                          .read<HomeCubit>()
                                          .changeTextField();

                                      context.read<HomeCubit>().getDrugByName(
                                          context, form.control("name").value);
                                          form.control("name").value = "";
                                      }
                                      else{
                                        CustomSnackBar().show(context, 'Please enter some text');
                                      }
                                      
                                },
                                icon: Icon(Icons.search))
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
                  })),
          body: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0,top:5),
                    child: Text("Last Viewed", style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  BlocSelector<HomeCubit, HomeCubitState, bool>(
                    selector: (state) {
                      return true;
                    },
                    
                    builder: (context, state) {
                      return BlocBuilder<HomeCubit, HomeCubitState>(
                        
                          builder: (context, state) {
                            return state.searchedData == null ?  Text("Last Viewed Data Is Empty",style: GoogleFonts.inter(fontWeight: FontWeight.w500),) : 
                            Padding(
                              padding: const EdgeInsets.only(left:10.0,top: 5),
                              child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color.fromARGB(255, 151, 151, 151)
                                        ),
                                        height: 100,
                                          child: Ink(
                                            width: state.searchedData!.length * 100.0 + 100,
                                              child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: state.searchedData!.length,
                                                    itemBuilder: (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          context.read<HomeCubit>().bottomSheet(drugModel: state.searchedData![index],context: context);
                                                        },
                                                        child:SizedBox(
                                                          width: 100,
                                                          child: Card(
                                                          
                                                              child: Align(
                                                                alignment: Alignment.center,
                                                                child: Text(state
                                                                    .searchedData![index].drug_name!, style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.bold),
                                                                                                            )                                                  )),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                          ),
                                      ),
                            );
                      });
                    },
                  ),
                ],
              )
            ],
          )),
    );
  }
}
