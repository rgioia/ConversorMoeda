import 'package:flutter/material.dart';
import 'package:conversor_moeda/screens/home.dart';
import 'package:sentry/sentry.dart';

final SentryClient sentry = new SentryClient(
    dsn: 'https://b684a4a9acaf4eeab9e1b98fc5741d53@sentry.io/4054692');

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maino App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          hintColor: Colors.black,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            hintStyle: TextStyle(color: Colors.black),
          )),
      home: Home(),
    );
  }
}
