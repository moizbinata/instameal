import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/navigation/bottom_navigator.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/details/changepassword.dart';
import 'package:instameal/views/details/securityques.dart';
import 'package:instameal/views/subscription/trial_screen.dart';
import 'package:intl/intl.dart';

import '../components/components.dart';
import '../controllers/universalController.dart';
import '../models/loginmodel.dart';
import '../utils/network.dart';
import '../utils/sizeconfig.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loginLoader = false;
  bool signupLoader = false;
  bool eye = true;
  FocusNode fn = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final _signupey = GlobalKey<FormState>();
  String _chosenValue = "Favorite pet name";

  //login
  TextEditingController usernameController =
      TextEditingController(text: 'decrs@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: 'abc123');

  //signup
  TextEditingController usernameController2 = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  TextEditingController password1Controller = TextEditingController();

  TextEditingController password2Controller = TextEditingController();
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final universalController = Get.put(UniversalController());

    return Scaffold(
      backgroundColor: CustomTheme.bgColor2,
      body: SafeArea(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 3),
          // height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              space2(),
              Image.asset(
                "assets/images/logo.png",
                height: SizeConfig.heightMultiplier * 13,
                fit: BoxFit.contain,
              ),
              space3(),
              DefaultTabController(
                length: 2,
                child: Column(children: [
                  Container(
                    child: TabBar(
                      indicatorColor: CustomTheme.bgColor,
                      tabs: [
                        Tab(
                          child: Text(
                            "Login",
                            style:
                                Theme.of(context).textTheme.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Sign-up",
                            style:
                                Theme.of(context).textTheme.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //Add this to give height
                    height: SizeConfig.screenHeight * 0.6,
                    child: TabBarView(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customField(usernameController, "Email address",
                                  icon: Icons.mail),
                              space1(),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: customField(
                                        passwordController, "Password",
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
                                        context, SecureQues());
                                  },
                                  child: Text(
                                    "Forgot Password",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: CustomTheme.bgColor),
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
                                          Fluttertoast.showToast(
                                              msg: 'Validation error');
                                          setState(() {
                                            loginLoader = false;
                                          });
                                        }
                                      },
                                      child: customButton(context, Colors.white,
                                          CustomTheme.bgColor, "Login"),
                                    ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Form(
                            key: _signupey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                space0(),
                                customField(usernameController2, "Username",
                                    icon: Icons.account_circle),
                                space0(),
                                customField(emailController, "Email",
                                    icon: Icons.mail),
                                space0(),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: customField(
                                          password1Controller, "Password",
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
                                customField(
                                    password2Controller, "Confirm Password",
                                    icon: Icons.lock, eye: eye),
                                space0(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Security Question",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter dropDownState) {
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                space1(),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Security Answer",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              .copyWith(
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
                                space2(),
                                (signupLoader)
                                    ? CustomTheme.loader()
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            signupLoader = true;
                                          });
                                          FocusScope.of(context)
                                              .requestFocus(fn);
                                          if (_signupey.currentState
                                                  .validate() &&
                                              password1Controller.text ==
                                                  password2Controller.text) {
                                            postSignup(context);
                                          } else {
                                            setState(() {
                                              signupLoader = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Validation error or Password not matched');
                                          }
                                        },
                                        child: customButton(
                                            context,
                                            Colors.white,
                                            CustomTheme.bgColor,
                                            "Continue to Meal Plan")),
                                space3()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // space3(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  postSignup(context) async {
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
      "subscriptionstart": formatNow,
      "subscriptionend": formatNow,
      "membershiptype": "Daily",
      "trialstatus": formatNow,
      "paymentstatus": "Unpaid",
      "question": _chosenValue.toString(),
      "answer": answerController.text.toString()
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
      Fluttertoast.showToast(msg: "Signed Up");
      setState(() {
        signupLoader = false;
      });
      Constants.navigatepushreplac(context, Login());
    } else if (response == "Username or Email already exist") {
      Fluttertoast.showToast(msg: "Username already exist");
      setState(() {
        signupLoader = false;
      });
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      setState(() {
        signupLoader = false;
      });
    }
  }

  Future<void> loginService(context) async {
    print("now");
    print(now.toString());
    var formatDate =
        DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 1)));
    DateTime formattedDate = DateTime.parse(formatDate);
    print(formatDate);
    final UniversalController universalController =
        Get.put(UniversalController());
    GetStorage box = GetStorage();
    box.write('plantype', "Plant-Based");
    box.write('planid', "3");
    print("planid ${box.read('planid')}");
    universalController.mart.value = 'shipt';
    universalController.plan.value = "Plant-Based";
    universalController.planid.value = 3;
    box.write('mart', 'amazonfresh');
    box.write('amazonfresh', 'https://www.amazon.com/s?k=');
    box.write('walmart', 'https://www.walmart.com/search?q=');
    box.write('instacart', 'https://www.instacart.com/store/s?k=');
    box.write('kroger', 'https: //kroger.com/search?query=');
    box.write('shipt', 'https: //kroger.com/search?query=');
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
      if (loginModel != null && loginModel.data.isNotEmpty) {
        Fluttertoast.showToast(msg: "Login Successfully");
        box.write('userid', loginModel.data[0].userid);
        box.write('username', loginModel.data[0].username);
        box.write('email', loginModel.data[0].email);
        box.write('subscriptionStart', loginModel.data[0].subscriptionStart);
        box.write('subscriptionEnd', loginModel.data[0].subscriptionEnd);
        box.write('membershipType', loginModel.data[0].membershipType);
        box.write('trialStatus', loginModel.data[0].trialStatus);
        box.write('paymentStatus', loginModel.data[0].paymentStatus);
        setState(() {
          loginLoader = false;
        });
        if (DateTime.parse(loginModel.data[0].subscriptionEnd)
                .isAfter(formattedDate) &&
            loginModel.data[0].paymentStatus == "Paid")
          Constants.navigatepushreplac(context, BottomNavigator());
        else
          Constants.navigatepushreplac(context, TrialScreen());
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
}
