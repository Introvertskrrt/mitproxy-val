
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/search_data_services.dart';

class SearchPlayerController extends GetxController {
  TextEditingController playername = TextEditingController();
  TextEditingController tag = TextEditingController();
  final searchServices = SearchServices();

  RxBool isOnFirstLoad = true.obs;
  RxBool isOnSearching = false.obs;
  RxBool isPlayerNotFound = false.obs;
  RxBool isFailedToGetCareer = false.obs;

  Future<void> searchButtonClicked() async {
    try{
      isOnFirstLoad.value = false;
      isOnSearching.value = true;
      await searchServices.getPlayerMatchHistory(playername.text, tag.text);
      isPlayerNotFound.value = false;
      isFailedToGetCareer.value = false;
      isOnSearching.value = false;
    } on ExceptionPlayerNotFound {
      isOnSearching.value = false;
      isOnFirstLoad.value = false;
      isPlayerNotFound.value = true;
    } on ExceptionFailedToGetCareer {
      isFailedToGetCareer.value = true;
      isOnSearching.value = false;
    }
  }
}