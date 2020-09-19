import 'package:flutter/material.dart';
import 'package:hello_coffie/Services/auth.dart';
import 'package:hello_coffie/Shared/constance.dart';
import 'package:hello_coffie/Shared/loading.dart';

import '../home.dart';

class Signin extends StatefulWidget {
  final Function toggleView;
  Signin({this.toggleView});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign In To ICoffie"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                        decoration:
                            TextInputDecouration.copyWith(hintText: 'email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter Email Address!' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          TextInputDecouration.copyWith(hintText: 'password'),
                      validator: (val) =>
                          val.length < 6 ? 'Enter password!' : null,
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
                        if (_formkey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              _auth.signInWithEmailAndpassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Please enter right email and password!';
                              loading = false;
                            });
                          } else {
                            return Home();
                          }
                        }
                      },
                      color: Colors.brown[800],
                      child: Text(
                        "Sign in",
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
