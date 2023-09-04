class GetAllViewedDto {
  final String? drug_name;

  GetAllViewedDto({
  this.drug_name,
});

  factory GetAllViewedDto.fromJson(Map<String, dynamic> json) {
    return GetAllViewedDto(
      drug_name: json['drug_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drug_name': drug_name,
    };
  }
}

