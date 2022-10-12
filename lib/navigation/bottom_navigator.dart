import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instameal/navigation/tab_navigator.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/login.dart';

import '../components/components.dart';
import '../utils/sizeconfig.dart';
import '../views/nav_screen/home.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentPage = 0;
  List<String> pageKeys = [
    "Meal Plans",
    "Shopping List",
    "Favourite",
    "Search"
  ];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Meal Plans": GlobalKey<NavigatorState>(),
    "Shopping List": GlobalKey<NavigatorState>(),
    "Favourite": GlobalKey<NavigatorState>(),
    "Search": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == pageKeys[_currentPage]) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = index;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

//toLoginBack not used
  toLoginBack() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  toHome() {
    // _selectTab('Home', 0);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  Future<bool> onWilPop(home) async {
    print("onWilPop:::::");
    final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage].currentState.maybePop();
    if (isFirstRouteInCurrentTab) {
      if (_currentPage != 0) {
        _selectTab('Home', 0);
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }

  @override
  Widget build(BuildContext context) {
    bool s = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () => onWilPop(false),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator("Meal Plans"),
            _buildOffstageNavigator("Shopping List"),
            _buildOffstageNavigator("Favourite"),
            _buildOffstageNavigator("Search"),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: CustomTheme.bgColor2,
          elevation: 0.0,
          child: SizedBox(
            height: SizeConfig.heightMultiplier * 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _selectTab("Meal Plans", 0);
                  },
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.25,
                    child: Center(
                      child: Container(
                        decoration: bottomBarShadow(0, _currentPage),
                        child: FaIcon(
                          FontAwesomeIcons.utensils,
                          color: (_currentPage == 0)
                              ? CustomTheme.bgColor
                              : CustomTheme.grey,
                          size: SizeConfig.textMultiplier * 3.2,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectTab("Shopping List", 1);
                    // Fluttertoast.showToast(msg: 'In progress');
                  },
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.25,
                    child: Center(
                      child: Container(
                        decoration: bottomBarShadow(1, _currentPage),
                        child: FaIcon(
                          FontAwesomeIcons.cartShopping,
                          color: (_currentPage == 1)
                              ? CustomTheme.bgColor
                              : CustomTheme.grey,
                          size: SizeConfig.textMultiplier * 3.2,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectTab("Favourite", 2);
                    // Fluttertoast.showToast(msg: 'In progress');
                  },
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.25,
                    child: Center(
                      child: Container(
                        decoration: bottomBarShadow(2, _currentPage),
                        child: FaIcon(
                          FontAwesomeIcons.heart,
                          color: (_currentPage == 2)
                              ? CustomTheme.bgColor
                              : CustomTheme.grey,
                          size: SizeConfig.textMultiplier * 3.2,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectTab("Search", 3);
                    // Fluttertoast.showToast(msg: 'In progress');
                  },
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.25,
                    child: Center(
                      child: Container(
                        decoration: bottomBarShadow(3, _currentPage),
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: (_currentPage == 3)
                              ? CustomTheme.bgColor
                              : CustomTheme.grey,
                          size: SizeConfig.textMultiplier * 3.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: pageKeys[_currentPage] != tabItem,
      child: TabNavigator(
          navigatorKey: _navigatorKeys[tabItem],
          tabItem: tabItem,
          onBack: toHome,
          loginBack: toLoginBack),
    );
  }
}
