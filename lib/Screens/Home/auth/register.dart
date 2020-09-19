import 'package:flutter/material.dart';
import 'package:hello_coffie/Services/auth.dart';
import 'package:hello_coffie/Shared/constance.dart';

import '../home.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Register to ICoffie"),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text('Sign In'))
          ]),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                  decoration: TextInputDecouration.copyWith(hintText: 'email'),
                  validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: TextInputDecouration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Enter an password' : null,
                obscureText: true,
                onChanged: (val) {
                  {
                    setState(() => password = val);
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.registerWithEmailAndpassword(
                        email, password);
                    if (result == null) {
                      setState(() => error = 'please right a vaild email!');
                    } else {
                      return Home();
                    }
                  }
                },
                color: Colors.brown[800],
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 14.0),
              (Text(
                " $error",
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
