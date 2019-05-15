// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_ctm/HomePage.dart';
import 'package:flutter_app_ctm/pendingListPage.dart';
import 'package:flutter_app_ctm/ProgressionListPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  //debugPaintSizeEnabled = true;
  runApp(new MaterialApp(
  home: new MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController urlController = new TextEditingController();
  TextEditingController tokenController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          )
        ],
      ),
    );

    Future<String> validateToken() async {
      var url = urlController.text+':8080/api/validate_token?token='+tokenController.text;
      final response =
      await http.get(url,
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        var data = json.decode(response.body)['Response'];
        return data['result'];
      } else {
        // If that response was not OK, throw an error.
        return 'failure';
        //throw Exception('Failed to load post');
      }
    }

    Future storeInstanceAndToken(instanceUrl, token) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("instanceUrl", instanceUrl);
      prefs.setString("token", token);
    }

    Future onButtonClick() {
      if (_formKey.currentState.validate()) {
        // If the form is valid, we want to show a Snackbar
        validateToken().then((result) {
          if(result == 'success') {
            storeInstanceAndToken(urlController.text, tokenController.text);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Invalid instance or token")));
          }
          });
          }
    }

    Widget loginSection = new Padding(
      padding: new EdgeInsets.only(left: 60.0, right: 60.0, top: 0.0, bottom: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Form(
            key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter continuum url';
                      }
                    },
                    controller: urlController,
                    decoration: new InputDecoration(
                          labelText: 'Continuum Instance'
                    )
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter continuum user token';
                      }
                    },
                    controller: tokenController,
                    obscureText: true,
                    decoration: new InputDecoration(
                          labelText: 'Authentication Token'
                    )
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child:
                    RaisedButton(
                      padding: const EdgeInsets.all(16.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: onButtonClick,
                      child: new Text("Login"),
                    )
                  ),

                ],

              ),
              )
        ],
      ),
    );

    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: new Center(child: new Text('Login', textAlign: TextAlign.center)),
        ),
        body: ListView(
          children: [
            new Padding(
              padding: new EdgeInsets.only(left: 60.0, top: 60.0, right: 60.0, bottom: 0.0),
              child: new Column(
                  children: <Widget>[new Image.asset(
                  'images/continuum-logo.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
              )])
            ),
            titleSection,
            loginSection,
          ],
        ),
      ),
    );
  }
}