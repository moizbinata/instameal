import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/controllers/notifcontroller.dart';
import 'package:instameal/navigation/bottom_navigator.dart';
import 'package:instameal/src/components/native_dialog.dart';
import 'package:instameal/src/constant.dart';
import 'package:instameal/src/store_config.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/details/securityques.dart';
import 'package:instameal/views/subscription/instamealplans.dart';
import 'package:instameal/views/subscription/payment_screen.dart';
import 'package:instameal/views/subscription/paywallwidget.dart';
import 'package:instameal/views/subscription/trial_screen.dart';
import 'package:intl/intl.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/components/customdrawer.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/models/loginmodel.dart';
import 'package:instameal/utils/network.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/customDialogue.dart';
import '../src/model/singletons_data.dart';
import '../src/model/weather_data.dart';

class Login extends StatefulWidget {
  Login({Key key, this.type}) : super(key: key);
  final type;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loginLoader = false;
  bool signupLoader = false;
  bool loader2 = false;

  bool eye = true;
  FocusNode fn = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final _signupey = GlobalKey<FormState>();
  String _chosenValue = "Favorite pet name";
  bool selectedGender = true;
  //login
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  //signup
  TextEditingController usernameController2 = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  TextEditingController password1Controller = TextEditingController();
  GetStorage box = GetStorage();
  TextEditingController password2Controller = TextEditingController();
  bool value = false;
  @override
  void initState() {
    // initPlatformState();
    if (widget.type == 1) {
      setState(() {
        loader2 = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.bgColor2,
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Container(
            height: SizeConfig.screenHeight,

            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.heightMultiplier * 3),
            // height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (loader2)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          space2(),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                                onTap: () {
                                  launchEmailSubmission();
                                },
                                child: FaIcon(FontAwesomeIcons.headset)),
                          ),
                          Image.asset(
                            "assets/images/logo.png",
                            height: SizeConfig.heightMultiplier * 13,
                            fit: BoxFit.contain,
                          ),
                          space1(),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          space1(),
                          _buildLoginWidget()
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [_buildSignupWidget()],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildLoginWidget() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customField(usernameController, "Email or Username",
              icon: Icons.mail),
          space1(),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: customField(passwordController, "Password",
                    icon: Icons.lock, eye: eye),
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        eye = !eye;
                      });
                    },
                  )),
            ],
          ),
          TextButton(
              onPressed: () {
                Constants.navigatepush(
                  context,
                  SecureQues(),
                );
              },
              child: Text(
                "Forgot Password",
                style: Theme.of(context).textTheme.bodySmall.copyWith(
                    fontWeight: FontWeight.bold, color: CustomTheme.bgColor),
              )),
          space1(),
          (loginLoader)
              ? CustomTheme.loader()
              : InkWell(
                  onTap: () {
                    setState(() {
                      loginLoader = true;
                    });
                    print(passwordController.text);
                    FocusScope.of(context).requestFocus(fn);
                    if (_formKey.currentState.validate()) {
                      loginService(context);
                    } else {
                      Fluttertoast.showToast(msg: 'Validation error');
                      setState(() {
                        loginLoader = false;
                      });
                    }
                  },
                  child: customButton(
                      context, Colors.white, CustomTheme.bgColor, "Login"),
                ),
          space0(),
          InkWell(
            onTap: (() {
              setState(() {
                loader2 = false;
              });
            }),
            child: Center(
              child: Text(
                "Create an account",
                style: TextStyle(color: CustomTheme.bgColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSignupWidget() {
    return SizedBox(
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Form(
          key: _signupey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space0(),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      launchEmailSubmission();
                    },
                    child: FaIcon(FontAwesomeIcons.headset)),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: SizeConfig.heightMultiplier * 13,
                  fit: BoxFit.contain,
                ),
              ),
              space0(),
              Text(
                "Signup",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              space0(),
              space0(),
              customField(usernameController2, "Username",
                  icon: Icons.account_circle),
              space0(),
              customField(emailController, "Email", icon: Icons.mail),
              space0(),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: customField(password1Controller, "Password",
                        icon: Icons.lock, eye: eye),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            eye = !eye;
                          });
                        },
                      )),
                ],
              ),
              space0(),
              customField(password2Controller, "Confirm Password",
                  icon: Icons.lock, eye: eye),
              space0(),
              //security ques
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Security Question",
                      style: Theme.of(context).textTheme.bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: StatefulBuilder(builder:
                        (BuildContext context, StateSetter dropDownState) {
                      return DropdownButton<String>(
                        value: _chosenValue,
                        items: <String>[
                          'Favorite pet name',
                          'Mothers maiden name',
                          'High school you attend',
                          'Elementary school name',
                          'Favorite food as a child',
                          'Favorite movie',
                          'First exam you failed',
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ));
                        }).toList(),
                        onChanged: (String value) {
                          dropDownState(() {
                            _chosenValue = value;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              space0(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Security Answer",
                    style: Theme.of(context).textTheme.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: customField(
                    answerController,
                    "Answer",
                  ),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(flex: 1, child: Text("Gender")),
                  Expanded(
                    flex: 2,
                    child: Transform.scale(
                      scale: 2,
                      child: Switch(
                        trackColor: MaterialStateProperty.all(
                          CustomTheme.bgColor,
                        ),
                        activeColor: CustomTheme.bgColor,
                        inactiveThumbColor: CustomTheme.bgColor,
                        activeTrackColor: CustomTheme.bgColor,
                        activeThumbImage: AssetImage(
                          'assets/images/icons/icon4.png',
                        ),
                        inactiveThumbImage:
                            AssetImage('assets/images/icons/icon1.png'),
                        value: selectedGender,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            selectedGender = !selectedGender;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: this.value,
                    onChanged: (bool value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                  ),
                  Text("Accept "),
                  InkWell(
                    onTap: (() {
                      launchUrl(Uri.parse(
                        "https://instamealplans.com/terms-conditions/",
                      ));
                    }),
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Text(" & "),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.heightMultiplier * 4,
                  ),
                  InkWell(
                    onTap: (() {
                      launchUrl(Uri.parse(
                        "https://instamealplans.com/privacy-policy/",
                      ));
                    }),
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              space0(),
              (signupLoader)
                  ? CustomTheme.loader()
                  : InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(fn);
                        if (_signupey.currentState.validate() &&
                            password1Controller.text ==
                                password2Controller.text &&
                            value == true) {
                          // if (!appData.entitlementIsActive)
                          // perfomMagic(context);
                          postSignup(context);
                          // else {
                          //   customDialogue2(context);
                          // }
                        } else {
                          setState(() {
                            signupLoader = false;
                          });
                          Fluttertoast.showToast(
                            msg:
                                'Validation or Password error or Check the box',
                          );
                        }
                      },
                      child: customButton(context, Colors.white,
                          CustomTheme.bgColor, "Continue to Meal Plan"),
                    ),
              space0(),
              InkWell(
                onTap: (() {
                  setState(() {
                    loader2 = true;
                  });
                }),
                child: Center(
                  child: Text(
                    "Already a user, Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              space0(),
              space3()
            ],
          ),
        ),
      ),
    );
  }

  // updateSubscription(context, username) async {
  //   String url =
  //       "${Constants.baseUrl}updatesubscription/Username/$username/SubStart/${appData.appUserID}/SubEnd/${appData.entitlementIsActive}";
  //   var response = await Network.put(url: url).catchError(
  //     () {
  //       Fluttertoast.showToast(msg: "Server is not responding");
  //     },
  //   );
  //   if (response != null && response.contains("true")) {
  //     Fluttertoast.showToast(msg: "Successfully Subscribed");
  //     Constants.navigatepushreplac(
  //         context,
  //         Login(
  //           type: 1,
  //         ));
  //   } else {
  //     Fluttertoast.showToast(msg: "Something went wrong");
  //   }
  // }

  postSignup(context) async {
    print("now");
    final UniversalController universalController =
        Get.put(UniversalController());
    DateTime now =
        DateTime.parse(universalController.currentDate.value.toString());
    var formatDate =
        DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 1)));
    // DateTime formattedDate = DateTime.parse(formatDate);
    String formatNow = DateFormat('yyyy-MM-dd').format(now);
    print("formattedd");
    print(formatNow.toString());
    String url = "${Constants.baseUrl}signup";
    print(usernameController2.text.toString());
    print(password1Controller.text.toString());
    print(emailController.text.toString());
    print(answerController.text.toString());
    print(formatNow.toString());
    print(_chosenValue.toString());
    var payload = {
      "username": usernameController2.text.toString(),
      "password": password1Controller.text.toString(),
      "email": emailController.text.toString(),
      "subscriptionstart": "NOID",
      "subscriptionend": "false",
      "membershiptype": "Trial",
      "trialstatus": formatNow,
      "paymentstatus": "Trial",
      "question": _chosenValue.toString(),
      "answer": answerController.text.toString(),
      "gender": selectedGender ? "Male" : "Female"
    };
    print(payload);

    var response = await Network.post(url: url, payload: payload).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    print(payload);
    print(response);
    if (response != null && response.contains("true")) {
      // Fluttertoast.showToast(msg: "Signed Up");
      // setState(() {
      //   signupLoader = false;
      // });
      // Constants.navigatepushreplac(context, Login());
      box.write('username', usernameController2.text.toString());
      Constants.navigatepush(context, SubscribePlans());

      // perfomMagic(context, usernameController2.text.toString());
    } else if (response == "Username or Email already exist") {
      Fluttertoast.showToast(msg: "Username already exist");
      // setState(() {
      //   signupLoader = false;
      // });
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      // setState(() {
      //   signupLoader = false;
      // });
    }
  }

  Future<void> loginService(context) async {
    print("now");
    final UniversalController universalController =
        Get.put(UniversalController());
    DateTime now =
        DateTime.parse(universalController.currentDate.value.toString());
    var formatDate = DateFormat('yyyy-MM-dd').format(now);
    DateTime formattedDate = DateTime.parse(formatDate);
    print(formatDate);
    GetStorage box = GetStorage();
    box.write('plantype', "Plant-Based");
    box.write('planid', "3");
    print("planid ${box.read('planid')}");
    universalController.mart.value = 'walmart';
    universalController.plan.value = "Plant-Based";
    universalController.planid.value = 3;
    box.write('mart', 'walmart');
    box.write('amazonfresh', 'https://www.amazon.com/s?k=');
    box.write('walmart', 'https://www.walmart.com/search?q=');
    box.write('instacart', 'https://www.instacart.com/store/s?k=');
    box.write('kroger', 'https://kroger.com/search?query=');
    box.write('doordash', 'https://www.doordash.com/search/store/');
    String url =
        "${Constants.baseUrl}login/Email/${usernameController.text.toString()}/Password/${passwordController.text.toString()}";

    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    print(url);
    print(response.toString());
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      var loginModel = LoginModel.fromJson(jsonString);

      final notifContr = Get.put(NotifController());
      notifContr.fetchSearchCategRecipeController();
      setState(() {
        loginLoader = false;
      });
      print("userid" + loginModel.data[0].userid.toString());
      // Get.offAll(BottomNavigator());
      if (loginModel != null && loginModel.data.isNotEmpty) {
        {
          appData.appUserID = loginModel.data[0].subscriptionStart == "NOID"
              ? null
              : loginModel.data[0].subscriptionStart;
          // print("moiz appuserid" + appData.appUserID ?? "");
          box.write('userid', loginModel.data[0].userid);
          box.write('username', loginModel.data[0].username);
          box.write('email', loginModel.data[0].email);
          box.write('subscriptionStart', loginModel.data[0].subscriptionStart);
          box.write('subscriptionEnd', loginModel.data[0].subscriptionEnd);
          box.write('membershipType', loginModel.data[0].membershipType);
          box.write('trialStatus', loginModel.data[0].trialStatus);
          box.write('paymentStatus', loginModel.data[0].paymentStatus);
          box.write('gender', loginModel.data[0].gender);
          box.write('firsttime', 'yes');
          // if (loginModel.data[0].subscriptionStart != "NOID") {
          Get.offAll(BottomNavigator());
          // } else {
          //   Fluttertoast.showToast(msg: "Subscription Expired");
          // }
        }
      } else {
        setState(() {
          loginLoader = false;
        });
        Fluttertoast.showToast(msg: "Incorrect Credentials");
      }
    } else {
      setState(() {
        loginLoader = false;
      });
      Fluttertoast.showToast(msg: "Incorrect Credentials");
    }
  }

  // /*
  //   We should check if we can magically change the weather
  //   (subscription active) and if not, display the paywall.
  // */
  // void perfomMagic(ctx, username) async {
  //   // setState(() {
  //   //   signupLoader = true;
  //   // });
  //   print("perfomMagic");
  //   CustomerInfo customerInfo = await Purchases.getCustomerInfo();

  //   if (customerInfo.entitlements.all[entitlementID] != null &&
  //       customerInfo.entitlements.all[entitlementID].isActive == true) {
  //     appData.currentData = WeatherData.generateData();
  //     print("checking if");
  //   } else {
  //     print("checking else");

  //     Offerings offerings;
  //     try {
  //       print("checking getoffering try");
  //       offerings = await Purchases.getOfferings();
  //     } on PlatformException catch (e) {
  //       print("checking getoffering catch");

  //       await showDialog(
  //         context: context,
  //         builder: (BuildContext context) => ShowDialogToDismiss(
  //           title: "Error",
  //           content: e.message,
  //           buttonText: 'OK',
  //         ),
  //       );
  //     }

  //     if (offerings == null || offerings.current == null) {
  //       // offerings are empty, show a message to your user
  //       print("offerings null");
  //     } else {
  //       // current offering is available, show paywall
  //       await showModalBottomSheet(
  //         useRootNavigator: true,
  //         isDismissible: true,
  //         isScrollControlled: true,
  //         backgroundColor: Colors.white,
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
  //         ),
  //         context: context,
  //         builder: (BuildContext context) {
  //           return StatefulBuilder(
  //               builder: (BuildContext context, StateSetter setModalState) {
  //             return SingleChildScrollView(
  //               physics: BouncingScrollPhysics(
  //                   parent: AlwaysScrollableScrollPhysics()),
  //               child: SafeArea(
  //                 child: Wrap(
  //                   children: <Widget>[
  //                     Container(
  //                       height: 70.0,
  //                       width: double.infinity,
  //                       decoration: const BoxDecoration(
  //                           color: CustomTheme.bgColor,
  //                           borderRadius: BorderRadius.vertical(
  //                               top: Radius.circular(25.0))),
  //                       child: const Center(
  //                           child: Text('✨ Instameal Plans Premium')),
  //                     ),
  //                     const Padding(
  //                       padding: EdgeInsets.only(
  //                           top: 32, bottom: 16, left: 16.0, right: 16.0),
  //                       child: SizedBox(
  //                         child: Text(
  //                           'Instameal Plans we are offering: ',
  //                         ),
  //                         width: double.infinity,
  //                       ),
  //                     ),
  //                     ListView.builder(
  //                       itemCount: offerings.current.availablePackages.length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         var myProductList =
  //                             offerings.current.availablePackages;
  //                         return Card(
  //                           color: Colors.white,
  //                           child: ListTile(
  //                               onTap: () async {
  //                                 try {
  //                                   CustomerInfo customerInfo =
  //                                       await Purchases.purchasePackage(
  //                                           myProductList[index]);
  //                                   if (customerInfo.entitlements
  //                                       .all[entitlementID].isActive) {
  //                                     print("MOIZ IS PAID");
  //                                     // await postSignup(ctx);
  //                                     updateSubscription(ctx, username);
  //                                   } else {
  //                                     print("MOIZ IS NOT PAID");
  //                                   }

  //                                   // appData.entitlementIsActive = customerInfo
  //                                   //     .entitlements.all[entitlementID].isActive;
  //                                 } catch (e) {
  //                                   print(e);
  //                                   print("payment  error");
  //                                 }

  //                                 setState(() {});
  //                                 Navigator.pop(context);
  //                               },
  //                               title: Text(
  //                                 myProductList[index].storeProduct.title,
  //                               ),
  //                               subtitle: Text(
  //                                 myProductList[index].storeProduct.description,
  //                               ),
  //                               trailing: Text(
  //                                 myProductList[index].storeProduct.priceString,
  //                               )),
  //                         );
  //                       },
  //                       shrinkWrap: true,
  //                       physics: const ClampingScrollPhysics(),
  //                     ),
  //                     Center(
  //                       child: InkWell(
  //                         onTap: () {
  //                           launchUrl(Uri.parse(
  //                               "https://instamealplans.com/terms-conditions/"));
  //                         },
  //                         child: Text(
  //                           "By continuing, I agree to Terms and Conditions",
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .bodySmall
  //                               .copyWith(
  //                                   color: CustomTheme.primaryColor,
  //                                   fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           });
  //         },
  //       );
  //     }
  //   }
  // }

  // Future<void> initPlatformState() async {
  //   // Enable debug logs before calling `configure`.
  //   await Purchases.setDebugLogsEnabled(true);

  //   /*
  //   - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

  //   - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
  //   */
  //   PurchasesConfiguration configuration;
  //   if (StoreConfig.isForAmazonAppstore()) {
  //     configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
  //       ..appUserID = null
  //       ..observerMode = false;
  //   } else {
  //     configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
  //       ..appUserID = null
  //       ..observerMode = false;
  //   }
  //   await Purchases.configure(configuration);

  //   appData.appUserID = await Purchases.appUserID;

  //   Purchases.addCustomerInfoUpdateListener((customerInfo) async {
  //     appData.appUserID = await Purchases.appUserID;

  //     CustomerInfo customerInfo = await Purchases.getCustomerInfo();
  //     (customerInfo.entitlements.all[entitlementID] != null &&
  //             customerInfo.entitlements.all[entitlementID].isActive)
  //         ? appData.entitlementIsActive = true
  //         : appData.entitlementIsActive = false;

  //     setState(() {});
  //   });
  // }

}
