import 'package:get/get.dart';

class HomePageController extends GetxController {
  var isShowTextField = false.obs;
   void changeShowTextField() {
    this.isShowTextField.value = !this.isShowTextField.value;
    
    update();
  }
}