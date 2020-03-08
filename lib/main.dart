import 'package:flutter/material.dart';
import 'package:conversor_moeda/screens/home.dart';

import 'package:sentry/sentry.dart';

final SentryClient sentry = new SentryClient(dsn: 'https://b684a4a9acaf4eeab9e1b98fc5741d53@sentry.io/4054692');

void main() async {
  try {
    runApp(MaterialApp(
      home: Home(),
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
    ));
  } catch(error, stackTrace) {
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}