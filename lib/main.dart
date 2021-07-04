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
          headline1: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline3: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          caption: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText1: TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Colors.white),
          bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Colors.white),
        ),
      ),
      home: InitViewBloc(),
    );
  }
}
