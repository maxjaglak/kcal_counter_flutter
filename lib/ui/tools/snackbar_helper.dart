import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackbarHelper {
  static void error(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
    );
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  static void green(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white70)),
      backgroundColor: Colors.green,
    );
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
