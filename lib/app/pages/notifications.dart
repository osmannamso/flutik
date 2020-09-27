import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  Notifications({this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          builder = (context) => Center(child:Text('Notifications'));
          return MaterialPageRoute(builder: builder, settings: settings);
        }
    );
  }

}