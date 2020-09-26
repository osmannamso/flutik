import 'package:dummy/app/pages/bookings.dart';
import 'package:dummy/app/pages/notifications.dart';
import 'package:dummy/app/pages/profile.dart';
import 'package:dummy/app/pages/search.dart';
import 'package:dummy/app/shared/destination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState  extends State<App> with TickerProviderStateMixin<App> {
  int _currentIndex = 0;
  final GlobalKey<NavigatorState> searchNavigatorState = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> bookingsNavigatorState = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> notificationsNavigatorState = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profileNavigatorState = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          print('qwe');
          searchNavigatorState.currentState.popUntil((route) => route.isFirst);
          return true;
        },
        child: CupertinoTabScaffold(
            tabBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return CupertinoTabView(
                    navigatorKey: searchNavigatorState,
                    builder: (context) => Search()
                );
              } else if (index == 1) {
                return CupertinoTabView(
                    navigatorKey: bookingsNavigatorState,
                    builder: (context) => Bookings()
                );
              } else if (index == 3) {
                return CupertinoTabView(
                    navigatorKey: notificationsNavigatorState,
                    builder: (context) => Notifications()
                );
              } else {
                return CupertinoTabView(
                    navigatorKey: profileNavigatorState,
                    builder: (context) => Profile()
                );
              }
            },
            tabBar: CupertinoTabBar(
                activeColor: Colors.amber[800],
                inactiveColor: Colors.grey,
                onTap: (int index) {
                  if (_currentIndex == index) {
                    if (index == 0) {
                      print('asd');
                      searchNavigatorState.currentState.maybePop();
                    }
                  } else {
                    _currentIndex = index;
                  }
                },
                items: routes.map((Destination destination) {
                  return BottomNavigationBarItem(
                      icon: Icon(destination.icon)
                  );
                }).toList()
            )
        )
      )
    );
  }
}
