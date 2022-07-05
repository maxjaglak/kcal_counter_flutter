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
        color: Colors.grey,
        child: Center(child: CircularProgressIndicator()));
  }

}
