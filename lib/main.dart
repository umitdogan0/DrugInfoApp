import 'package:drug_info_app/Controllers/HomePageController.dart';
import 'package:drug_info_app/Routers/AppRoutes.dart';
import 'package:drug_info_app/Views/SettingsPage.dart';
import 'package:drug_info_app/core/localization/LocalizationData.dart';
import 'package:drug_info_app/core/utilities/LaunchSettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  await GetStorage.init();
  LaunchSettings().Settings();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  final box = GetStorage();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      locale: box.read('language') == "en" ? const Locale('en', 'US') : const Locale('tr', 'TR'),
      translations: LocalizationData(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        scaffoldBackgroundColor: const Color(0XFFdedede),
        useMaterial3: true,
        
        
      ),
      home: SettingsPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  var isShow = false;
  var controller =  HomePageController();
  final TextEditingController searchController = TextEditingController();
  MyHomePage({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF5A96E3),
          actions: [
            Obx(() {
              if(!controller.isShowTextField.value){
                return Visibility(
              child: Row(
               mainAxisSize: MainAxisSize.min, 
                children: [
                  Text("Search".tr),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://picsum.photos/250?image=9'),
                    ),
                  ),
                 
                ],
              ),
              visible: !controller.isShowTextField.value,
            );
              }
              else{
                return SizedBox();
              }
              })
            
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                  width: 250,
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: TextField(
                      style: TextStyle(height: 0.5),
                      decoration:new InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        hintText: 'Search'.tr,
                        prefixIcon: Icon(Icons.search,color: Color(0xFF0A6EBD),),
                      ),
                    ),
                  ),
              ),
            ),
            ElevatedButton(onPressed: ((){
              Get.to(SettingsPage());
            }), child: Text("bas"))
            
          ],
        ));
}
}