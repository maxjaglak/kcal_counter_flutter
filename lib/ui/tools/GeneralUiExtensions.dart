import 'package:flutter/widgets.dart';

class PaddingHelper {

  static Widget withStandardPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: child,
    );
  }

}