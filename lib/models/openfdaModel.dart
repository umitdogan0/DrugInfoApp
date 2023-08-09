// ignore_for_file: public_member_api_docs, sort_constructors_first
class OpenfdaModel {
  final List<String?>? manufacturer_name;
  final List<String?>? rxcui;
  final List<String?>? spl_set_id;
  final List<bool?>? is_original_packager;
  final List<String?>? nui;
  final List<String?>? pharm_class_moa;
  final List<String?>? pharm_class_cs;
  final List<String?>? pharm_class_epc;
  final  List<String?>? unii;
  OpenfdaModel({
    this.manufacturer_name,
    this.rxcui,
    this.spl_set_id,
    this.is_original_packager,
    this.nui,
     this.pharm_class_moa,
     this.pharm_class_cs,
     this.pharm_class_epc,
    this.unii,
  });

  factory OpenfdaModel.fromJson(Map<dynamic,dynamic> json){
    final manufacturer_nameList = (json['manufacturer_name'] as List<dynamic>)
      .map((dynamic item) => item as String?)
      .toList();
      final rxcuiList =json['rxcui'] == null ? null : (json['rxcui'] as List<dynamic>)
      .map((dynamic item) => item as String?)
      .toList();
      final spl_set_idList = json['spl_set_id'] == null ? null :(json['spl_set_id'] as List<dynamic>)
      .map((dynamic item) => item as String?)
      .toList();
      final is_original_packagerList =json['is_original_packager']==null ? null :  (json['is_original_packager'] as List<dynamic>)
      .map((dynamic item) => item as bool?)
      .toList();
      final nuiList =json['nui'] == null ? null :  (json['nui'] as List<dynamic>)
      .map((dynamic item) => item as String?).toList();
      final pharm_class_moaList =json['pharm_class_moa'] == null ? null :  (json['pharm_class_moa'] as List<dynamic>)
      .map((dynamic item) => item as String?)
      .toList();
      final pharm_class_csList =json['pharm_class_cs'] == null ? null :  (json['pharm_class_cs'] as List<dynamic>)
      .map((dynamic item) => item as String?)
      .toList();
      final pharm_class_epcList = json['pharm_class_epc'] == null ? null : (json['pharm_class_epc'] as List<dynamic>)
      .map((dynamic item) => item as String?)
      .toList();
      final uniiList = json['unii'] == null ? null :(json['unii'] as List<dynamic>)
      .map((dynamic item) => item as String?)
      .toList();
    return OpenfdaModel(is_original_packager: is_original_packagerList, manufacturer_name: manufacturer_nameList, nui: nuiList, pharm_class_cs: pharm_class_csList, pharm_class_epc: pharm_class_epcList, pharm_class_moa: pharm_class_moaList, rxcui: rxcuiList, spl_set_id: spl_set_idList, unii: uniiList);
  }
}
