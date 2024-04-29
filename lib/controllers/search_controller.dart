
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/valorant_search_services.dart';

class SearchPlayerController extends GetxController {
  TextEditingController playername = TextEditingController();
  TextEditingController tag = TextEditingController();
  final valorantSearchServices = ValorantSearchServices();

  RxBool isPageLoading = true.obs;
  RxBool isError = false.obs;

  Future<void> getPlayerData() async {
    try{
      isPageLoading.value = true;
      await valorantSearchServices.getPlayerData(playername.text, tag.text);
      isError.value = false;
      isPageLoading.value = false;
    } on ExceptionPlayerNotFound {
      isError.value = true;
    }
  }
}