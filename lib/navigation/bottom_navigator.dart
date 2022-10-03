import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instameal/navigation/tab_navigator.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/login.dart';

import '../utils/sizeconfig.dart';
import '../views/nav_screen/home.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentPage = 0;
  List<String> pageKeys = ["Home", "Favourite", "Profile", "History"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Favourite": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
    "History": GlobalKey<NavigatorState>(),
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
            _buildOffstageNavigator("Home"),
            _buildOffstageNavigator("Favourite"),
            _buildOffstageNavigator("Profile"),
            _buildOffstageNavigator("History"),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Container(
            color: CustomTheme.bgColor,
            height: SizeConfig.heightMultiplier * 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, (_currentPage == 0) ? -8 : 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: CustomTheme.bgColor),
                    width: SizeConfig.screenWidth * 0.2,
                    child: InkWell(
                      onTap: () {
                        _selectTab("Home", 0);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            Icons.home,
                            color: (_currentPage == 0)
                                ? CustomTheme.secondaryColor
                                : Colors.white,
                            size: SizeConfig.textMultiplier * 4.5,
                          ),
                          (_currentPage == 0)
                              ? Text("Home",
                                  style: Theme.of(context).textTheme.bodyText1)
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, (_currentPage == 1) ? -8 : 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: CustomTheme.bgColor),
                    width: SizeConfig.screenWidth * 0.2,
                    child: InkWell(
                      onTap: () {
                        _selectTab("Favourite", 1);
                        // Fluttertoast.showToast(msg: 'In progress');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.running,
                            color: (_currentPage == 1)
                                ? CustomTheme.secondaryColor
                                : Colors.white,
                            size: SizeConfig.textMultiplier * 4.5,
                          ),
                          (_currentPage == 1)
                              ? Text("Favourite",
                                  style: Theme.of(context).textTheme.bodyText1)
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.2,
                  child: Transform.translate(
                    offset: Offset(0, SizeConfig.heightMultiplier * -3),
                    child: InkWell(
                      onTap: () {
                        // toHome();
                        Fluttertoast.showToast(msg: 'In progress');
                      },
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, (_currentPage == 2) ? -8 : 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: CustomTheme.bgColor),
                    width: SizeConfig.screenWidth * 0.2,
                    child: InkWell(
                      onTap: () {
                        // _selectTab("Profile", 2);
                        Fluttertoast.showToast(msg: 'In progress');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.opencart,
                            color: (_currentPage == 2)
                                ? CustomTheme.secondaryColor
                                : Colors.white,
                            size: SizeConfig.textMultiplier * 4.5,
                          ),
                          (_currentPage == 2)
                              ? Text("History",
                                  style: Theme.of(context).textTheme.bodyText1)
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, (_currentPage == 3) ? -8 : 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: CustomTheme.bgColor),
                    width: SizeConfig.screenWidth * 0.2,
                    child: InkWell(
                      onTap: () {
                        _selectTab("History", 3);
                        // Fluttertoast.showToast(msg: 'In progress');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.rotate,
                            color: (_currentPage == 3)
                                ? CustomTheme.secondaryColor
                                : Colors.white,
                            size: SizeConfig.textMultiplier * 4.0,
                          ),
                          (_currentPage == 3)
                              ? Text("History",
                                  style: Theme.of(context).textTheme.bodyText1)
                              : SizedBox()
                        ],
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
