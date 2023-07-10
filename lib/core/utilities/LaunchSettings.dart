import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class LaunchSettings {
  void Settings() {
    // OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);

    // OneSignal.shared.setAppId("ffb3d8b2-1f64-45f5-b70c-7cdc7cc18689");
    // OneSignal.shared
    //     .promptUserForPushNotificationPermission()
    //     .then((accepted) {});

    // var device = await OneSignal.shared.getDeviceState();

    final box = GetStorage();
    
    var firstOpen = box.read('firstOpen') ?? true;
    
    if(firstOpen){
      box.write("language", Get.locale?.languageCode ?? "en");
      box.write("darkMode", false);
      box.write("isLogin", false);
      box.write("firstOpen", false);
      
    }
    // if(firstOpen == true){
    //   sp.setBool("notipermission", true);
    //   sp.setBool("notiemail", true);
    //   sp.setBool("firstOpen", false);
    // }
    // print(device!.userId.toString());
    // DeviceIdService().addDevice(device!.userId.toString());
  }
}