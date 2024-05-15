// ignore_for_file: non_constant_identifier_names, empty_catches

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mitproxy_val/controllers/login_controller.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/globals.dart';
import 'package:mitproxy_val/utils/live_data_services.dart';
import 'package:mitproxy_val/utils/valorant_client_services.dart';

class LiveController extends GetxController {
  final liveServices = LiveServices();
  final loginController = Get.put(LoginController());
  Timer? periodicTimer;
  Timer? _timer;
  RxInt seconds = 0.obs;
  RxInt minutes = 0.obs;
  RxBool isUserNotified = false.obs;

  ///
  /// These variables are for Real-Time Data
  ///

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

  RxString partyId = ''.obs;
  RxList<String> playerNames = <String>[].obs;
  RxList<String> playerCards = <String>[].obs;
  RxList<int> playerLevels = <int>[].obs;
  RxList<String> playerRanks = <String>[].obs;

  // matches
  RxString preMatchId = "".obs;
  RxString mapName = "".obs;
  RxString mapBanner = "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/listviewicon.png".obs;
  RxString gameMode = ''.obs;

  RxString allyTeamId = ''.obs;
  RxList<String> allyPlayerNames = <String>[].obs;
  RxList<String> allyAgentImages = <String>[].obs;
  RxList<bool> allySelectionStates = <bool>[].obs;
  RxList<String> allyRanks = <String>[].obs;
  Rx<Color> allyTeamColor = const Color.fromARGB(255, 255, 255, 255).obs;

  RxString enemyTeamId = ''.obs;
  RxList<String> enemyPlayerNames = <String>[].obs;
  RxList<String> enemyAgentImages = <String>[].obs;
  RxList<bool> enemySelectionStates = <bool>[].obs;
  RxList<String> enemyRanks = <String>[].obs;
  Rx<Color> enemyTeamColor = const Color.fromARGB(255, 255, 255, 255).obs;

  // Instalock
  RxString buttonLockIn_Text = "LOCK IN".obs;
  RxList<String> allAgentsIds = <String>[].obs;
  RxList<String> allAgentsImages = <String>[].obs;
  RxList<String> allAgentsNames = <String>[].obs;
  RxString selectedAgentName = 'Gekko'.obs;
  RxString selectedAgentId = 'e370fa57-4757-3604-3648-499e1f642d3f'.obs; // gekko uuid
  bool isInstalocking = false;
  var isSelectedList = <RxBool>[];

  RxBool isAgentSelected(int index) {
    return isSelectedList[index];
  }

  void toggleAgentSelection(int index) {
    isSelectedList[index].value = !isSelectedList[index].value;
  }

  void initializeSelectedList() {
    isSelectedList.assignAll(List.generate(allAgentsIds.length, (_) => false.obs));
  }

  Future<void> initializeAgents() async {
    await liveServices.getAgentsData();
    initializeSelectedList();
  }

  @override
  void onInit() async {
    super.onInit();
    periodicTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchLiveData();
    });
  }

  @override
  void onClose() {
    periodicTimer?.cancel();
    super.onClose();
  }

  void fetchLiveData() async {
    try {
      await liveServices.getPartyData();
      await liveServices.getPreGame();
      isPlayerInGame.value = true;
    } on ExceptionPlayerNotInGame {
      log("ExceptionPlayerNotInGame");
      isPlayerInGame.value = false;
    } on ExceptionTokenExpired {
      log("ExceptionTokenExpired");
      await loginController.fetchLogin(Globals.temporarySavedAccount!.username, Globals.temporarySavedAccount!.password);
    } on ClientException {
      log("ClientException");
      isPlayerInGame.value = false;
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

  Future<void> buttonStartMatchmakingClicked() async {
    if (!isOnMatchmaking.value) {
      ValorantClientServices.postEntermatchmaking(partyId.value);
      buttonMatchmaking_Text.value = "STOP MATCHMAKING";
      isOnMatchmaking.value = true;
      startMatchmakingTimer();
    } else {
      ValorantClientServices.postLeavematchmaking(partyId.value);
      buttonMatchmaking_Text.value = "START MATCHMAKING";
      isOnMatchmaking.value = false;
      stopMatchmakingTimer();
    }
  }

  Future<void> buttonJoinPartyCodeClicked() async {
    ValorantClientServices.postJoinPartyByCode(joinPartCode.text.toUpperCase());
  }

  Future<void> buttonGeneratePartyCodeClicked() async {
    if (!isPartyCodeGenerated.value) {
      partyCode.text = await ValorantClientServices.postGeneratePartyCode(partyId.value);
      isPartyCodeGenerated.value = true;
      buttonGenerateCode_Text.value = "DISABLE CODE";
    } else {
      partyCode.text = await ValorantClientServices.postDeletePartyCode(partyId.value);
      isPartyCodeGenerated.value = false;
      buttonGenerateCode_Text.value = "GENERATE CODE";
    }
  }

  void buttonInstalockClicked() {
    if (!isInstalocking) {
      isInstalocking = true;
      ValorantClientServices.postInstalockAgent();
      buttonLockIn_Text.value = "STOP LOCK IN";
    } else if (isInstalocking){
      isInstalocking = false;
      buttonLockIn_Text.value = "LOCK IN";
    }
  }
}
