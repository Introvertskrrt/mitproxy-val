
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/valorant_search_services.dart';

class SearchPlayerController extends GetxController {
  TextEditingController playername = TextEditingController();
  TextEditingController tag = TextEditingController();
  final valorantSearchServices = ValorantSearchServices();

  RxBool isOnFirstLoad = true.obs;
  RxBool isOnSearching = false.obs;
  RxBool isError = false.obs;

  Future<void> searchButtonClicked() async {
    try{
      isOnFirstLoad.value = false;
      isOnSearching.value = true;
      await valorantSearchServices.getPlayerMatchHistory(playername.text, tag.text);
      isError.value = false;
      isOnSearching.value = false;
    } on ExceptionPlayerNotFound {
      isOnSearching.value = false;
      isOnFirstLoad.value = false;
      isError.value = true;
    }
  }
}