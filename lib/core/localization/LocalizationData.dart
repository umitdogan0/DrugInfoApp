import 'package:get/get.dart';

class LocalizationData extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US':{
      'Search':'do search',
      'Settings':'Settings',
      'English':'English',
      'Language_ref':'Language',
      'Edit':'Edit',
      'Loading':'Loading'
    },
    'tr_TR':{
      'Search':'arama yap',
      'Settings':'Ayarlar',
      'English':'İngilizce',
      'Language_ref':'Dil Tericihi',
      'Edit':'Düzenle',
      'Loading':'Yükleniyor'
    }
  };
  
}