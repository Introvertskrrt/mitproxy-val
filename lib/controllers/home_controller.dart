import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mitproxy_val/utils/cache.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/valorant_services.dart';

class HomeController extends GetxController {
  final valorantServices = ValorantServices();
  RxBool isPageLoading = false.obs;
  RxString bundleRemainingTime = ''.obs;
  RxString dailyOffersRemainingTime = ''.obs;
  Timer? countdownTimer;

  void startCountdownTimer() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }

    int bundleRemainingSeconds = Cache.bundleData!.bundleRemainingTime;
    int dailyOffersRemainingSeconds =
        Cache.dailyOffers!.dailyOffersRemainingTime;

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
        updateRemainingTime(
            bundleRemainingSeconds, dailyOffersRemainingSeconds);
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

  Future<void> onLoginSuccess() async {
    try {
      isPageLoading(true);
      await valorantServices.getUserProfileData();
      await valorantServices.getBundleData();
      await valorantServices.getDailyStoreData();
      startCountdownTimer();
      isPageLoading(false);
    } on ExceptionValApi {
      // show error dialog and ask the user to re-authenticate
    }
  }
}
