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
        appBar: AppBar(title: Text("Dashboard")),
          body: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 30.0, top: 10.0),
                    child: IconButton(
                        icon: new Image.asset('images/progression.png'),
                        iconSize: 120.0,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProgressionListPage()));
                        }
                        )
                ),
                Container(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: IconButton(
                        icon: new Image.asset('images/pending.png'),
                        iconSize: 120.0,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => MyGetHttpData()));
                        }
                    )
                ),
                Container(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: IconButton(
                        icon: new Image.asset('images/settings.png'),
                        iconSize: 120.0,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        }
                    )
                ),
              ]
          ),
        ),
    );
  }

}