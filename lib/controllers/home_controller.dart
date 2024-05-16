// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/constants/dialog_constant.dart.dart';
import 'package:mitproxy_val/controllers/live_controller.dart';
import 'package:mitproxy_val/controllers/login_controller.dart';
import 'package:mitproxy_val/models/assets_api_models/item_details_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_loadout_model.dart';
import 'package:mitproxy_val/utils/globals.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/home_data_services.dart';
import 'package:mitproxy_val/utils/mitproxy_notification.dart';
import 'package:mitproxy_val/utils/routes.dart';
import 'package:mitproxy_val/utils/valorant_endpoints.dart';
import 'package:video_player/video_player.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class HomeController extends GetxController {
  final homeServices = HomeServices();
  ItemDetails? itemDetails;
  PlayerLoadoutResponse? playerLoadout;
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;
  DialogConstant dialogConstant = DialogConstant();
  
  // variable for equip skins from loadout
  RxString weaponName = "".obs;
  RxString skinUuid = "".obs;
  RxString chromaUuid = "".obs;
  RxString levelUuid = "".obs;
  
  // weapon list view page
  RxString selectedLoadoutGunId = "".obs;
  RxBool isWeaponListViewLoading = false.obs;
  
  // weapon equip view
  RxBool isWeaponEquipViewLoading = false.obs;

  // item details page
  RxBool isItemDetailsPageLoading = false.obs;

  RxInt selectedWeaponLoadoutIndex = 0.obs;

  RxBool isHomePageLoading = false.obs;
  RxString bundleRemainingTime = ''.obs;
  RxString dailyOffersRemainingTime = ''.obs;
  Timer? countdownTimer;

  final loginController = Get.put(LoginController());
  final liveController = Get.put(LiveController());

  Future<void> onItemClicked(String weaponSkinLevelName) async {
    Get.toNamed(AppRoutes.weapon_details);
    isItemDetailsPageLoading(true);
    await homeServices.getItemDetails(weaponSkinLevelName);
    videoController = VideoPlayerController.networkUrl(
      Uri.parse(
        itemDetails?.finisher ?? "",
      ),
    );
    initializeVideoPlayerFuture = videoController.initialize();
    isItemDetailsPageLoading(false);
  }

  Future<void> onWeaponLoadoutClicked(String skinId, int index) async {
    selectedLoadoutGunId.value = skinId;
    selectedWeaponLoadoutIndex.value = index;
    Get.toNamed(AppRoutes.weapon_list_view);
  }

  // in choose weapon skin page (weapon list view)
  Future<void> onWeaponSkinClicked(String skinId, String displayName, String levelId) async {
    skinUuid.value = skinId;
    weaponName.value = displayName;
    levelUuid.value = levelId;

    Get.toNamed(AppRoutes.weapon_equip_view);
  }

  // in weapon equip page (weapon equip view)
  Future<void> onEquipWeaponSkinClicked(String chromaId) async {
    chromaUuid.value = chromaId;

    // get player's loadout json 
    final playerLoadout_api = "${ValorantEndpoints.PD_URL}/personalization/v2/players/${Globals.accountToken!.puuid}/playerloadout";
    final getPlayerLoadout_response = await http.get(Uri.parse(playerLoadout_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (getPlayerLoadout_response.statusCode == 200) {
      var playerLoadout_data = json.decode(getPlayerLoadout_response.body);
      
      // manipulate the response body
      playerLoadout_data['Guns'][selectedWeaponLoadoutIndex.value]['SkinID'] = skinUuid.value;
      playerLoadout_data['Guns'][selectedWeaponLoadoutIndex.value]['SkinLevelID'] = levelUuid.value;
      playerLoadout_data['Guns'][selectedWeaponLoadoutIndex.value]['ChromaID'] = chromaUuid.value;
      

      // send back the response to the riot api server
      var body = json.encode(playerLoadout_data);
      final putPlayerLoadout_response = await http.put(Uri.parse(playerLoadout_api), headers: ValorantEndpoints.RIOT_HEADERS, body: body);
      
      if (putPlayerLoadout_response.statusCode == 200) {
        dialogConstant.showEquipWeaponSuccess();
      }


    } else if (getPlayerLoadout_response.statusCode == 400){
      throw ExceptionTokenExpired("Error: Valorant API return code ${getPlayerLoadout_response.statusCode}");
    } else {
      throw Exception("Error: Unexpected response code ${getPlayerLoadout_response.statusCode}");
    }
  }

  Future<String> loadPlayerGunLoadoutImage(String chromaID, String skinID) async {
    final primaryUrl = "https://media.valorant-api.com/weaponskinchromas/$chromaID/displayicon.png";
    final fallbackUrl = "https://media.valorant-api.com/weaponskins/$skinID/displayicon.png";
    
    try {
      final response = await http.get(Uri.parse(primaryUrl));
      if (response.statusCode == 200) {
        return primaryUrl;
      } else {
        return fallbackUrl;
      }
    } catch (e) {
      return fallbackUrl;
    }
  }

  void startCountdownTimer() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }

    int bundleRemainingSeconds = Globals.bundleData!.bundleRemainingTime;
    int dailyOffersRemainingSeconds = Globals.dailyOffers!.dailyOffersRemainingTime;

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (bundleRemainingSeconds > 0) {
        bundleRemainingSeconds--;
      }
      if (dailyOffersRemainingSeconds > 0) {
        dailyOffersRemainingSeconds--;
      }

      if (bundleRemainingSeconds <= 0 || dailyOffersRemainingSeconds <= 0) {
        countdownTimer!.cancel();
      } else {
        // Update the remaining time in the widget
        updateRemainingTime(bundleRemainingSeconds, dailyOffersRemainingSeconds);
      }
    });
  }

  void updateRemainingTime(int bundleSeconds, int dailySeconds) {
    int bundleDays = (bundleSeconds ~/ 86400);
    int bundleHours = ((bundleSeconds % 86400) ~/ 3600);
    int bundleMinutes = ((bundleSeconds % 3600) ~/ 60);
    int bundleRemainingSeconds = bundleSeconds % 60;

    int dailyDays = (dailySeconds ~/ 86400);
    int dailyHours = ((dailySeconds % 86400) ~/ 3600);
    int dailyMinutes = ((dailySeconds % 3600) ~/ 60);
    int dailyRemainingSeconds = dailySeconds % 60;

    bundleRemainingTime.value =
        '${bundleDays.toString().padLeft(2, '0')}:${bundleHours.toString().padLeft(2, '0')}:${bundleMinutes.toString().padLeft(2, '0')}:${bundleRemainingSeconds.toString().padLeft(2, '0')}';
    dailyOffersRemainingTime.value =
        '${dailyDays.toString().padLeft(2, '0')}:${dailyHours.toString().padLeft(2, '0')}:${dailyMinutes.toString().padLeft(2, '0')}:${dailyRemainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> initPage() async {
    isHomePageLoading(true);
    await homeServices.getUserProfileData();
    await homeServices.getPlayerLoadout();
    await homeServices.getBundleData();
    await homeServices.getDailyStoreData();
    startCountdownTimer();
    isHomePageLoading(false);
  }

  @override
  void onInit() async {
    super.onInit();
    MitproxyNotification.initialize(flutterLocalNotificationsPlugin);
    try {
      await initPage();
      await liveController.initializeAgents();
    } on ExceptionTokenExpired {
      isHomePageLoading(true);
      bool successReauth = await loginController.fetchLogin(Globals.temporarySavedAccount!.username, Globals.temporarySavedAccount!.password);
      if (successReauth) {
        await initPage();
      }
    }on ClientException {
      isHomePageLoading(true);
    }
  }
}
