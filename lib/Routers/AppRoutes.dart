import 'package:drug_info_app/Controllers/HomePageController.dart';
import 'package:drug_info_app/Controllers/SettingsPageController.dart';
import 'package:drug_info_app/Views/SettingsPage.dart';
import 'package:drug_info_app/main.dart';
import 'package:get/get.dart';

appRoutes()=>[
  GetPage<MyHomePage>(name: '/', page:()=> MyHomePage(),
  binding: BindingsBuilder(() { 
    Get.lazyPut<HomePageController>(() => HomePageController());
  }),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(milliseconds: 500)
   ),
  GetPage<SettingsPage>(name: '/setting', page:()=> SettingsPage(),
  binding: BindingsBuilder(() { 
    Get.lazyPut<SettingsPageController>(() => SettingsPageController());
  }),
  transition: Transition.leftToRightWithFade,
  transitionDuration: Duration(milliseconds: 500)
   )
];