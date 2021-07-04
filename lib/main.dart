import 'package:flutter/material.dart';
import 'package:kcal_counter_flutter/ui/init/InitView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromARGB(255, 48, 68, 77),
        accentColor: Color.fromARGB(255, 57, 214, 138),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
        ),
      ),
      home: InitViewBloc(),
    );
  }
}
