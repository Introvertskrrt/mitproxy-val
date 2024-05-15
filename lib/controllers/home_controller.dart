// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/controllers/live_controller.dart';
import 'package:mitproxy_val/controllers/login_controller.dart';
import 'package:mitproxy_val/models/assets_api_models/item_details_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_loadout_model.dart';
import 'package:mitproxy_val/utils/globals.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/home_data_services.dart';
import 'package:mitproxy_val/utils/mitproxy_notification.dart';
import 'package:mitproxy_val/utils/routes.dart';
import 'package:video_player/video_player.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class HomeController extends GetxController {
  final homeServices = HomeServices();
  ItemDetails? itemDetails;
  PlayerLoadoutResponse? playerLoadout;
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;
  
  RxBool isItemDetailsPageLoading = false.obs;
  RxBool isHomePageLoading = false.obs;
  RxString bundleRemainingTime = ''.obs;
  RxString dailyOffersRemainingTime = ''.obs;
  Timer? countdownTimer;

  final loginController = Get.put(LoginController());
  final liveController = Get.put(LiveController());

  Future<void> onItemClicked(weaponSkinLevelName) async {
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
