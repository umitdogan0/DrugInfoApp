// ignore_for_file: public_member_api_docs, sort_constructors_first
class PackagingModel {
  final String? package_ndc;
  final String? description;
  final String? marketing_start_date;
  final bool? sample;
  PackagingModel(
     this.package_ndc,
     this.description,
     this.marketing_start_date,
     this.sample,
  );

  factory PackagingModel.fromJson(Map<dynamic,dynamic> json){
    return PackagingModel(json["package_ndc"], json["description"], json["marketing_start_date"], json["sample"] as bool);
  }
}
