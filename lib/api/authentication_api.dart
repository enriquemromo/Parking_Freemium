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
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult.user != null;
    } catch (e) {
      print(e.message);
      return false;
    }
  }
}
