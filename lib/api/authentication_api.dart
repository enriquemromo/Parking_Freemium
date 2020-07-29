import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:parkingfreemium/model/login_response.dart';

class AuthenticationApi {
  static Future<LoginResponse> login(String username, String password) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode({'username': username, 'password': password});
    final response = await http.post('http://localhost:8080/v1/api/auth/login',
        body: body, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }

    return null;
  }

  static Future<bool> signUp(String name, String lastName, String email,
      String username, String password) async {
    var body = jsonEncode({
      'name': name,
      'lastName': lastName,
      'email': email,
      'username': username,
      'password': password
    });
    Map<String, String> headers = {"Content-Type": "application/json"};
    final response = await http.post('http://localhost:8080/v1/api/auth/signup',
        body: body, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load post');
    }
    return false;
  }
}
