import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SettingsPageController extends GetxController {
  late var isSelectedLanguage = "english".obs;
  void changeLanguage(String language) {
    this.isSelectedLanguage.value = language;
    print(isSelectedLanguage.value);
    update();
  }
}