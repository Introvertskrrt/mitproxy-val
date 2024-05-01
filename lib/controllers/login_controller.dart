// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/constants/dialog_constant.dart.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';
import 'package:mitproxy_val/controllers/live_controller.dart';
import 'dart:convert';

import 'package:mitproxy_val/models/account_model.dart';
import 'package:mitproxy_val/utils/cache.dart';
import 'package:mitproxy_val/utils/routes.dart';
import 'package:mitproxy_val/utils/valorant_endpoints.dart';

class LoginController extends GetxController {
  final dialogConstant = DialogConstant();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  DialogConstant connectionErrorDialog = DialogConstant();

  RxBool isRememberMe = false.obs;
  RxString? errorLoginMessage;

  Future<void> loginButtonClicked(BuildContext context) async {
    dialogConstant.showAuthDialog();

    bool isLoginSuccess = await fetchLogin();

    if (isLoginSuccess) {
      Navigator.of(context).pop();
      Get.toNamed(AppRoutes.main);
    } else {
      Navigator.of(context).pop();
      dialogConstant.showLoginError(errorLoginMessage!.value);
    }
  }

  Future<bool> fetchLogin() async {
    // http://127.0.0.1:5000/api/riot/authenticate || Local development API
    // https://api.1ntrovertval.my.id/api/riot/authenticate || Hosted API

    try {
      final url = Uri.parse('https://api.1ntrovertval.my.id/api/riot/authenticate');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username.text,
          'password': password.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Cache.accountToken = AccountToken(
          authToken: data['Auth-Token'],
          accessTokenType: data['Access-Token-Type'],
          entitlementsToken: data['Entitlements-Token'],
          puuid: data['User-ID'],
          clientVersion: data['Client-Version'],
          shard: data['Shard'],
          clientPlatform: data['Client-Platform'],
          region: data['Region'],
        );

        Cache.temporarySavedAccount = TemporarySavedAccount(
          username: username.text,
          password: password.text,
        );

        // update endpoint
        ValorantEndpoints valorantEndpoints = ValorantEndpoints();
        valorantEndpoints.updateEndpoints();

        // Call the callback function in Controller on successful login
        final homeController = Get.put(HomeController());
        final liveController = Get.put(LiveController());
        homeController.onLoginSuccess();
        liveController.initializeAgents();

        return true;
      } else {
        errorLoginMessage = response.body.obs;
        return false;
      }
    } on http.ClientException {
      errorLoginMessage = "No Internet Connection, make sure you have internet connection!".obs;
      return false;
    }
  }
}
