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
        body: Scaffold(
          body: Center(
            child: DropdownButton<String>(
              value: dropdownValue,
              hint: new Text("Select Item"),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
                switch(newValue) {
                  case "Settings":
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    break;
                  case "Manual Activity":
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyGetHttpData()));
                    break;
                  case "Progression Board":
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProgressionListPage()));
                    break;
                }
                },

              items: <String>['Manual Activity', 'Progression Board', 'Settings']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }

}