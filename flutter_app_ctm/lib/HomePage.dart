import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_ctm/ProgressionListPage.dart';
import 'package:flutter_app_ctm/pendingListPage.dart';
import 'package:flutter_app_ctm/settings.dart';

class HomePage extends StatefulWidget {
  @override
  DropDownItems createState() => DropDownItems();
}

class DropDownItems extends State<HomePage> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dashboard",
      home: Scaffold(
        appBar: AppBar(title: Text("Home"),
            actions: <Widget>[new IconButton(icon: new Icon(Icons.settings),
                tooltip: "Settings",
                onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginPage()));
            })
            ]),
          body: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left:10.0,right: 20.0),
                    child: Column(
                        children: <Widget>[
                          IconButton(
                              icon: new Image.asset('images/pending.png'),
                              iconSize: 120.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MyGetHttpData()));
                              }
                              ),
                          Text("Pending Manual Activities", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0))
                        ]
                    )),
                Container(
                    child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: new Image.asset('images/progression.png'),
                              iconSize: 120.0,
                              onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ProgressionListPage()));
                            }
                            ),
                          Text("Progression Board", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0))
                        ]
                    )
                ),
              ]
          ),
        ),
    );
  }

}