import 'package:drug_info_app/Application/Cubits/login/login_cubit.dart';
import 'package:drug_info_app/Application/Cubits/login/login_cubit_state.dart';
import 'package:drug_info_app/Application/Services/drugService.dart';
import 'package:drug_info_app/Application/Services/auth_service.dart';
import 'package:drug_info_app/Views/login_page.dart';
import 'package:drug_info_app/core/components/customSnackBar.dart';
import 'package:drug_info_app/core/localization/LocalizationData.dart';
import 'package:drug_info_app/core/utilities/LaunchSettings.dart';
import 'package:drug_info_app/models/drugModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

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
    return MultiBlocProvider(providers: [BlocProvider(create:(_) => LoginCubit(LoginService.instance))], child: GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      locale: box.read('language') == "en"
          ? const Locale('en', 'US')
          : const Locale('tr', 'TR'),
      translations: LocalizationData(),
      theme: box.read("darkMode") as bool ?
      ThemeData.dark().copyWith(
              primaryColor: Colors.red,
              textTheme: Theme.of(context)
                  .textTheme
                  .apply(displayColor: Colors.white, bodyColor: Colors.white))
          : ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
              scaffoldBackgroundColor: const Color(0XFFdedede),
              useMaterial3: true,
            ),
      home:box.read("isLogin") as bool ? MyHomePage() : LoginPage(),
      
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late Future<DrugModel> drug;
  @override
  void initState() {
    super.initState();
      if(searchController.value.text != null) {
        drug = getDrugByName(searchController.value.text);
      }
      else {
        drug = getDrugByName("advil");
      }
  }

  var isClick = false;
  DrugModel? model;
  var isShowTextField = false;
  TextEditingController searchController = TextEditingController();

  void changeShowTextField() {
    isShowTextField = !isShowTextField;
  }

  Future<DrugModel> getDrugByName(name) async {
    var service = await DrugService().getDrugByName(name: name);
    return service.when((success) {
      print("success");
      return success;
    }, (error) {
      print(error.toString());
      CustomSnackBar().show(context, error);
      throw Exception(error.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF5A96E3),
            actions: [isShowTextField ? 
                  Container() : Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                               changeShowTextField();
                            });
                           
                          },
                          icon: Icon(Icons.search)),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://picsum.photos/250?image=9'),
                        ),
                      ),
                    ],
                  )
            ],
            title: isShowTextField
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: TextField(
                            controller: searchController,
                            autocorrect: true,
                            decoration: InputDecoration(
                                hintText: 'Search'.tr,
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ))),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                            changeShowTextField();
                             drug= getDrugByName(searchController.value.text);
                             print("ofof ${searchController.value.text}");
                            isClick = true;
                            },);
                            
                          },
                          icon: Icon(Icons.search))
                    ],
                  )
                : Container()),
        body: Column(
          children: [
              FutureBuilder(future:drug ,builder: (context,snapshot) {
                print(snapshot.data);
                if(snapshot.hasData){
                return SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                          width: 200,
                          child:Card(child: Text(snapshot.data!.drug_name!)),
                           
                          ),
                    );
                  },
                ),
              );
                }
                else {
                  return Text(snapshot.error.toString());
                }
              }),
            
          ],
        ));
  }
}
