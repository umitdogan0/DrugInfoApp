// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drug_info_app/models/activeIngredientModel.dart';
import 'package:drug_info_app/models/openfdaModel.dart';
import 'package:drug_info_app/models/packagingModel.dart';

class DrugModel {
  final String? drug_name;
  final String? product_ndc;
  final String? generic_name;
  final String? labeler_name;
  final String? brand_name;
  final List<ActiveIngredientModel>? active_ingredients;
  final bool? finished;
  final List<PackagingModel>? packaging;
  final String? listing_expiration_date;
  final OpenfdaModel? openfda;
  final String? marketing_category;
  final String? dosage_form;
  final String? spl_id;
  final String? product_type;
  final List<String?>? route;
  final String? marketing_start_date;
  final String? product_id;
  final String? application_number;
  final String? brand_name_base;
  final List<String?>? pharm_class;
  DrugModel(
     this.drug_name,
     this.product_ndc,
     this.generic_name,
     this.labeler_name,
     this.brand_name,
     this.active_ingredients,
     this.finished,
     this.packaging,
     this.listing_expiration_date,
     this.openfda,
     this.marketing_category,
     this.dosage_form,
     this.spl_id,
     this.product_type,
     this.route,
     this.marketing_start_date,
     this.product_id,
     this.application_number,
     this.brand_name_base,
     this.pharm_class,
  );

  factory DrugModel.fromJson(Map<dynamic,dynamic> json){
    var AIlist = json["active_ingredients"] == null ? null : (json["active_ingredients"] as List<dynamic>).map((e) => ActiveIngredientModel.fromJson(e)).toList();
    var Plist = json["packaging"] == null ? null : (json["packaging"] as List<dynamic>).map((e) => PackagingModel.fromJson(e)).toList() ;
    final routeList = json['route']==null ? null :  (json['route'] as List<dynamic>)
      .map((dynamic item) => item as String?)
      .toList();

    final pharmClassList =json['pharm_class']==null ? null :  (json['pharm_class'] as List<dynamic>)
        .map((dynamic item) => item as String?)
        .toList();

    return DrugModel(json["drug_name"], json["product_ndc"], json["generic_name"],  json["labeler_name"],  json["brand_name"],  AIlist,  json["finished"],  Plist,  json["listing_expiration_date"],  OpenfdaModel.fromJson(json["openfda"]),  json["marketing_category"],  json["dosage_form"],  json["spl_id"],  json["product_type"],  routeList,  json["marketing_start_date"],  json["product_id"],  json["application_number"],  json["brand_name_base"],pharmClassList);
  }
}
