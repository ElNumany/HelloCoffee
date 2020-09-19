import 'package:flutter/material.dart';
import 'package:hello_coffie/Models/user.dart';
import 'package:hello_coffie/Services/auth.dart';
import 'package:provider/provider.dart';

import 'Screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
