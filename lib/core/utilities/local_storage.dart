import 'package:get_storage/get_storage.dart';

class LocalStorage {
   LocalStorage._();
  static LocalStorage? _instance;
  static LocalStorage get instance {
    _instance ??= LocalStorage._();
    return _instance!;
  }
  final box = GetStorage();

  void write(String key, dynamic value){
    box.writeInMemory(key, value);
  }

  Future<void> writeAsync(String key, dynamic value) async{
    write(key, value);
    
  }

  void read(String key){
    box.read(key);
  }

  Future<dynamic> readAsync(String key) async{
     return await box.read(key);
  }

  bool darkMode(){
    return box.read("darkMode") as bool;
  }

  void deleteAll(){
    box.erase();
  }

  Future<void> deleteAllAsync() async{
   await box.erase();
  }
}