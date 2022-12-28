import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/models/allrecipemodel.dart';
import 'package:instameal/models/planmodel.dart';
import 'package:instameal/services/universalservices.dart';

import '../models/universal_model.dart';
import '../services/weeklyservices.dart';

class UniversalController extends GetxController {
  RxList<AllRecipeModel> listofAllRecipe = <AllRecipeModel>[].obs;
  RxList<UniversalModel> listofUniversal = <UniversalModel>[].obs;
  RxList<PModel> listofPlans = <PModel>[].obs;
  RxList<Collection> listofFav = <Collection>[].obs;
  RxList<Collection> listofFestival = <Collection>[].obs;
  RxList<Collection> listofCollection = <Collection>[].obs;
  RxList<Collection> listofDesserts = <Collection>[].obs;
  RxString mart = "".obs;
  RxString currentDate = "".obs;
  RxString plan = "".obs;
  RxInt planid = 0.obs;
  RxInt currentPage = 0.obs;
  RxMap<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Meal Plans": GlobalKey<NavigatorState>(),
    "Shopping List": GlobalKey<NavigatorState>(),
    "Favourite": GlobalKey<NavigatorState>(),
    "Search": GlobalKey<NavigatorState>(),
  }.obs;
  GetStorage box = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllRecipes();
    fetchUniversal();
    fetchPlans();
    mart.value = box.read('mart');
    plan.value = box.read('plantype') ?? "";
  }

  refreshUniversal() async {
    await fetchUniversal();
  }

  int getPlanIdbyName(planname) {
    print("getPlanIdbyName");
    print(planname);
    int planid = 0;
    listofPlans.forEach((element) {
      if (element.planName == planname) {
        planid = element.planId;
      }
    });
    print(planid);
    return planid;
  }

  Future<void> fetchUniversal() async {
    await Future.delayed(Duration.zero);
    listofUniversal.clear();
    print("fetchUniversal");
    var universal = await UniversalService.fetchUniversal();
    if (universal != null) {
      listofUniversal.add(universal);
      if (listofUniversal.length > 0) {
        currentDate.value = listofUniversal.first.date;
        //favourite
        if (listofUniversal.first.fav != null ||
            listofUniversal.first.fav.length > 0) {
          listofFav.assignAll(listofUniversal.first.fav.first);
        }
        //festival
        if (listofUniversal.first.festival != null ||
            listofUniversal.first.festival.length > 0) {
          {
            listofFestival.assignAll(listofUniversal.first.festival.first);
          }
        }
        //collection
        if (listofUniversal.first.collection != null ||
            listofUniversal.first.collection.length > 0) {
          {
            listofCollection.assignAll(listofUniversal.first.collection.first);
          }
        }
        //dessert
        if (listofUniversal.first.dessert != null ||
            listofUniversal.first.dessert.length > 0) {
          listofDesserts.assignAll(listofUniversal.first.dessert.first);
        }
      }
    } else {
      listofUniversal.length = 0;
    }
    update();
  }

  Future<void> fetchPlans() async {
    await Future.delayed(Duration.zero);
    var plans = await UniversalService.fetchPlans();
    if (plans.data.isNotEmpty) {
      listofPlans.assignAll(plans.data);
    } else {
      listofPlans.length = 0;
    }
    update();
  }

  Future<void> fetchAllRecipes() async {
    await Future.delayed(Duration.zero);
    var plans = await UniversalService.fetchAllRecipes();
    if (plans.data.isNotEmpty) {
      listofAllRecipe.assignAll(plans.data.reversed.toList());
    } else {
      listofAllRecipe.length = 0;
    }
    update();
  }
}
