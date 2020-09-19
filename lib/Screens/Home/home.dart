import 'package:flutter/material.dart';
import 'package:hello_coffie/Models/brew.dart';
import 'package:hello_coffie/Screens/Home/settings_form.dart';
import 'package:hello_coffie/Services/auth.dart';
import 'package:hello_coffie/Services/database.dart';
import 'package:provider/provider.dart';

import 'brewList.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Settingsform(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseServices().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[120],
        appBar: AppBar(
          title: Text("Hello"),
          backgroundColor: Colors.brown[500],
          elevation: 0.1,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signout();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('Settings'))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
            child: BrewList()),
      ),
    );
  }
}
