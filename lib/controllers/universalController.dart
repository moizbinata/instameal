import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/services/universalservices.dart';

import '../models/universal_model.dart';
import '../services/weeklyservices.dart';

class UniversalController extends GetxController {
  RxList<UniversalModel> listofUniversal = <UniversalModel>[].obs;
  RxList<Fav> listofFav = <Fav>[].obs;
  RxList<Festival> listofFestival = <Festival>[].obs;
  RxList<Collection> listofCollection = <Collection>[].obs;
  RxList<Dessert> listofDesserts = <Dessert>[].obs;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUniversal();
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
        print("moiz");
        print(listofUniversal.first.collection.first.planName);
        print(listofUniversal.first.dessert.first.planName);
        print(listofUniversal.first.festival.first.planName);
        //favourite
        if (listofUniversal.first.fav != null ||
            listofUniversal.first.fav.length > 0)
          listofFav.addAll(listofUniversal.first.fav);
        //festival
        if (listofUniversal.first.festival != null ||
            listofUniversal.first.festival.length > 0) {
          listofFestival.addAll(listofUniversal.first.festival);
        }
        //collection
        if (listofUniversal.first.collection != null ||
            listofUniversal.first.collection.length > 0)
          listofCollection.addAll(listofUniversal.first.collection);
        //dessert
        if (listofUniversal.first.dessert != null ||
            listofUniversal.first.dessert.length > 0)
          listofDesserts.addAll(listofUniversal.first.dessert);
      }
      print("moiz");
      print(listofFav);
      print(listofFestival);
      print(listofCollection);
      print(listofDesserts);
    } else {
      listofUniversal.length = 0;
    }
    update();
  }
}
