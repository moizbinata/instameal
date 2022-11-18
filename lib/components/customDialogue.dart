import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/controllers/universalController.dart';

import '../utils/sizeconfig.dart';
import '../utils/theme.dart';
import 'components.dart';

void customDialogue(context) {
  GetStorage box = GetStorage();
  String _chosenValue = "instacart";
  final universalController = Get.put(UniversalController());

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: SizeConfig.heightMultiplier * 30, minHeight: 56.0),
            // height: 200,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Change Online Shopping Mart",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Center(
                    child: StatefulBuilder(builder:
                        (BuildContext context, StateSetter dropDownState) {
                      return DropdownButton<String>(
                        value: _chosenValue,
                        items: <String>[
                          'instacart',
                          'amazon',
                          'kroger',
                          'shipt',
                          'walmart',
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.heightMultiplier * 0.5,
                                  horizontal: SizeConfig.heightMultiplier),
                              child: Container(
                                child: Image.asset(
                                  'assets/images/shop/$value.png',
                                  height: SizeConfig.heightMultiplier * 5,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          dropDownState(() {
                            _chosenValue = value;
                          });
                        },
                      );
                    }),
                  ),
                  InkWell(
                    onTap: () {
                      // UniversalController universalController =
                      //     UniversalController();
                      universalController.mart.value = _chosenValue;
                      box.write('mart', _chosenValue);
                      print(universalController.mart.value);
                      Navigator.pop(context);
                    },
                    child: customButton(
                        context, Colors.white, CustomTheme.bgColor, "Save"),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}