import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green[300],
        child: Center(
            child: SpinKitCircle(
          color: Colors.white,
          size: 50.0,
        )));
  }
}
