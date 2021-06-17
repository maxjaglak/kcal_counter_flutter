import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("kcal counter :)"),
        ),
      ),
    );
  }

}