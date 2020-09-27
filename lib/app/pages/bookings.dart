import 'package:flutter/material.dart';

class Bookings extends StatelessWidget {
  Bookings({this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        builder = (context) => Center(child:Text('Bookings'));
        return MaterialPageRoute(builder: builder, settings: settings);
      }
    );
  }

}