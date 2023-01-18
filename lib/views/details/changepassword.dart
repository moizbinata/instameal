import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:http/http.dart' as http;
import 'package:instameal/components/components.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/login.dart';

class ChangePass extends StatefulWidget {
  ChangePass({Key key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController passcontr = TextEditingController();

  TextEditingController cpasscontr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatButton(context),
      backgroundColor: CustomTheme.bgColor2,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: SizeConfig.screenHeight,
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextButton(onPressed: () => sendOTP(), child: Text("sdf")),
              Image.asset(
                "assets/mealimg/forgot.webp",
                width: SizeConfig.screenWidth * 0.5,
              ),
              Center(
                child: Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.bodyLarge.copyWith(
                        color: CustomTheme.bgColor,
                      ),
                ),
              ),
              space1(),
              customField(
                passcontr,
                "Password",
                icon: Icons.lock,
              ),
              customField(
                cpasscontr,
                "Confirm Password",
                icon: Icons.lock,
              ),
              space0(),
              InkWell(
                  onTap: () {
                    if (passcontr.text.toString().isNotEmpty &&
                        passcontr.text.toString() ==
                            cpasscontr.text.toString()) {
                      changeapass(context);
                    } else {
                      Fluttertoast.showToast(msg: 'Password not matched');
                    }
                  },
                  child: customButton(context, Colors.white,
                      CustomTheme.bgColor, "Change Password")),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changeapass(context) async {
    var client = http.Client();
    GetStorage box = GetStorage();
    String url =
        "${Constants.baseUrl}forgotpass/Phone/${box.read('userid')}/Password/${passcontr.text.toString()}";
    Map<String, String> apiHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    print(url);
    var response = await client.put(Uri.parse(url), headers: apiHeaders);
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Successfully updated');
      Get.offAll(Login(
        type: 1,
      ));
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}
