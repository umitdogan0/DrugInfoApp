import 'package:drug_info_app/Application/Cubits/login/login_cubit.dart';
import 'package:drug_info_app/Application/Cubits/login/login_cubit_state.dart';
import 'package:drug_info_app/Application/Cubits/profile/profile_cubit.dart';
import 'package:drug_info_app/Application/Cubits/profile/profile_cubit_state.dart';
import 'package:drug_info_app/Views/SettingsPage.dart';
import 'package:drug_info_app/Views/UpdateProfileScreen.dart';
import 'package:drug_info_app/Views/ProfileMenuWidget.dart';
import 'package:drug_info_app/Views/login_page.dart';
import 'package:drug_info_app/core/utilities/local_storage.dart';
import 'package:drug_info_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  
 ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final box = LocalStorage.instance;
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.arrowtriangle_left)),
        title: Text("tProfile"),
        actions: [IconButton(onPressed: () {context.read<ProfileCubit>().change();}, icon: Icon(box.darkMode()  ? CupertinoIcons.sun_min_fill : CupertinoIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [

              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: const Image(image: NetworkImage("https://picsum.photos/250?image=9"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        CupertinoIcons.pencil_circle,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("tProfileHeading"),
              Text("tProfileSubHeading"),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("tEditProfile", style: TextStyle()),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(title: "Settings", icon: CupertinoIcons.cloud_fog, onPress: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingsPage()));}),
              ProfileMenuWidget(title: "Billing Details", icon: CupertinoIcons.waveform_circle, onPress: () {}),
              ProfileMenuWidget(title: "User Management", icon: CupertinoIcons.checkmark_alt_circle, onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: CupertinoIcons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: CupertinoIcons.question_diamond,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: (){
                            context.read<LoginCubit>().logout(context);
                            
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                          child: const Text("Yes"),
                        ),
                      ),
                      cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                    );
                  }),
            ],
          ),
        ),
      )
    );
  }
}