import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:http/http.dart' as http;
import '../../components/components.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';

class SecureQues extends StatefulWidget {
  const SecureQues({Key key}) : super(key: key);

  @override
  State<SecureQues> createState() => _SecureQuesState();
}

class _SecureQuesState extends State<SecureQues> {
  TextEditingController emailController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  String _chosenValue = "Favorite pet name";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatButton(context),
      backgroundColor: CustomTheme.bgColor2,
      body: SingleChildScrollView(
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
                  "Security Question",
                  style: Theme.of(context).textTheme.bodyLarge.copyWith(
                        color: CustomTheme.bgColor,
                      ),
                ),
              ),
              space0(),
              customField(emailController, "Email",
                  icon: FontAwesomeIcons.envelope),
              space0(),
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
              space1(),

              InkWell(
                onTap: () {
                  if (answerController.text.toString().isNotEmpty &&
                      emailController.text.toString().isNotEmpty) {
                    secureQuestions(context);
                  } else {
                    Fluttertoast.showToast(msg: 'Field empty');
                  }
                },
                child: customButton(
                  context,
                  Colors.white,
                  CustomTheme.bgColor,
                  "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> secureQuestions(context) async {
    var client = http.Client();
    String url =
        "${Constants.baseUrl}secureques/Email/${emailController.text.toString()}/Question/${_chosenValue.toString()}/Answer/${answerController.text.toString()}";
    print(url);
    Map<String, String> apiHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await client.get(Uri.parse(url), headers: apiHeaders);
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Successfully Confirmed');
      Constants.navigatepush(context, SecureQues());
      // Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}
