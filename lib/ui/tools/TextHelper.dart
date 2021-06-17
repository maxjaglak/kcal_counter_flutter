import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextHelper {
  static Text titleText(String text) {
    return Text(text,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
  }

  static Text label(String label) {
    return Text(label,
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal));
  }

}

