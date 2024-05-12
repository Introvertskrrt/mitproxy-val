// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/constants/dialog_constant.dart.dart';
import 'dart:convert';

import 'package:mitproxy_val/models/personal_models/account_model.dart';
import 'package:mitproxy_val/utils/globals.dart';
import 'package:mitproxy_val/utils/routes.dart';
import 'package:mitproxy_val/utils/valorant_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final dialogConstant = DialogConstant();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  DialogConstant connectionErrorDialog = DialogConstant();

  RxBool isRememberMe = false.obs;
  RxString errorLoginMessage = ''.obs;

  final eula = """
  1. We are not saving your credentials or sensitive information, your account will be stored locally in your phone.\n
  2. We are not responsible if your account gets banned.\n
  3. Do not abuse instalock agent feature, Riot doesn't like this, you may get banned or API restricted for the rest of us\n
  """;

  Future<void> loginButtonClicked(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dialogConstant.showAuthDialog();

    bool isLoginSuccess = await fetchLogin(username.text, password.text);

    if (isLoginSuccess) {
      String correct_username = username.text;
      String correct_password = password.text;

      // if user checked remember me
      if (isRememberMe.value) {
        // add username and password to shared prefs
        prefs.setString('username', correct_username);
        prefs.setString('password', correct_password);
      }

      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.back();
      dialogConstant.showLoginError(errorLoginMessage.value);
    }
  }


  Future<bool> fetchLogin(String username, String password) async {
    // http://127.0.0.1:5000/api/v1/riot/authenticate || Local development API

    // THIS API SERVER IS CURRENTLY IP BANNED BY RIOT GAMES 
    // https://api.1ntrovertval.my.id/api/riot/authenticate || Hosted API

    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/v1/riot/authenticate');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final token_data = json.decode(response.body);
        
        // get region
        const geo_api = "https://riot-geo.pas.si.riotgames.com/pas/v1/product/valorant";
        final geo_headers = {
          "Authorization": "Bearer ${token_data['Auth-Token']}",
        };
        final geo_body = {
          "id_token": token_data['ID-Token']
        };

        String region = "";
        String shard = "";
        final geo_response = await http.put(Uri.parse(geo_api), headers: geo_headers, body: json.encode(geo_body));
        if (geo_response.statusCode == 200) {
          var geo_data = json.decode(geo_response.body);
          region = geo_data['affinities']['live'];
          if (region == "latam" || region == "na" || region == "br") {
              shard = "na";
          }
          if (region == "eu") {
              shard = "eu";
          }
          if (region == "ap") {
              shard = "ap";
          }
          if (region == "kr") {
              shard = "kr";
          }
        }

        // get client version
        String clientVersion;
        var apiURL = Uri.parse("https://valorant-api.com/v1/version");
        var clientVersionResponse = await http.get(apiURL);
        if (clientVersionResponse.statusCode == 200) {
          var responseData = jsonDecode(clientVersionResponse.body);
          clientVersion = responseData["data"]["riotClientVersion"];
        } else {
          clientVersion = "";
        }

        const clientPlatform = "ew0KCSJwbGF0Zm9ybVR5cGUiOiAiUEMiLA0KCSJwbGF0Zm9ybU9TIjogIldpbmRvd3MiLA0KCSJwbGF0Zm9ybU9TVmVyc2lvbiI6ICIxMC4wLjE5MDQyLjEuMjU2LjY0Yml0IiwNCgkicGxhdGZvcm1DaGlwc2V0IjogIlVua25vd24iDQp9";

        Globals.accountToken = AccountToken(
          authToken: token_data['Auth-Token'],
          accessTokenType: token_data['Access-Token-Type'],
          entitlementsToken: token_data['Entitlements-Token'],
          puuid: token_data['User-ID'],
          clientVersion: clientVersion,
          shard: shard,
          clientPlatform: clientPlatform,
          region: region,
        );

        // add username and password to temporary model
        Globals.temporarySavedAccount = TemporarySavedAccount(
          username: username, 
          password: password,
        );

        // update endpoint
        ValorantEndpoints valorantEndpoints = ValorantEndpoints();
        valorantEndpoints.updateEndpoints();

        return true;
      } else {
        var _response = json.decode(response.body);
        errorLoginMessage.value = _response['error'];
        return false;
      }
    } on http.ClientException {
      errorLoginMessage = "No Internet Connection, make sure you have internet connection!".obs;
      return false;
    }
  }
}
