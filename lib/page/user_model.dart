class UserModel {
  String userName;
  String password;
  String token;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        password = json['password'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'password': password,
        'token': token,
      };
}
