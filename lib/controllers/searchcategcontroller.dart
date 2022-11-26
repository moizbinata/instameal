import 'package:get/get.dart';
import 'package:instameal/services/scrservices.dart';

import '../models/searchcategmodel.dart';
import '../models/searchcategrecipemodel.dart';

class SearchCategController extends GetxController {
  RxList<SCRecipeModel> listofSCRecipe = <SCRecipeModel>[].obs;
  RxList<SCRecipeModel> filteredSCRecipe = <SCRecipeModel>[].obs;
  RxList<SCategModel> listofSCateg = <SCategModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchSearchCategRecipeController();
    fetchSearchCategController();
  }

  Future<void> refreshSCateg(scategid) async {
    await fetchSearchCategRecipeController();
    await filterSCategRecipe(scategid);
  }

  Future<void> filterSCategRecipe(scategid) async {
    await Future.delayed(Duration.zero);
    print("scateg " + scategid.toString());
    print("scateg recipe length" + listofSCRecipe.length.toString());
    filteredSCRecipe.assignAll(
        listofSCRecipe.where(((p0) => p0.searchcategid == scategid)).toList());
    print("scateg filtered length" + filteredSCRecipe.length.toString());

    update();
  }

  Future<void> fetchSearchCategRecipeController() async {
    await Future.delayed(Duration.zero);
    var response = await SCRServices.fetchSearchCategRecipe();
    if (response.data != null && response.data.isNotEmpty) {
      listofSCRecipe.assignAll(response.data);
    }
    update();
  }

  Future<void> fetchSearchCategController() async {
    await Future.delayed(Duration.zero);
    var response = await SCRServices.fetchSearchCateg();
    if (response.data != null && response.data.isNotEmpty) {
      listofSCateg.assignAll(response.data);
    }
    update();
  }
}
