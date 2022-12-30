import 'package:flutter/material.dart';
import 'package:instameal/views/nav_screen/shopping.dart';
import 'package:instameal/views/nav_screen/favourite.dart';

import 'package:instameal/views/nav_screen/home.dart';
import 'package:instameal/views/searchcateg/searchcateg.dart';

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
    if (tabItem == "Meal Plans") {
      child = Home();
    } else if (tabItem == "Shopping List") {
      child = Shopping();
    } else if (tabItem == "Favourite") {
      child = Favourite();
    } else if (tabItem == "Search") {
      child = SearchCategories();
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
