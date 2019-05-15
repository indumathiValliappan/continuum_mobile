import 'package:flutter/material.dart';
import 'package:flutter_app_ctm/ProgressionsList.dart';

class ProgressionListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Progressions';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          leading: new Image.asset(
              'images/v1-logo.png'),
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('prog1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Progressions()),
                );
              },
            ),
            ListTile(
              title: Text('prog2'),
            ),
            ListTile(
              title: Text('prog3'),
            ),
          ],
        ),
      ),
    );
  }
}