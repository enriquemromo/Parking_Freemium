import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AuthenticationApi {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<FirebaseUser> login(String email, String password) async {
    FirebaseUser user;
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
    } catch (e) {
      print(e.message);
    }
    return user;
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
