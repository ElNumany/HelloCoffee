import 'package:flutter/material.dart';
import 'package:hello_coffie/Models/user.dart';
import 'package:hello_coffie/Services/database.dart';
import 'package:hello_coffie/Shared/constance.dart';
import 'package:hello_coffie/Shared/loading.dart';
import 'package:provider/provider.dart';

class Settingsform extends StatefulWidget {
  @override
  _SettingsformState createState() => _SettingsformState();
}

class _SettingsformState extends State<Settingsform> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugar = ['0', '1', '2', '3', '4'];

  String _currentname;
  String _currentsugar;
  int _currentstrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseServices(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userdata = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                      initialValue: userdata.name,
                      decoration: TextInputDecouration.copyWith(
                          hintText: 'Your name :)'),
                      validator: (val) =>
                          val.isEmpty ? 'Please Enter Your Name' : null,
                      onChanged: (val) {
                        setState(() => _currentname = val);
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: TextInputDecouration.copyWith(
                        hintText: 'Your sugar :)'),
                    value: _currentsugar ?? userdata.sugar,
                    onChanged: (val) {
                      setState(() => _currentsugar = val);
                    },
                    items: sugar.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                  ),
//*The Slider
                  Slider(
                    value: (_currentstrength ?? userdata.strength).toDouble(),
                    activeColor:
                        Colors.brown[_currentstrength ?? userdata.strength],
                    inactiveColor:
                        Colors.brown[_currentstrength ?? userdata.strength],
                    onChanged: (val) =>
                        setState(() => _currentstrength = val.round()),
                    min: 100,
                    max: 900,
                    divisions: 8,
                  ),
//*End Slider!
                  //slider
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          await DatabaseServices(uid: user.uid).updateUserData(
                              _currentsugar ?? userdata.sugar,
                              _currentname ?? userdata.name,
                              _currentstrength ?? userdata.strength);
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
