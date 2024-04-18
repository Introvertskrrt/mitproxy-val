import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/components/live/matches_widget.dart';
import 'package:mitproxy_val/components/live/party_widget.dart';
import 'package:mitproxy_val/components/live/waiting_page.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/live_controller.dart';

class LiveView extends StatelessWidget {
  LiveView({super.key});

  final liveController = Get.put(LiveController());
  final textStyleConstant = TextStyleConstant();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!liveController.isPlayerInGame.value) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Live",
              style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
            ),
          ),
          body: SafeArea(child: WaitingPage()),
        );
      } else {
        return Scaffold(
          backgroundColor: ColorConstant.pageColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Live",
              style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PartyWidget(),
                  const SizedBox(height: 20),
                  MatchesWidget(),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}