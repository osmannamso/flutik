import 'package:dummy/app/pages/login.dart';
import 'package:dummy/values/variables.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> globalKey = GlobalKey();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MY_APP_TITLE,
      navigatorKey: globalKey,
      initialRoute: '/',
      routes: {
        '/': (context) => App(),
        '/login': (context) => Login()
      }
    );
  }
}
