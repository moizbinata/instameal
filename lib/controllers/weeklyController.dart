import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/models/images_model.dart';
import 'package:instameal/models/weekly_model.dart';

import '../services/weeklyservices.dart';

class WeeklyController extends GetxController {
  RxList<WeeklyModel> listofWeekly = <WeeklyModel>[].obs;
  RxList<WeeklyRecipe> listofPlanWeekly = <WeeklyRecipe>[].obs;
  RxList<ImagesModel> listofWeeklyImages = <ImagesModel>[].obs;

  RxList<WeeklyRecipe> week1Recipe2d = <WeeklyRecipe>[].obs;
  RxList<WeeklyRecipe> week2Recipe2d = <WeeklyRecipe>[].obs;
  RxList<WeeklyRecipe> week3Recipe2d = <WeeklyRecipe>[].obs;
  RxList<WeeklyRecipe> week4Recipe2d = <WeeklyRecipe>[].obs;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchWeeklyImage();
    fetchWeekly();
  }

  refreshProdandWeekly() async {
    await fetchWeekly();
  }

// static const extension ListFiller<T> on List<T> {
//   void fillAndSet(int index, T value) {
//     if (index >= this.length) {
//       this.addAll(List<T>.filled(index - this.length + 1, null));
//     }
//     this[index] = value;
//   }
// }
  Future<void> fetchWeeklyImage() async {
    await Future.delayed(Duration.zero);
    listofWeeklyImages.clear();
    var weekly = await WeeklyService.fetchWeeklyImages();
    if (weekly != null) {
      listofWeeklyImages.add(weekly);
      print("moiz");
      print(listofWeeklyImages.first.data.first.imageCateg);
      print(listofWeeklyImages.first.data.first.imageUrl);
    } else {
      listofWeeklyImages.length = 0;
    }
    print(listofWeeklyImages);

    update();
  }

  Future<void> fetchWeekly() async {
    await Future.delayed(Duration.zero);
    listofWeekly.clear();
    int planId = int.tryParse(box.read('planId').toString());
    var weekly = await WeeklyService.fetchWeekly();
    if (weekly != null) {
      listofWeekly.add(weekly);
      for (var element in listofWeekly.first.data) {
        if (element.planName == box.read('plantype').toString()) {
          listofPlanWeekly.add(element);
        }
      }
      for (int a = 0; a < 4; a++) {
        for (var element in listofPlanWeekly) {
          if (element.planId == planId && element.weekNumber == 1) {
            week1Recipe2d.add(element);
          }
          if (element.planId == planId && element.weekNumber == 2) {
            week2Recipe2d.add(element);
          }
          if (element.planId == planId && element.weekNumber == 3) {
            week3Recipe2d.add(element);
          }
          if (element.planId == planId && element.weekNumber == 4) {
            week4Recipe2d.add(element);
          }
          // for (int i = 0; i < 7; i++) {
          //   for (int j = 0; j < 4; j++) {
          //     if (int.tryParse(element.day) == i + 1 &&
          //         element.categoryId == j + 1 &&
          //         element.weekNumber == a + 1) {
          //       week1Recipe2d[i].add(element);
          //       print(week1Recipe2d[i][j]);
          //     } else if (int.tryParse(element.day) == i + 1 &&
          //         element.categoryId == j + 1 &&
          //         element.weekNumber == a + 2) {
          //       week2Recipe2d[i].add(element);
          //     } else if (int.tryParse(element.day) == i + 1 &&
          //         element.categoryId == j + 1 &&
          //         element.weekNumber == a + 3) {
          //       week3Recipe2d[i].add(element);
          //     } else if (int.tryParse(element.day) == i + 1 &&
          //         element.categoryId == j + 1 &&
          //         element.weekNumber == a + 4) {
          //       week4Recipe2d[i].add(element);
          //     }
          //   }
          // }
        }
      }
      print("weeklyrecipe1");
      for (int i = 0; i < week1Recipe2d.length; i++) {
        print(week1Recipe2d.length);
      }
      print(week1Recipe2d);
      print(week2Recipe2d);
      print(week3Recipe2d);
      print(week4Recipe2d);
    } else {
      listofWeekly.length = 0;
    }
    update();
  }
}
