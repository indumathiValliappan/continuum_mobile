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
            actions: <Widget>[new IconButton(icon: new Image.asset('images/settings.png'),
                color: Colors.lightBlue,
                tooltip: "Settings",
                onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginPage()));
            })
            ]),
          body: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(right: 30.0),
                    child: IconButton(
                        icon: new Image.asset('images/pending.png'),
                        iconSize: 120.0,
                        tooltip: 'Pending Manual Activities',
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => MyGetHttpData()));
                        }
                    )
                ),
                Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: IconButton(
                        icon: new Image.asset('images/progression.png'),
                        iconSize: 120.0,
                        tooltip: 'Progression Board',
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProgressionListPage()));
                        }
                        )
                ),
              ]
          ),
        ),
    );
  }

}