import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_ctm/PendingActivity.dart';
import 'package:http/http.dart' as http;

class PendingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            fetchPost();
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
  Future<List<PendingActivity>> fetchPost() async {
    final response =
    await http.get('http://cu057.cloud.maa.collab.net:8080/api/list_pending_activities',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token 5b6924a166c708309d0db3db"
        });

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Iterable data = json.decode(response.body)['Response'];
      List<PendingActivity> activites = data.map((activity)=> PendingActivity.fromJson(activity)).toList();
       return activites;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}