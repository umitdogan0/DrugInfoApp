// ignore_for_file: public_member_api_docs, sort_constructors_first
class ActiveIngredientModel {
  final String? name;
  final String? strength;
  ActiveIngredientModel(
     this.name,
     this.strength,
      );

  factory ActiveIngredientModel.fromJson(Map<dynamic,dynamic> json){
    return ActiveIngredientModel(json["name"], json["strength"]);
  }
}
