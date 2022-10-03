import 'package:flutter/material.dart';
import 'package:instameal/views/nav_screen/history.dart';
import 'package:instameal/views/nav_screen/profile.dart';

import '../views/nav_screen/home.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {this.navigatorKey, this.tabItem, this.onBack, this.loginBack});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final onBack, loginBack;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Home") {
      child = Home();
    } else if (tabItem == "Favourite") {
      child = Home();
    } else if (tabItem == "Profile") {
      child = Home();
    } else if (tabItem == "History") {
      child = Home();
    } else {
      child = Home();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
