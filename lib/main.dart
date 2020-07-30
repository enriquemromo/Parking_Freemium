import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkingfreemium/page/home_page.dart';
import 'package:parkingfreemium/page/login_page.dart';
import 'package:parkingfreemium/page/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ParkingFreemiumApp());
}

class ParkingFreemiumApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _isLogged(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return drawViewMain(snapshot.data ? HomePage() : LoginPage());
          } else if (snapshot.hasError) {
            return drawViewMain(LoginPage());
          }
          return Center(
            child: Container(child: CircularProgressIndicator()),
          );
        });
  }

  Future<bool> _isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(json.decode(prefs.getString("user")));
    return user != null && user.token.isNotEmpty;
  }

  MaterialApp drawViewMain(StatefulWidget view) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
