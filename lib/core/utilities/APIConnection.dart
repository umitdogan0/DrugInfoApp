// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiConnection {
  ApiConnection._();
  static ApiConnection? _instance; 

  static ApiConnection get instance {
    _instance ??= ApiConnection._();
    return _instance!;
  }
  String url = "https://druginfoud.azurewebsites.net/api/";


  String nodeUrl = "https://druginfo.onrender.com/graphql";
  
}
