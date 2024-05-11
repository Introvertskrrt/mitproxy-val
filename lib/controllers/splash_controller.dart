import 'package:get/get.dart';
import 'package:mitproxy_val/controllers/login_controller.dart';
import 'package:mitproxy_val/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final loginController = Get.put(LoginController());

  @override
  void onInit() {
    super.onInit();
    
    Future.delayed(const Duration(seconds: 3), () {
    _checkSavedCredentials();
  });
  }

  Future<void> _checkSavedCredentials() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String username = sharedPreferences.getString("username") ?? "";
    String password = sharedPreferences.getString("password") ?? "";
    bool isFirstTime = sharedPreferences.getBool('firstTime') ?? true;

    // check is the user first time using the app?
    if (isFirstTime) {
      Get.offAllNamed(AppRoutes.intro);
    } else {
      if (username.isNotEmpty && password.isNotEmpty) {
        bool isAuthSuccess = await loginController.fetchLogin(username, password);
        if (isAuthSuccess) {
          Get.offAllNamed(AppRoutes.main);
        } else {
          Get.offAllNamed(AppRoutes.login);
        }
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }
}
