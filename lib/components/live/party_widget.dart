import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/live_controller.dart';
import 'package:mitproxy_val/utils/cache.dart';
import 'package:mitproxy_val/utils/valorant_services.dart';

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
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstant.pageColor,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text("Party Ready"),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          child: Obx(
                            () => Transform.scale(
                              scale:
                                  0.7, // Adjust the scale factor as needed to change the size
                              child: Switch(
                                value: liveController.isPartyReady.value,
                                onChanged: (value) {
                                  liveController.isPartyReady.value = value;
                                  valorantServices.postPartyReadyState(Cache.partyMembers!.partyId, value);
                                },
                                activeColor:
                                    Colors.green, // Color when the switch is ON
                                inactiveTrackColor: Colors
                                    .grey, // Color of the switch track when it's OFF
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
