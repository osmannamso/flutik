import 'package:dummy/app/pages/bookings.dart';
import 'package:dummy/app/pages/notifications.dart';
import 'package:dummy/app/pages/profile.dart';
import 'package:dummy/app/pages/search.dart';
import 'package:dummy/app/shared/destination.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<App> with TickerProviderStateMixin<App> {
  final _searchController = SearchController();
  int _currentIndex = 3;
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  void _selectTab(index) async {
    if (index == _currentIndex) {
      final isFirstRoute = _navigatorKeys[index].currentState.canPop();
      if (isFirstRoute) {
        _navigatorKeys[index].currentState.popUntil((r) => r.isFirst);
      } else {
        _searchController.scrollTop();
      }
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentIndex].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentIndex != 3) {
            _selectTab(3);
            return false;
          }
        }

        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Offstage(
              offstage: _currentIndex != 0,
              child: Search(
                navigatorKey: _navigatorKeys[0],
                controller: _searchController
              )
            ),
            Offstage(
                offstage: _currentIndex != 1,
                child: Bookings(
                  navigatorKey: _navigatorKeys[1]
                )
            ),
            Offstage(
                offstage: _currentIndex != 2,
                child: Notifications(
                  navigatorKey: _navigatorKeys[2]
                )
            ),
            Offstage(
                offstage: _currentIndex != 3,
                child: Profile(
                  navigatorKey: _navigatorKeys[3]
                )
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          showUnselectedLabels: false,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: _selectTab,
          items: routes.map((Destination destination) {
            return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              title: Text(destination.title)
            );
          }).toList(),
        ),
      )
    );
  }
}
