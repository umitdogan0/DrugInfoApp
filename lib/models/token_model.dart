
class TokenModel {
  final String token;
  final String refreshToken;
  final DateTime expirationDate;
  final String clientId;
  TokenModel({
    required this.token,
    required this.refreshToken,
    required this.expirationDate,
    required this.clientId,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json){
    return TokenModel(
      token: json['token'],
      refreshToken: json['refreshTokenValue'],
      expirationDate: DateTime.parse(json['tokenExpiration']),
      clientId: json['client'],
    );
  }
}
