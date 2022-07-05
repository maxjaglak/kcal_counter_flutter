import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardView extends StatelessWidget {
  final Widget child;

  const CustomCardView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 5.0,
        color: Color.fromARGB(220, 48, 68, 77),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: this.child,
        ),
      ),
    );
  }
}
