import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/models/images_model.dart';
import 'package:instameal/models/universal_model.dart';
import 'package:instameal/models/weekly_model.dart';
import 'package:intl/intl.dart';
import '../services/weeklyservices.dart';

class WeeklyController extends GetxController {
  RxList<ImagesModel> listofWeeklyImages = <ImagesModel>[].obs;
  RxList<ImgData> listcurrWeekImg = <ImgData>[].obs;
  RxInt currentRxWeek = 0.obs;
  GetStorage box = GetStorage();
  RxList<WeeklyModel> listofWeekly = <WeeklyModel>[].obs;
  RxList<Breakfast> listofWeeklyBfast = <Breakfast>[].obs;
  RxList<Breakfast> listofWeeklyLunch = <Breakfast>[].obs;
  RxList<Breakfast> listofWeeklySnack = <Breakfast>[].obs;
  RxList<Breakfast> listofWeeklyDinner = <Breakfast>[].obs;
  RxList<Breakfast> listCartRecipe1 = <Breakfast>[].obs;
  RxList<Collection> listCartRecipe2 = <Collection>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchWeeklyImage();
    // getCartRecipe();
  }

  getCartRecipe() {
    if (box.read('collection') != null) {
      List<Collection> abc = [];
      abc = List<Collection>.from(box.read('collection'));
      print(abc);
    }
    if (box.read('breakfast') != null) {
      List<Breakfast> abc = [];
      abc = List<Breakfast>.from(box.read('breakfast'));
      print(abc);
    }
  }

  /// Calculates number of weeks for a given year as per
  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  /// Calculates week number from a date as per
  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  Future<void> fetchWeekly(plan, week) async {
    await Future.delayed(Duration.zero);
    listofWeekly.clear();
    var weekly = await WeeklyService.fetchWeeklyRecipes(plan, week);
    if (weekly != null && !weekly.isBlank) {
      listofWeekly.assign(weekly);
      print(listofWeekly.first.breakfast.first);
      if (listofWeekly.first.breakfast != null) {
        listofWeeklyBfast.assignAll(listofWeekly.first.breakfast.first);
      } else {
        listofWeeklyBfast.length = 0;
      }

      if (listofWeekly.first.lunch != null) {
        listofWeeklyLunch.assignAll(listofWeekly.first.lunch.first);
      } else {
        listofWeeklyLunch.length = 0;
      }
      if (listofWeekly.first.snack != null) {
        listofWeeklySnack.assignAll(listofWeekly.first.snack.first);
      } else {
        listofWeeklySnack.length = 0;
      }
      if (listofWeekly.first.dinner != null) {
        listofWeeklyDinner.assignAll(listofWeekly.first.dinner.first);
      } else {
        listofWeeklyDinner.length = 0;
      }
    } else {
      listofWeekly.length = 0;
    }
    update();
  }

  Future<void> fetchWeeklyImage() async {
    await Future.delayed(Duration.zero);
    int currentWeek = weekNumber(DateTime.now());
    currentRxWeek.value = currentWeek;
    print(currentWeek.toString());
    listofWeeklyImages.clear();
    print(currentWeek);
    var weekly = await WeeklyService.fetchWeeklyImages();
    if (weekly != null) {
      listofWeeklyImages.assign(weekly);
      listcurrWeekImg.assignAll(
        {
          listofWeeklyImages.first.data[currentWeek - 1],
          listofWeeklyImages.first.data[currentWeek]
        },
      );
    } else {
      listofWeeklyImages.length = 0;
    }
    update();
  }
}
