import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingfreemium/api/authentication_api.dart';
import 'package:parkingfreemium/model/login_response.dart';
import 'package:parkingfreemium/page/home_page.dart';
import 'package:parkingfreemium/page/signup_Page.dart';
import 'package:parkingfreemium/page/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../theme.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageStatelessWidget createState() => LoginPageStatelessWidget();
}

class LoginPageStatelessWidget extends State<LoginPage> {
  String errorMessageUsername = null;
  String errorMessagePassword = null;
  TextEditingController _usernameTextEditingController =
      TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Log In"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  top: 20,
                  right: 40,
                  bottom: 20,
                ),
                child: TextField(
                  controller: _usernameTextEditingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    hintText: 'Username',
                    errorText: errorMessageUsername,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  top: 20,
                  right: 40,
                  bottom: 20,
                ),
                child: TextField(
                  controller: _passwordTextEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    hintText: 'Password',
                    errorText: errorMessagePassword,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () async {
                    if (_usernameTextEditingController.text.isEmpty ||
                        _passwordTextEditingController.text.isEmpty) {
                      if (_usernameTextEditingController.text.isEmpty) {
                        errorMessageUsername = "Invalid username";
                      }

                      if (_passwordTextEditingController.text.isEmpty) {
                        errorMessagePassword = "Invalid password";
                      }
                      setState(() {});
                    } else {
                      final Future<LoginResponse> loginResponse =
                          AuthenticationApi.login(
                              _usernameTextEditingController.text,
                              _passwordTextEditingController.text);

                      loginResponse.then((value) {
                        _saveLoggedUser(_usernameTextEditingController.text,
                            _passwordTextEditingController.text, value.token);
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => HomePage()));
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _saveLoggedUser(
      String username, String password, String token) async {
    UserModel user = new UserModel();
    user.userName = username;
    user.password = password;
    user.token = token;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user", json.encode(user));
  }
}
