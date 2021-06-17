import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GeneralUI {

  static Widget listProgressIndicator() {
    return Container(
        constraints: BoxConstraints(minHeight: 80, maxHeight: double.infinity),
        height: 50,
        color: Colors.black.withAlpha(60),
        child: Center(child: CircularProgressIndicator()));
  }

  static Widget progressIndicator() {
    return Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()));
  }

  static Widget titleText(String text) {
    return Text(text, style: TextStyle(color: Colors.black54, fontSize: 18.0));
  }

  static Widget text(String text) {
    return Text(text);
  }

  static Widget boldText(String text) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold));
  }

}
