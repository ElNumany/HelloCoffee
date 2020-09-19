import 'package:flutter/material.dart';
import 'package:hello_coffie/Screens/Home/auth/register.dart';
import 'package:hello_coffie/Screens/Home/auth/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Signin(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
