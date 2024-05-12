
import 'package:get/get.dart';
import 'package:mitproxy_val/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {
  Future<void> buttonSignOutClicked() async {
    // clear login cache from device
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("username");
    sharedPreferences.remove("password");

    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> buttonAccountDetailsClicked() async {
    const url = 'https://account.riotgames.com/account';
    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> buttonAccountSecurityClicked() async {
    const url = 'https://account.riotgames.com/#mfa-card';
    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}