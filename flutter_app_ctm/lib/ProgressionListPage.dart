import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_ctm/ProgressionsList.dart';
import 'package:flutter_app_ctm/main.dart';
import 'package:flutter_app_ctm/pendingListPage.dart';
import 'package:flutter_app_ctm/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProgressionListPage extends StatefulWidget {
  @override
  ProgListPage createState() => new ProgListPage();
}

class ProgListPage extends State<ProgressionListPage> {
  Map<String, String> prog = new Map();
  List<String> progNames = new List();
  @override
  Widget build(BuildContext context) {
    final title = 'Progressions';
    fetchProgressionList();
    progNames.addAll(prog.values);
    if (prog.length <= 0)
      return new Scaffold(
          appBar: AppBar(
            leading: new Image.asset(
                'images/v1-logo.png'),
            title: Text(title),
          ),
          body: new Container(
              constraints: new BoxConstraints.expand(
                height: 900.0,
              ),
              color: Colors.white));
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          leading: new Image.asset(
              'images/v1-logo.png'),
          title: Text(title),
          actions: <Widget>[new PopupMenuButton<String>(
              onSelected: (String value) {
                if (value == 'Logout') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                }
                else if (value == 'Settings') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
                else if (value == 'Manual Activity') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyGetHttpData()),
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                const PopupMenuItem<String>(
                    value: 'Logout',
                    child: Text('Logout')
                ),
                const PopupMenuItem<String>(
                    value: 'Settings',
                    child: Text('Settings')
                ),
                const PopupMenuItem<String>(
                    value: 'Manual Activity',
                    child: Text('Manual Activity')
                ),
              ]
          ),],
        ),
        body: new ListView.builder(
            itemCount: this.prog == null ? 0 : this.prog.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                  child: new Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(prog.values.elementAt(index)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Progressions(progId: prog.keys.elementAt(index))),
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
    Map<String, String> progression = new Map();
    for (var prog in data) {
      progression.putIfAbsent(prog["_id"], () => prog["name"]);
    }
    setState(() {
      this.prog = progression;
    });
    return "Success";

  }

  @override
  void initState() {
    super.initState();
    fetchProgressionList();
  }
}