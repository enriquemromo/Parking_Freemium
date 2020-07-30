import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingfreemium/api/authentication_api.dart';

import 'login_page.dart';

class SignInPage extends StatefulWidget {
  @override
  SignInPageStatelessWidget createState() => SignInPageStatelessWidget();
}

class SignInPageStatelessWidget extends State<SignInPage> {
  String nameErrorMessage = null;
  String lastNameErrorMessage = null;
  String emailErrorMessage = null;
  String userNameErrorMessage = null;
  String passwordErrorMessage = null;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Sign In"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Personal Data',
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  top: 20,
                  right: 40,
                  bottom: 20,
                ),
                child: TextField(
                  controller: _nameController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    hintText: 'Name',
                    errorText: nameErrorMessage,
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
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    hintText: 'Last Name',
                    errorText: lastNameErrorMessage,
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
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    hintText: 'Email',
                    errorText: emailErrorMessage,
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
                  controller: _userNameController,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    hintText: 'Username',
                    errorText: userNameErrorMessage,
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
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    errorText: passwordErrorMessage,
                    hintText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty ||
                        _lastNameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _userNameController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      if (_nameController.text.isEmpty) {
                        nameErrorMessage = "Invalid value";
                      }
                      if (_lastNameController.text.isEmpty) {
                        lastNameErrorMessage = "Invalid value";
                      }
                      if (_emailController.text.isEmpty) {
                        emailErrorMessage = "Invalid value";
                      }
                      if (_userNameController.text.isEmpty) {
                        userNameErrorMessage = "Invalid value";
                      }
                      if (_passwordController.text.isEmpty) {
                        passwordErrorMessage = "Invalid value";
                      }
                      setState(() {});
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: new Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                new CircularProgressIndicator(),
                                new Text("Loading"),
                              ],
                            ),
                          );
                        },
                      );

                      final bool response = await AuthenticationApi.signUp(
                          _nameController.text,
                          _lastNameController.text,
                          _emailController.text,
                          _userNameController.text,
                          _passwordController.text);
                      print(response);
                      Navigator.pop(context);

                      if (response) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          )),
        ));
  }
}
