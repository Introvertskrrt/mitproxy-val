import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mitproxy_val/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionController extends GetxController {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstTime', false);
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginView()),
    );
  }
}
