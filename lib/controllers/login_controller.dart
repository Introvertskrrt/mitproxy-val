import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/constants/loading_dialog_constant.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';
import 'dart:convert';

import 'package:mitproxy_val/models/account_model.dart';
import 'package:mitproxy_val/utils/cache.dart';

class LoginController extends GetxController {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  RxBool isRememberMe = false.obs;
  RxString? errorLoginMessage;

  Future<bool> fetchLogin() async {
    // http://127.0.0.1:5000/api/riot/authenticate || Local development API
    // https://api.1ntrovertval.my.id/api/riot/authenticate || Hosted API
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

      // Call the callback function in Controller on successful login
      final homeController = Get.put(HomeController());
      homeController.onLoginSuccess();

      return true;
    } else {
      errorLoginMessage = response.body.obs;
      return false;
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Dialog cannot be dismissed by tapping outside
      builder: (BuildContext context) {
        return LoadingDialogConstant();
      },
    );
  }
}
