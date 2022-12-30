import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/navigation/tab_navigator.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/login.dart';
import 'package:instameal/views/nav_screen/shopping.dart';

import 'package:instameal/components/components.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/views/details/shopitems.dart';
import 'package:instameal/views/nav_screen/home.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  GetStorage box = GetStorage();
  // int _currentPage = 0;
  List<String> pageKeys = [
    "Meal Plans",
    "Shopping List",
    "Favourite",
    "Search"
  ];
  // Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
  //   "Meal Plans": GlobalKey<NavigatorState>(),
  //   "Shopping List": GlobalKey<NavigatorState>(),
  //   "Favourite": GlobalKey<NavigatorState>(),
  //   "Search": GlobalKey<NavigatorState>(),
  // };

  _selectTab(String tabItem, int index) {
    final UniversalController universalController =
        Get.put(UniversalController());
    if (tabItem == pageKeys[universalController.currentPage.value]) {
      universalController.navigatorKeys[tabItem].currentState
          .popUntil((route) => route.isFirst);
    } else {
      // setState(() {
      universalController.currentPage.value = index;
      // });
    }
  }

//toLoginBack not used
  toLoginBack() {
    Constants.navigatepushreplac(context, Login());

    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => Login()));
  }

  toHome() {
    // _selectTab('Home', 0);
    Constants.navigatepushreplac(context, Home());

    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => Home()));
  }

  Future<bool> onWilPop(home) async {
    final UniversalController universalController =
        Get.put(UniversalController());
    print("onWilPop:::::");
    final isFirstRouteInCurrentTab = !await universalController
        .navigatorKeys[universalController.currentPage.value].currentState
        .maybePop();
    if (isFirstRouteInCurrentTab) {
      if (universalController.currentPage.value != 0) {
        _selectTab('Home', 0);
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (box.read('firsttime').toString() == "yes") {
      final UniversalController universalController =
          Get.put(UniversalController());
      universalController.currentPage.value = 1;
      if (universalController.navigatorKeys["Shopping List"].currentState !=
          null) {
        universalController.navigatorKeys["Shopping List"].currentState
            .popUntil((route) => route.isFirst);
        universalController.currentPage.value = 1;
      }
      box.write('firsttime', 'no');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool s = MediaQuery.of(context).viewInsets.bottom != 0;
    final UniversalController universalController =
        Get.put(UniversalController());
    return Obx(() => WillPopScope(
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
                            decoration: bottomBarShadow(
                                0, universalController.currentPage.value),
                            child: FaIcon(
                              FontAwesomeIcons.utensils,
                              color:
                                  (universalController.currentPage.value == 0)
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
                            decoration: bottomBarShadow(
                                1, universalController.currentPage.value),
                            child: FaIcon(
                              FontAwesomeIcons.cartShopping,
                              color:
                                  (universalController.currentPage.value == 1)
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
                            decoration: bottomBarShadow(
                                2, universalController.currentPage.value),
                            child: FaIcon(
                              FontAwesomeIcons.heart,
                              color:
                                  (universalController.currentPage.value == 2)
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
                            decoration: bottomBarShadow(
                                3, universalController.currentPage.value),
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              color:
                                  (universalController.currentPage.value == 3)
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
        ));
  }

  Widget _buildOffstageNavigator(String tabItem) {
    final UniversalController universalController =
        Get.put(UniversalController());
    return Offstage(
      offstage: pageKeys[universalController.currentPage.value] != tabItem,
      child: TabNavigator(
          navigatorKey: universalController.navigatorKeys[tabItem],
          tabItem: tabItem,
          onBack: toHome,
          loginBack: toLoginBack),
    );
  }
}
