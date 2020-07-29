class LoginResponse {
  String token;
  String refreshToken;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        refreshToken = json['refreshToken'];

  Map<String, dynamic> toJson() =>
      {'token': token, 'refreshToken': refreshToken};
}
