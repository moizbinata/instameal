import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/navigation/tab_navigator.dart';
import 'package:instameal/services/notifsercice.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/login.dart';
import 'package:instameal/views/nav_screen/shopping.dart';

import 'package:instameal/components/components.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/views/details/shopitems.dart';
import 'package:instameal/views/nav_screen/home.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../components/customdrawer.dart';
import '../src/constant.dart';
import '../src/model/singletons_data.dart';

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
  bool validSubscription = false;
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
  Future<void> initState() {
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
    checkExpiry();
  }

  checkExpiry() async {
    // NotifService notifService = NotifService();
    // bool validSub = await notifService.checkExpiry();
    // setState(() {
    //   validSubscription = validSub;
    // });
    print("checking expiry");
    try {
      CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
      print(purchaserInfo.originalAppUserId);
      print("checking expiry true");

      if (purchaserInfo.entitlements.all[entitlementID] != null) {
        // access latest purchaserInfo
        if (purchaserInfo.entitlements.all[entitlementID].isActive) {
          appData.entitlementIsActive =
              purchaserInfo.entitlements.all[entitlementID].isActive;
          // Grant user "pro" access
          setState(() {
            validSubscription = appData.entitlementIsActive;
          });
        }
      } else {
        setState(() {
          validSubscription = false;
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        validSubscription = false;
      });
      print(e.message);
      print("checking expiry false");
      // Error fetching purchaser info
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
              children: !validSubscription
                  ? <Widget>[
                      ExpiryScreen(),
                      ExpiryScreen(),
                      ExpiryScreen(),
                      ExpiryScreen()
                    ]
                  : <Widget>[
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

class ExpiryScreen extends StatelessWidget {
  ExpiryScreen({Key key}) : super(key: key);
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.warning,
              color: CustomTheme.bgColor,
              size: SizeConfig.heightMultiplier * 10,
            ),
            space1(),
            Text(
              "Your Subscription has been expired. Contact Customer Support to activate your subscription",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            space1(),
            InkWell(
              onTap: (() {
                var email = box.read('email');
                String message =
                    "My email id $email has been deactivated. I want to reactivate my subscription.";
                launchEmailSubmission(body: message);
              }),
              child: customButton(
                  context, Colors.white, CustomTheme.bgColor, "Reactivate"),
            ),
            space0(),
            InkWell(
              onTap: (() {
                GetStorage box = GetStorage();
                box.erase();
                Fluttertoast.showToast(msg: 'Successfully Logout');
                Get.offAll(Login(
                  type: 1,
                ));
              }),
              child: customButton(
                  context, CustomTheme.bgColor, Colors.white, "Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
