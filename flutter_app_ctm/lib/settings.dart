import 'package:flutter/material.dart';
import 'package:flutter_app_ctm/ProgressionListPage.dart';
import 'package:flutter_app_ctm/main.dart';
import 'package:flutter_app_ctm/pendingListPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Read data from shared preferences

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController urlController = new TextEditingController();
  TextEditingController tokenController = new TextEditingController();
  String instance, token;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
        actions: <Widget>[new PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Logout') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              }
              else if (value == 'Progressions') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProgressionListPage()),
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
                  value: 'Manual Activity',
                  child: Text('Manual Activity')
              ),
              const PopupMenuItem<String>(
                  value: 'Progressions',
                  child: Text('Progressions')
              ),
              const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Text('Logout')
              ),
            ]
        ),],
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    keyboardType: TextInputType.url,
                   // initialValue: this.instance,
                    controller: urlController, // Use url input type for instance.
                    decoration: new InputDecoration(
                      hintText: this.instance,
                     //   labelText: 'Continuum instance'
                    )
                ),
                new TextFormField(
                 //   initialValue: this.token,
                    obscureText: true,
                    controller: tokenController,
                    decoration: new InputDecoration(
                      hintText: this.token,
                    )

                ),
              ],
            ),
          )
      ),
    );
  }
  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      this.instance = prefs.get("instanceUrl");
      this.token = prefs.get("token");
    });
    return "successful";
  }
  @override
  void initState() {
    super.initState();

    // Call the getJSONData() method when the app initializes
    this.getData();
  }
}