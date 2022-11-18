import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/services/universalservices.dart';

import '../models/universal_model.dart';
import '../services/weeklyservices.dart';

class UniversalController extends GetxController {
  RxList<UniversalModel> listofUniversal = <UniversalModel>[].obs;
  RxList<Collection> listofFav = <Collection>[].obs;
  RxList<Collection> listofFestival = <Collection>[].obs;
  RxList<Collection> listofCollection = <Collection>[].obs;
  RxList<Collection> listofDesserts = <Collection>[].obs;
  RxString mart = "".obs;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUniversal();
    mart.value = box.read('mart');
  }

  refreshUniversal() async {
    await fetchUniversal();
  }

  Future<void> fetchUniversal() async {
    await Future.delayed(Duration.zero);
    listofUniversal.clear();

    var universal = await UniversalService.fetchUniversal();
    if (universal != null) {
      listofUniversal.add(universal);
      if (listofUniversal.length > 0) {
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
}
