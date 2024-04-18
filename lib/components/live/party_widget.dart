import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/live_controller.dart';
import 'package:mitproxy_val/utils/cache.dart';
import 'package:mitproxy_val/utils/valorant_services.dart';
import 'package:flutter/services.dart';

class PartyWidget extends StatelessWidget {
  PartyWidget({super.key});

  final textStyleConstant = TextStyleConstant();
  final liveController = Get.put(LiveController());
  final valorantServices = ValorantServices();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Party",
            style: textStyleConstant.TextStyleInterBold(Colors.black38, 14),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstant.pageColor2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstant.pageColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Members",
                          style: textStyleConstant.TextStyleInterBold(
                              Colors.black, 14),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(
                            Cache.partyMembers!.playerNames.length,
                            (index) {
                              return Container(
                                decoration: const BoxDecoration(
                                    //color: Colors.black
                                    ),
                                child: ListTile(
                                  leading: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(Cache
                                                .partyMembers!
                                                .playerCards[index]))),
                                  ),
                                  title: Text(
                                    Cache.partyMembers!.playerNames[index],
                                    style:
                                        textStyleConstant.TextStyleInterNormal(
                                            Colors.black, 14),
                                  ),
                                  subtitle: Text(
                                    'Levels ${Cache.partyMembers!.playerLevels[index]}',
                                    style:
                                        textStyleConstant.TextStyleInterNormal(
                                            Colors.black54, 12),
                                  ),
                                  trailing: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          191, 191, 191, 1),
                                      borderRadius: BorderRadius.circular(180),
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              156, 156, 156, 1)),
                                      image: DecorationImage(
                                        image: NetworkImage(Cache
                                            .partyMembers!.playerRanks[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstant.pageColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Invite By Party Code",
                          style: textStyleConstant.TextStyleInterBold(
                              Colors.black, 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Copy your party's code to invite:",
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black87, 10),
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(38, 49, 58, 1)
                                    .withOpacity(0.7),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                readOnly: true,
                                controller: liveController.partyCode,
                                style: textStyleConstant.TextStyleInterBold(
                                    Colors.white, 14),
                                decoration: InputDecoration(
                                  hintText: '******',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      liveController.copyPartyCodeToClipboard(
                                          context,
                                          liveController.partyCode.text);
                                    },
                                    child: const Icon(Icons.copy,
                                        color: Colors.white54),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width - 150,
                                height: 25,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Generate party code
                                    if (!liveController
                                        .isPartyCodeGenerated.value) {
                                      liveController.partyCode.text =
                                          await valorantServices
                                              .postGeneratePartyCode(
                                                  Cache.partyMembers!.partyId);
                                      liveController
                                          .isPartyCodeGenerated.value = true;
                                      liveController.buttonGenerateCode_Text
                                          .value = "DISABLE CODE";
                                    } else {
                                      liveController.partyCode.text =
                                          await valorantServices
                                              .postDeletePartyCode(
                                                  Cache.partyMembers!.partyId);
                                      liveController
                                          .isPartyCodeGenerated.value = false;
                                      liveController.buttonGenerateCode_Text
                                          .value = "GENERATE CODE";
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3, // Elevation shadow
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          1), // Button border radius
                                    ),
                                  ),
                                  child: Obx(
                                    () => Text(
                                      liveController
                                          .buttonGenerateCode_Text.value,
                                      style: textStyleConstant
                                          .TextStyleInterNormal(
                                              Colors.black, 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Text(
                              "Paste another party's code to join:",
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black87, 10),
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(38, 49, 58, 1)
                                    .withOpacity(0.7),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: liveController.joinPartCode,
                                style: textStyleConstant.TextStyleInterBold(
                                    Colors.white, 14),
                                decoration: const InputDecoration(
                                  hintText: "XXXXXX",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width - 150,
                                height: 25,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Join Party by Code
                                    valorantServices.postJoinPartyByCode(
                                        liveController.joinPartCode.text
                                            .toUpperCase());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3, // Elevation shadow
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          1), // Button border radius
                                    ),
                                  ),
                                  child: Text(
                                    "JOIN PARTY",
                                    style:
                                        textStyleConstant.TextStyleInterNormal(
                                            Colors.black, 14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstant.pageColor,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          "Party Ready",
                          style: textStyleConstant.TextStyleInterNormal(
                              Colors.black, 12),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Obx(
                          () => Transform.scale(
                            scale:
                                0.7, // Adjust the scale factor as needed to change the size
                            child: Switch(
                              value: liveController.isPartyReady.value,
                              onChanged: (value) {
                                liveController.isPartyReady.value = value;
                                valorantServices.postPartyReadyState(
                                    Cache.partyMembers!.partyId, value);
                              },
                              activeColor:
                                  Colors.green, // Color when the switch is ON
                              inactiveTrackColor: Colors
                                  .grey, // Color of the switch track when it's OFF
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstant.pageColor,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          "Open Party",
                          style: textStyleConstant.TextStyleInterNormal(
                              Colors.black, 12),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Obx(
                          () => Transform.scale(
                            scale:
                                0.7, // Adjust the scale factor as needed to change the size
                            child: Switch(
                              value: liveController.isPartyOpen.value,
                              onChanged: (value) {
                                if (!liveController.isPartyOpen.value) {
                                  liveController.isPartyOpen.value = value;
                                  valorantServices.postPartyAccessibility(
                                      Cache.partyMembers!.partyId, "OPEN");
                                } else {
                                  liveController.isPartyOpen.value = value;
                                  valorantServices.postPartyAccessibility(
                                      Cache.partyMembers!.partyId, "CLOSED");
                                }
                              },
                              activeColor:
                                  Colors.green, // Color when the switch is ON
                              inactiveTrackColor: Colors
                                  .grey, // Color of the switch track when it's OFF
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstant.pageColor,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          "Game Mode",
                          style: textStyleConstant.TextStyleInterNormal(
                              Colors.black, 12),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: GestureDetector(
                          onTap: () {
                            showMenu(
                              context: context,
                              position:
                                  const RelativeRect.fromLTRB(100, 100, 0, 0),
                              items: [
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: () {
                                      valorantServices.postSetGameMode(
                                          Cache.partyMembers!.partyId,
                                          "unrated");
                                      liveController.currentGameMode_Text
                                          .value = 'Unrated';
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Unrated'),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: () {
                                      valorantServices.postSetGameMode(
                                          Cache.partyMembers!.partyId,
                                          "competitive");
                                      liveController.currentGameMode_Text
                                          .value = 'Competitive';
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Competitive'),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: () {
                                      valorantServices.postSetGameMode(
                                          Cache.partyMembers!.partyId,
                                          "swiftplay");
                                      liveController.currentGameMode_Text
                                          .value = 'Swiftplay';
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Swiftplay'),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: () {
                                      valorantServices.postSetGameMode(
                                          Cache.partyMembers!.partyId,
                                          "spikerush");
                                      liveController.currentGameMode_Text
                                          .value = 'Spike Rush';
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Spike Rush'),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: () {
                                      valorantServices.postSetGameMode(
                                          Cache.partyMembers!.partyId,
                                          "deathmatch");
                                      liveController.currentGameMode_Text
                                          .value = 'Deathmatch';
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Deathmatch'),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: () {
                                      valorantServices.postSetGameMode(
                                          Cache.partyMembers!.partyId,
                                          "ggteam");
                                      liveController.currentGameMode_Text
                                          .value = 'Escalation';
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Escalation'),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: () {
                                      valorantServices.postSetGameMode(
                                          Cache.partyMembers!.partyId, "hurm");
                                      liveController.currentGameMode_Text
                                          .value = 'Team Deathmatch';
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Team Deathmatch'),
                                  ),
                                ),
                                // PopupMenuItem(
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       valorantServices.postSetGameMode(
                                //           Cache.partyMembers!.partyId,
                                //           "premier");
                                //       liveController.currentGameMode_Text
                                //           .value = 'Premier';
                                //       Navigator.pop(context);
                                //     },
                                //     child: const Text('Premier'),
                                //   ),
                                // ),
                              ],
                            );
                          },
                          child: Obx(
                            () => Text(
                                liveController.currentGameMode_Text.value,
                                style: textStyleConstant.TextStyleInterNormal(
                                    Colors.blue, 12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Obx(
                  () => Text(
                    liveController.isOnMatchmaking.value
                        ? '${liveController.minutes.toString().padLeft(2, '0')}:${liveController.seconds.toString().padLeft(2, '0')}'
                        : "",
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 200,
                  height: 25,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!liveController.isOnMatchmaking.value) {
                        valorantServices
                            .postEntermatchmaking(Cache.partyMembers!.partyId);
                        liveController.buttonMatchmaking_Text.value =
                            "STOP MATCHMAKING";
                        liveController.isOnMatchmaking.value = true;
                        liveController.startMatchmakingTimer();
                      } else {
                        valorantServices
                            .postLeavematchmaking(Cache.partyMembers!.partyId);
                        liveController.buttonMatchmaking_Text.value =
                            "START MATCHMAKING";
                        liveController.isOnMatchmaking.value = false;
                        liveController.stopMatchmakingTimer();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3, // Elevation shadow
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(1), // Button border radius
                      ),
                    ),
                    child: Obx(
                      () => Text(
                        liveController.buttonMatchmaking_Text.value,
                        style: textStyleConstant.TextStyleInterNormal(
                            Colors.black, 12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
