import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_ctm/PendingActivity.dart';
import 'package:http/http.dart' as http;

class MyGetHttpData extends StatefulWidget {
  @override
  PendingListPage createState() => new PendingListPage();
}

class PendingListPage extends State<MyGetHttpData> {
  List<PendingActivity> data;
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("My Activities"),
          ),
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
                                    data[index].name,
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
                                          new Text(data[index].phase_name,
                                              textAlign: TextAlign.center,
                                              style: new TextStyle(fontSize: 16.0))
                                      ),
                                      new Row(children: <Widget>[
                                        new IconButton(
                                          icon: new Icon(Icons.check),
                                          tooltip: 'Approve',
                                          color: Colors.green,
                                          iconSize: 30.0,
                                          onPressed: () {},
                                        ),
                                        new IconButton(
                                          icon: new Icon(Icons.clear),
                                          tooltip: 'Reject',
                                          iconSize: 30.0,
                                          color: Colors.red,
                                          onPressed: () {},
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
        , onWillPop: () { return;});
  }

  Future<String> fetchPendingList() async {
    final response = await http.get(
        'http://cu057.cloud.maa.collab.net:8080/api/list_pending_activities',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token 5b6924a166c708309d0db3db"
        });

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Iterable data = json.decode(response.body)['Response'];
      List<PendingActivity> activites =
          data.map((activity) => PendingActivity.fromJson(activity)).toList();
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
