// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/controllers/login_controller.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/valorant_services.dart';

class LiveController extends GetxController {
  final valorantServices = ValorantServices();
  final loginController = Get.put(LoginController());

  // party
  TextEditingController partyCode = TextEditingController();
  TextEditingController joinPartCode = TextEditingController();
  RxString buttonGenerateCode_Text = "GENERATE CODE".obs;
  RxString currentGameMode_Text = "Unrated".obs;
  RxString buttonMatchmaking_Text = "START MATCHMAKING".obs;
  RxBool isPartyCodeGenerated = false.obs;
  RxBool isPlayerInGame = false.obs;
  RxBool isPartyReady = true.obs;
  RxBool isPartyOpen = false.obs;
  RxBool isOnMatchmaking = false.obs;

  Timer? _timer;
  RxInt seconds = 0.obs;
  RxInt minutes = 0.obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    while (true) {
      try {
        await valorantServices.getPartyData();
        await valorantServices.getPreGameMatch();
        isPlayerInGame.value = true;
        await Future.delayed(const Duration(seconds: 3));
      } on ExceptionPlayerNotInGame {
        isPlayerInGame.value = false;
      } on ExceptionValApi {
        loginController.fetchLogin();
      }
    }
  }

  void copyPartyCodeToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
      duration: Duration(seconds: 1),
    ));
  }

  void startMatchmakingTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds.value++;
      if (seconds.value == 60) {
        seconds.value = 0;
        minutes.value++;
      }
    });
  }

  void stopMatchmakingTimer() {
    _timer?.cancel();
    seconds.value = 0;
    minutes.value = 0;
  }
}
