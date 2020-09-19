import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.brown[100],
        child: SpinKitThreeBounce(
          color: Colors.brown[700],
          size: 50.0,
        ));
  }
}
