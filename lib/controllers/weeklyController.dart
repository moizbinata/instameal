import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instameal/models/weekly_model.dart';

import '../services/weeklyservices.dart';

class WeeklyController extends GetxController {
  RxList<WeeklyModel> listofWeekly = <WeeklyModel>[].obs;
  RxList<WeeklyModel> listofWeeklyImage = <WeeklyModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchWeekly();
  }

  refreshProdandWeekly() async {
    await fetchWeekly();
  }

  Future<void> fetchWeekly() async {
    await Future.delayed(Duration.zero);
    listofWeekly.clear();
    var weekly = await WeeklyService.fetchWeekly();
    if (weekly != null) {
      listofWeekly.add(weekly);
      print("moiz");
      print(listofWeekly.first.data.first.categName);
      print(listofWeekly.first.data.first.cookTime);
    } else {
      listofWeekly.length = 0;
    }
    print(listofWeekly);

    update();
  }
}
