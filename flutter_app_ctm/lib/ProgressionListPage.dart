import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_ctm/ProgressionsList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProgressionListPage extends StatefulWidget {
  @override
  ProgListPage createState() => new ProgListPage();
}

class ProgListPage extends State<ProgressionListPage> {
  List<String> prog = new List();
  @override
  Widget build(BuildContext context) {
    final title = 'Progressions';
    fetchProgressionList();
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          leading: new Image.asset(
              'images/v1-logo.png'),
          title: Text(title),
        ),
        body: new ListView.builder(
            itemCount: this.prog == null ? 0 : this.prog.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                  child: new Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(this.prog[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Progressions()),
                            );
                          },
                        ),
                        ]
                  )
                  )
              );
            }
        ),
      ),
    );
  }

    Future<String> fetchProgressionList() async {
    final prefs = await SharedPreferences.getInstance();
    final instanceUrl = prefs.get("instanceUrl");
    final token = prefs.get("token");
    final response = await http.get(
        instanceUrl+':8080/api/list_progressions',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token "+token
        });
    Iterable data = json.decode(response.body)['Response'];
    List<String> progression = new List();
    for (var prog in data) {
      progression.add(prog["name"]);
    }
    setState(() {
      this.prog = progression;
    });
    return "Success";

  }

  @override
  void initState() {
    super.initState();
  }
}