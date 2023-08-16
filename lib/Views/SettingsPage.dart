import 'package:drug_info_app/Views/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final box = GetStorage();
  bool? isDark;
  @override
  void initState() {
    super.initState();
    
    
    isDark = box.read("darkMode")!;
    print(isDark);
    getLanguage();
  }

  String? language_code;
  
  void getLanguage() {
    var language1 = box.read("language");
    language_code = language1;
  }

  String getLanguageName() {
    if (language_code == "en") {
      return "English";
    } else {
      return "Türkçe";
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Save"),
      onPressed: () {
        setState(() {
          if (language_code == "en") {
            Get.updateLocale(const Locale('en', 'US'));
            box.write("language", "en");
            Navigator.of(context).pop();
          } else {
            Get.updateLocale(const Locale('tr', 'TR'));
            box.write("language", "tr");
            Navigator.of(context).pop();
          }
        });
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text("AlertDialog"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  title: Text("English"),
                  value: "en",
                  groupValue: language_code,
                  onChanged: (value) {
                    setState(() {
                      language_code = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text("Türkçe"),
                  value: "tr",
                  groupValue: language_code,
                  onChanged: (value) {
                    setState(() {
                      language_code = value.toString();
                    });
                  },
                ),
              ],
            ),
            actions: [
              cancelButton,
              continueButton,
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".tr),
        leading: IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage())), icon: const Icon(CupertinoIcons.arrowtriangle_left)),
      ),
      body: Column(
        children: [ 
        languageContainer(context),
        SizedBox(height: 20,),
        ],
      ),
    );
  }

  Center languageContainer(BuildContext context) {
    return Center(
      child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                      color:Get.isDarkMode  ? Color.fromARGB(179, 117, 113, 113) : Color(0XFFEDEDED), borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text(
                              "Language_ref".tr,
                              style: GoogleFonts.inter(),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            getLanguageName(),
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 20),
                        child: GestureDetector(
                            onTap: (() {
                              showAlertDialog(context);
                            }),
                            child: Text("Edit".tr,
                                style: GoogleFonts.firaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5A96E3)))),
                      )
                    ],
                  ),
                ),
    );
  }
  Switch themeSwitch(){
    return Switch(
      value: isDark!,
      onChanged: (value) {
        setState(() {
          isDark = value;
          box.write("darkMode", value);
          //  Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
           Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
           print(Theme.of(context).colorScheme.background.hashCode);
        });
      },
    );
  }
  Center themeContainer(){
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration (
            color:Get.isDarkMode  ? Color.fromARGB(179, 117, 113, 113) : Color(0XFFEDEDED), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Text(
                "White Theme".tr,
                style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
              ),
            ),
            themeSwitch(),
          ],
        ),
      ),
    );
  }
}