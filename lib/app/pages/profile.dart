import 'package:dummy/main.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          builder = (context) => FlatButton(
            onPressed: () {
              globalKey.currentState.pushNamed('/login');
            },
            color: Colors.grey,
            child: Text('Login'),
          );
          return MaterialPageRoute(builder: builder, settings: settings);
        }
    );
  }
}
