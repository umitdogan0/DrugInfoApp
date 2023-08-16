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
      'White Theme':'White Theme',
      'Loading':'Loading',
      "Last Viewed" : "Last Viewed",
      "Last Viewed Data Is Empty" : "Last Viewed Data Is Empty",
    },
    'tr_TR':{
      'Search':'arama yap',
      'Settings':'Ayarlar',
      'English':'İngilizce',
      'Language_ref':'Dil Tericihi',
      'Edit':'Düzenle',
      'White Theme':'Beyaz Tema',
      'Loading':'Yükleniyor',
      "Last Viewed" : "Son Görüntülenen",
      "Last Viewed Data Is Empty" : "Son Görüntülenen Veri Boş",
    }
  };
  
}