// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_ctm/pendingListPage.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  //debugPaintSizeEnabled = true;
  runApp(new MaterialApp(
  home: new MyApp()));
}

class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
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

    void onButtonClick() {
      print(urlController.text);
      if (_formKey.currentState.validate()) {
        // If the form is valid, we want to show a Snackbar
        validateToken().then((result) {
          print(result);
          if(result == 'success') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PendingListPage()),
            );
          } else {
            final snackBar = SnackBar(content: Text('Error SnackBar!'));
           // Find the Scaffold in the Widget tree and use it to show a SnackBar
          //  Scaffold.of(context).showSnackBar(snackBar);
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
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'enter continuum user token';
                      }
                    },
                    controller: tokenController,
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

    Widget textSection = Center(
      child: Padding(
        padding: new EdgeInsets.only(top:60.0),
          child: Text(
            '''
            Test
            ''',
            softWrap: true,
          )

      )
      ,
    );

    return MaterialApp(
      title: 'Continuum',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Continuum'),
        ),
        body: ListView(
          children: [
            new Padding(
              padding: new EdgeInsets.only(left: 60.0, top: 60.0, right: 60.0, bottom: 0.0),
              child: new Image.asset(
                  'images/collabnet-versionone.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center
              )
            ),
            titleSection,
            loginSection,
            textSection,
          ],
        ),
      ),
    );
  }
}