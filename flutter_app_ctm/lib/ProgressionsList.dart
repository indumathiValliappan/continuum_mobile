import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Progressions extends StatefulWidget {
  final String progId;
  @override
  ProgressionsList createState() => new ProgressionsList();

  Progressions({Key key, this.progId}) : super(key: key);
}

class ProgressionsList extends State<Progressions> {
  var data = {};
  var packages = [];
  final String hours = "Hours";
  final String days = "Days";
  var progressionData = {};
  var getProg = {
    "_id": "5cd4cfab2c8f1c37b0828a4a",
    "description": "Creating Progression via automation",
    "name": "progression936",
    "phases": [
      {
        "code_complete": true,
        "delivery_category": "Packaged",
        "description": "Build",
        "has_dnstream": true,
        "has_upstream": false,
        "index": 0,
        "name": "Build"
      },
      {
        "code_complete": false,
        "delivery_category": "Packaged",
        "description": "Development",
        "has_dnstream": true,
        "has_upstream": true,
        "index": 1,
        "name": "Development"
      },
      {
        "code_complete": false,
        "delivery_category": "Packaged",
        "description": "Test",
        "has_dnstream": true,
        "has_upstream": true,
        "index": 2,
        "name": "QA"
      },
      {
        "code_complete": false,
        "delivery_category": "Packaged",
        "description": "Delivery",
        "has_dnstream": false,
        "has_upstream": true,
        "index": 3,
        "name": "Delivery"
      }
    ]
  };

  @override
  void initState() {
    super.initState();

    // Call the getJSONData() method when the app initializes
    this.fetchProgressionData();
    this.fetchPackagesInProgression();
    this.fetchProgressionList();
  }

  @override
  Widget build(BuildContext context) {
    var array = [];
    if (data.keys.length <= 0)
      return new Scaffold(
          appBar: new AppBar(
            title: Text('Progressions'),
          ),
          body: new Container(
              constraints: new BoxConstraints.expand(
                height: 900.0,
              ),
              color: Colors.white));

    this.progressionData.forEach((key, value) =>
    {
      if (key == 'phases') for (var val in value) array.add(val["name"]),
    });
    return new Scaffold(
      appBar: new AppBar(
        title: Text(this.progressionData["name"]),
      ),
      body: CarouselSlider(
        height: 900.0,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        items: array.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      new Text(i,
                          style: new TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      for (var pck in packages)
                        if (data[i].containsKey(pck["_id"]))
                          new Card(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                new Container(
                                  child: new Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: new Container(
                                                padding: EdgeInsets.all(4.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        6.0),
                                                    color: Colors.blue),
                                                child: new Text(
                                                  data[i][pck["_id"]]
                                                  ["fullversion_from"] +
                                                      "-" +
                                                      data[i][pck["_id"]]
                                                      ["fullversion_to"],
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.white,
                                                  ),
                                                ))),
                                        new Container(
                                            padding: EdgeInsets.all(4.0),
                                            child: new Text(
                                              'Forecast: ${data[i][pck["_id"]]["estimated_time_to_delivery"] <
                                                  84600
                                                  ? (data[i][pck["_id"]]["estimated_time_to_delivery"] /
                                                  3600.0).round()
                                                  : (data[i][pck["_id"]]["estimated_time_to_delivery"] /
                                                  86400.0)
                                                  .round()} ${data[i][pck["_id"]]["estimated_time_to_delivery"] >
                                                  0 &&
                                                  data[i][pck["_id"]]["estimated_time_to_delivery"] <
                                                      84600 ? hours : days}',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ))
                                      ]),
                                  alignment: FractionalOffset(0.1, 0.1),
                                ),
                                new ListTile(
                                  title: new Text(
                                    data[i][pck["_id"]]["package_name"],
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: new Text(
                                      data[i][pck["_id"]]["version"],
                                      style: new TextStyle(
                                          fontSize: 16.0, color: Colors.blue)),
                                ),
                                new Container(
                                    child: new Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          data[i][pck["_id"]]
                                          ["unmanaged_change_count"] >
                                              0
                                              ? new Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: new Image.asset(
                                                'images/unmanaged_commit.png',
                                                fit: BoxFit.cover,
                                                alignment: Alignment.center,
                                              ))
                                              : new Container(),
                                          new Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: new Text(
                                                  'Revisions: ${data[i][pck["_id"]]["rev_from"]} - ${data[i][pck["_id"]]["rev_to"]}',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                  )))
                                        ]))
                              ],
                            ),
                          )
                        else
                          new Container(
                              constraints: new BoxConstraints.expand(
                                height: 167.0,
                              )),
                    ],
                  )
                // Text('text $i \n $testData', style: TextStyle(fontSize: 16.0), maxLines: 60)
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Future<String> fetchProgressionList() async {
    final prefs = await SharedPreferences.getInstance();
    final instanceUrl = prefs.get("instanceUrl");
    final token = prefs.get("token");

    var response = await http.post(
        instanceUrl +
            ':8080/api/get_progression_phase_data?progression_id=5cd4cfab2c8f1c37b0828a4a',
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Token " + token,
        });

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['Response'];
      setState(() {
        this.data = data;
      });
      return "successful";
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<String> fetchProgressionData() async {
    final prefs = await SharedPreferences.getInstance();
    final instanceUrl = prefs.get("instanceUrl");
    final token = prefs.get("token");
    final response = await http.get(
        instanceUrl +
            ':8080/api/get_progression?progression_id=${widget.progId}',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token
        });
    var progData = json.decode(response.body)['Response'];
    setState(() {
      this.progressionData = progData;
    });
    return "Success";
  }

  Future<String> fetchPackagesInProgression() async {
    final prefs = await SharedPreferences.getInstance();
    final instanceUrl = prefs.get("instanceUrl");
    final token = prefs.get("token");

    var response = await http.post(
        instanceUrl +
            ':8080/api/get_packages_in_progression?progression_id=5cd4cfab2c8f1c37b0828a4a',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token " + token,
        });

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['Response'];
      setState(() {
        this.packages = data;
      });
      return "successful";
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
