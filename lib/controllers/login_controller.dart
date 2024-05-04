// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/constants/dialog_constant.dart.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';
import 'dart:convert';

import 'package:mitproxy_val/models/personal_models/account_model.dart';
import 'package:mitproxy_val/utils/globals.dart';
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
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.back();
      dialogConstant.showLoginError(errorLoginMessage!.value);
    }
  }


  Future<bool> fetchLogin() async {
    // http://127.0.0.1:5000/api/v1/riot/authenticate || Local development API

    // THIS API SERVER IS CURRENTLY IP BANNED BY RIOT GAMES 
    // https://api.1ntrovertval.my.id/api/riot/authenticate || Hosted API

    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/v1/riot/authenticate');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username.text,
          'password': password.text,
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

        Globals.temporarySavedAccount = TemporarySavedAccount(
          username: username.text,
          password: password.text,
        );

        // update endpoint
        ValorantEndpoints valorantEndpoints = ValorantEndpoints();
        valorantEndpoints.updateEndpoints();

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
