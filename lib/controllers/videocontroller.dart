import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/models/notifmodel.dart';
import 'package:instameal/models/videomodel.dart';
import 'package:instameal/services/notifsercice.dart';

class VideoController extends GetxController {
  RxList<VideoModel> listofVideos = <VideoModel>[].obs;
  RxInt selectedPlan = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchSearchCategRecipeController();
  }

  Future<void> fetchSearchCategRecipeController() async {
    await Future.delayed(Duration.zero);
    GetStorage box = GetStorage();

    var response = await NotifService.fetchVideos();
    if (response != null && response.data != null && response.data.isNotEmpty) {
      listofVideos.assignAll(response.data);
    }
    update();
  }
}
