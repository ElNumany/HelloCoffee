import 'package:flutter/material.dart';
import 'package:hello_coffie/Models/user.dart';
import 'package:hello_coffie/Screens/Home/auth/authenticate.dart';
import 'package:hello_coffie/Screens/Home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either Home Or Authenticate widget!
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
