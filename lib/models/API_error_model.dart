class APIErrorModel {
  late String Type;
  late String Title;
  late int Status;
  late String Detail;

  APIErrorModel({
    required this.Type,
    required this.Title,
    required this.Status,
    required this.Detail,
  });

  APIErrorModel.fromJson(Map<String, dynamic> json) {
    Type = json['Type'];
    Title = json['Title'];
    Status = json['Status'] as int;
    Detail = json['Detail'];
  }
}