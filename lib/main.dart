import 'dart:ui';

import 'package:drug_info_app/Application/Cubits/home/home_cubit.dart';
import 'package:drug_info_app/Application/Cubits/home/home_cubit_state.dart';
import 'package:drug_info_app/Application/Cubits/login/login_cubit.dart';
import 'package:drug_info_app/Application/Cubits/profile/profile_cubit.dart';
import 'package:drug_info_app/Application/Cubits/profile/profile_cubit_state.dart';
import 'package:drug_info_app/Application/Services/drugService.dart';
import 'package:drug_info_app/Application/Services/auth_service.dart';
import 'package:drug_info_app/Application/Services/user_drug_service.dart';
import 'package:drug_info_app/Views/ProfilePage.dart';
import 'package:drug_info_app/Views/login_page.dart';
import 'package:drug_info_app/core/components/customSnackBar.dart';
import 'package:drug_info_app/core/localization/LocalizationData.dart';
import 'package:drug_info_app/core/utilities/LaunchSettings.dart';
import 'package:drug_info_app/core/utilities/graphql_init.dart';
import 'package:drug_info_app/core/utilities/jwt_helper.dart';
import 'package:drug_info_app/core/utilities/local_storage.dart';
import 'package:drug_info_app/models/drugModel.dart';
import 'package:drug_info_app/models/dtos/getall_viewed_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
          BlocProvider(create: (_) => ProfileCubit()),
          BlocProvider(
              create: (_) => HomeCubit(
                  DrugService.instance,
                  UserDrugService.instance,
                  JwtHelper.instance
                      .getUserIdsync(JwtHelper.instance.getTokenSync()!)!,
                  context))
        ],
        child: BlocBuilder<ProfileCubit, ProfileCubitState>(
          builder: (context, state) {
            return GraphQLProvider(
              client: GraphqlInit().setup(),
              child: GetMaterialApp(
                title: 'Flutter Demo',
                initialRoute: '/',
                debugShowCheckedModeBanner: false,
                locale: box.read('language') == "en"
                    ? const Locale('en', 'US')
                    : const Locale('tr', 'TR'),
                translations: LocalizationData(),
                themeMode: box.read("darkMode") as bool
                    ? ThemeMode.dark
                    : ThemeMode.light,
                darkTheme: ThemeData.dark().copyWith(
                  primaryColor: Colors.red,
                  textTheme: Theme.of(context).textTheme.apply(
                      displayColor: Colors.white, bodyColor: Colors.white),
                  useMaterial3: true,
                ),

                theme: ThemeData.light().copyWith(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: const Color(0xFF116A7B)),
                  scaffoldBackgroundColor: const Color(0XFFdedede),
                  textTheme: Theme.of(context).textTheme.apply(
                      fontSizeFactor: 1.0,
                      displayColor: Colors.black,
                      bodyColor: Colors.black),
                  useMaterial3: true,
                ),
                home: box.read("isLogin") ? const MyHomePage() : LoginPage(),
                //box.read("isLogin") ? const MyHomePage() : LoginPage()
              ),
            );
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String query = """
query {
  getAllUsers{
    drug_name
  }
}
""";

  PreferredSizeWidget _buildBlurredAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent
                  .withOpacity(0.1), // Adjust the opacity as needed
            ),
          ),
        ),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      child: const Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://picsum.photos/250?image=9'),
                        ),
                      ),
                    ),
                  ],
                );
              });
            },
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              child: SearchBar(
                controller: deneme,
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (deneme.text != null && deneme.text != "") {
                  context.read<HomeCubit>().changeTextField();

                  context.read<HomeCubit>().getDrugByName(context, deneme.text);
                  deneme.text = "";
                } else {
                  CustomSnackBar().show(context, 'Please enter some text');
                }
              },
            ),
          ],
        ));
  }

  Future<void> _showMyDialog(
      {required context, required DrugModel drugModel}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [Text(drugModel.drug_name!)],
            ),
          ),
          actions: [
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
    'name': FormControl<String>(validators: []),
  });

  var deneme = TextEditingController();
  final token = GetStorage().read("token");

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(
            DrugService.instance,
            UserDrugService.instance,
            JwtHelper.instance
                .getUserIdsync(JwtHelper.instance.getTokenSync()!)!,
            context),
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: _buildBlurredAppBar(context),
            body: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 60),
                      child: Text(
                        "Last Viewed".tr,
                        style: GoogleFonts.inter(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    BlocBuilder<HomeCubit, HomeCubitState>(
                            builder: (context, state) {
                          return Query(
                            options: QueryOptions(document: gql(query)),
                            builder: (result, {fetchMore, refetch}) {
                              if (result.hasException) {
                                CustomSnackBar().show(context,result.exception.toString());
                              }
                               var rowData =
                                  result.data?["getAllUsers"] as List<dynamic>?;
                             
                             
                              return rowData == null ?   Text("Last Viewed Data Is Empty".tr,style: GoogleFonts.inter(fontWeight: FontWeight.w500),) : LastViewedWidget(data : rowData.map((e) => GetAllViewedDto.fromJson(e)).toList());
                            },
                          );
                        })
                  ],
                )
              ],
            )));
  }

  Container LastViewedWidget({required List<GetAllViewedDto> data }) {
    return Container(
                              
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromARGB(255, 151, 151, 151)
                                      ),
                                      height: 100,
                                        child: Ink(
                                          width: data.length * 100.0 + 100,
                                            child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: data.length,
                                                  itemBuilder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        context.read<HomeCubit>().getDrugByName(context, data[index].drug_name!);
                                                      },
                                                      child:SizedBox(
                                                        width: 100,
                                                        child: Card(
                                                        
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: Text(data[index].drug_name!, style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.bold),
                                                                                                          )                                                  )),
                                                      ),
                                                    );
                                                  },
                                                ),
                                        ),
                                    );
  }
}
