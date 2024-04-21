import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/live_controller.dart';

class MatchesWidget extends StatelessWidget {
  MatchesWidget({super.key});

  final TextStyleConstant textStyleConstant = TextStyleConstant();
  final liveController = Get.put(LiveController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "MATCHES",
            style: textStyleConstant.TextStyleInterNormal(Colors.black54, 14),
          ),
        ),
        Obx(() {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorConstant.pageColor2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        liveController.mapBanner.value,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Obx(
                          () => Text(
                            liveController.mapName.value,
                            style: textStyleConstant.TextStyleInterBold(
                                Colors.white, 18),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          liveController.gameMode.value,
                          style: textStyleConstant.TextStyleInterNormal(
                              Colors.white, 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // ally/team widget
                Visibility(
                  visible: liveController.allyPlayerNames.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Ally Team",
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black54, 14),
                            ),
                            const Spacer(),
                            Text(
                              liveController.allyTeamId.value,
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black54, 14),
                            ),
                          ],
                        ),
                        Column(
                            children: List.generate(
                                liveController.allyPlayerNames.length, (index) {
                          return ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(180),
                                border: Border.all(
                                    color: liveController.allyTeamColor.value
                                        .withOpacity(0.8)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      liveController.allyAgentImages[index]),
                                ),
                              ),
                            ),
                            title: Text(
                              liveController.allyPlayerNames[index],
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black, 14),
                            ),
                            subtitle: Text(
                              liveController.allySelectionStates[index]
                                  ? 'Locked'
                                  : 'Picking...',
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black54, 12),
                            ),
                            trailing: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(191, 191, 191, 1),
                                borderRadius: BorderRadius.circular(180),
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(156, 156, 156, 1)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      liveController.allyRanks[index]),
                                ),
                              ),
                            ),
                          );
                        })),
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: liveController.enemyPlayerNames.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Enemy Team",
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black54, 14),
                            ),
                            const Spacer(),
                            Text(
                              liveController.enemyTeamId.value,
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black54, 14),
                            ),
                          ],
                        ),
                        Column(
                            children: List.generate(
                                liveController.enemyPlayerNames.length, (index) {
                          return ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(180),
                                border: Border.all(
                                    color: liveController.enemyTeamColor.value
                                        .withOpacity(0.8)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      liveController.enemyAgentImages[index]),
                                ),
                              ),
                            ),
                            title: Text(
                              liveController.enemyPlayerNames[index],
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black, 14),
                            ),
                            subtitle: Text(
                              'Locked',
                              style: textStyleConstant.TextStyleInterNormal(
                                  Colors.black54, 12),
                            ),
                            trailing: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(191, 191, 191, 1),
                                borderRadius: BorderRadius.circular(180),
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(156, 156, 156, 1)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      liveController.enemyRanks[index]),
                                ),
                              ),
                            ),
                          );
                        })),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        }),
      ],
    );
  }
}
