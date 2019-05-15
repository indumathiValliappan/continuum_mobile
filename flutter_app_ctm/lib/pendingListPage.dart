import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_ctm/PendingActivity.dart';
import 'package:flutter_app_ctm/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyGetHttpData extends StatefulWidget {
  @override
  PendingListPage createState() => new PendingListPage();
}

class PendingListPage extends State<MyGetHttpData> {
  List<PendingActivity> data;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(
            title: new Center(child: new Text('My Activities', textAlign: TextAlign.center)),
              actions: <Widget>[
                new PopupMenuButton<String>(
                    onSelected: (String value) {
                      if (value == 'Logout') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      }
                      },
                    itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                      const PopupMenuItem<String>(
                          value: 'Logout',
                          child: Text('Logout')
                      ),
                    ]
                ),
              ]),
          // Create a Listview and load the data when available
          body: new ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  child: new Center(
                      child: new Column(
                        // Stretch the cards in horizontal axis
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Card(
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new ListTile(
                                  title: new Text(
                                    data[index].name + ' - ' + data[index].phase_name,
                                    style: new TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: new Text(
                                      data[index].details.title +
                                          ' - ' +
                                          data[index].details.text,
                                      style: new TextStyle(fontSize: 16.0)),
                                ),
                                new ButtonTheme.bar(
                                  // make buttons use the appropriate styles for cards
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Padding(
                                          padding:const EdgeInsets.only(left: 20.0),
                                          child:
                                          new Text(data[index].full_version,
                                              textAlign: TextAlign.center,
                                              style: new TextStyle(fontSize: 16.0))
                                      ),
                                      new Row(children: <Widget>[
                                        new IconButton(
                                          icon: new Icon(Icons.check),
                                          tooltip: 'Approve',
                                          color: Colors.green,
                                          iconSize: 30.0,
                                          onPressed: () {
                                            setActivityStatus("success", index);
                                          },
                                        ),
                                        new IconButton(
                                          icon: new Icon(Icons.clear),
                                          tooltip: 'Reject',
                                          iconSize: 30.0,
                                          color: Colors.red,
                                          onPressed: () {
                                            setActivityStatus("failure", index);
                                          },
                                        )
                                      ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              }),
        )
        , onWillPop: () {
        return getOnWillPop();});
  }

  Future<bool> getOnWillPop() async {
    return true;
  }

  Future<String> setActivityStatus(String status, index) async {
    final prefs = await SharedPreferences.getInstance();
    print(data[index]);
    print(status);
    final instanceUrl = prefs.get("instanceUrl");
    final token = prefs.get("token");

    final response = await http.get(
        instanceUrl+':8080/api/set_activity_status?token='+token+'&revision_id='+data[index].revision_id+'&activity_id='+data[index].id+'&status='+status+'&reason=""&name='+data[index].name+'&phase_name='+data[index].phase_name,
        headers: {
          "Content-Type": "application/json",
        });
    print(instanceUrl+':8080/api/set_activity_status?token='+token+'&revision_id='+data[index].revision_id+'&activity_id='+data[index].id+'&status='+status+'&reason=test&name='+data[index].name+'&phase_name='+data[index].phase_name+'&package_id='+data[index].package_id);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var data = json.decode(response.body)['Response'];
      print(data);
      fetchPendingList();
      var statusMessage;
      if (status == 'success') {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Approved activity")));
      } else if (status == 'failure') {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Rejected activity")));
      }

      return "successful";
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<String> fetchPendingList() async {
    final prefs = await SharedPreferences.getInstance();
    final instanceUrl = prefs.get("instanceUrl");
    final token = prefs.get("token");

    final response = await http.get(
        instanceUrl+':8080/api/list_pending_activities',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token "+token
        });

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Iterable data = json.decode(response.body)['Response'];
      List<PendingActivity> activites =
          data.map((activity) => PendingActivity.fromJson(activity)).toList();
      // this.fetchPendingList();
      setState(() {
        // Get the JSON data
        // Extract the required part and assign it to the global variable named data
        this.data = activites;
      });
      return "successful";
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();

    // Call the getJSONData() method when the app initializes
    this.fetchPendingList();
  }
}
