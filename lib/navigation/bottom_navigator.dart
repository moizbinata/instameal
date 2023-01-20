import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/navigation/tab_navigator.dart';
import 'package:instameal/services/notifsercice.dart';
import 'package:instameal/src/store_config.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/login.dart';
import 'package:instameal/views/nav_screen/shopping.dart';

import 'package:instameal/components/components.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/views/details/shopitems.dart';
import 'package:instameal/views/nav_screen/home.dart';
import 'package:instameal/views/subscription/instamealplans.dart';
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

  // bool validSubscription;
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
    initPlatformState();
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

  Future<void> initPlatformState() async {
    // Enable debug logs before calling `configure`.
    await Purchases.setDebugLogsEnabled(true);
    appData.appUserID = box.read('subscriptionStart').toString() == "NOID"
        ? null
        : box.read('subscriptionStart').toString();

    final UniversalController universalController =
        Get.put(UniversalController());
    /*
    - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

    - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
    */
    PurchasesConfiguration configuration;
    if (StoreConfig.isForAmazonAppstore()) {
      configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
        ..appUserID = appData.appUserID
        ..observerMode = false;
    } else {
      configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
        ..appUserID = appData.appUserID
        ..observerMode = false;
    }
    await Purchases.configure(configuration);

    // appData.appUserID = await Purchases.appUserID;

    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      print("moizata${appData.appUserID}");
      appData.appUserID = await Purchases.appUserID;
      print("userid active status1 " + appData.entitlementIsActive.toString());

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      (customerInfo.entitlements.all[entitlementID] != null &&
              customerInfo.entitlements.all[entitlementID].isActive)
          ? appData.entitlementIsActive = true
          : appData.entitlementIsActive = false;
      print("userid active status " + appData.entitlementIsActive.toString());
      // setState(() {});
      // setState(() {
      if (customerInfo.entitlements.all[entitlementID] != null ||
          customerInfo.entitlements.all[entitlementID].isActive ||
          appData.appUserID != null)
        universalController.expiryBool.value = appData.entitlementIsActive;
      else
        universalController.expiryBool.value = false;

      // validSubscription = appData.entitlementIsActive;
      // });
    });
  }

  checkExpiry() async {
    // NotifService notifService = NotifService();
    // bool validSub = await notifService.checkExpiry();
    // setState(() {
    //   validSubscription = validSub;
    // });
    print("checking expiry");
    final UniversalController universalController =
        Get.put(UniversalController());
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
          // setState(() {
          universalController.expiryBool.value = appData.entitlementIsActive;
          // });
        }
      } else {
        setState(() {
          universalController.expiryBool.value = false;
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        universalController.expiryBool.value = false;
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
              children: !universalController.expiryBool.value
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
              "Your Subscription has been expired or not activated. Contact Customer Support to activate your subscription",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            space1(),
            InkWell(
              onTap: (() {
                // var email = box.read('email');
                // String message =
                //     "My email id $email has been deactivated. I want to reactivate my subscription.";
                // launchEmailSubmission(body: message);
                Get.offAll(SubscribePlans());
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
