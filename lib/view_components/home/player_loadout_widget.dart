
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';
import 'package:mitproxy_val/utils/routes.dart';

class PlayerLoadoutWidget extends StatelessWidget {
  PlayerLoadoutWidget({super.key});

  final textStyleConstant = TextStyleConstant();
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "WEAPON LOADOUT",
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
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  image: DecorationImage(image: AssetImage("assets/jett_banner.jpeg"),
                  fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    "TO EQUIP YOUR DESIRED WEAPON SKIN, CLICK ON THE WEAPON IN YOUR LOADOUT",
                    style: textStyleConstant.TextStyleInterBold(Colors.white, 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Divider(
                  thickness: 0.5,
                  height: 1,
                  color: Colors.black87,
                ),
              ),
              Center(
                child: Wrap(
                  children: List.generate(homeController.playerLoadout!.guns.length, (index) {
                    dynamic gunIndex = {
                      0: "Odin",
                      1: "Ares",
                      2: "Vandal",
                      3: "Bulldog",
                      4: "Phantom",
                      5: "Judge",
                      6: "Bucky",
                      7: "Frenzy",
                      8: "Classic",
                      9: "Ghost",
                      10: "Sheriff",
                      11: "Shorty",
                      12: "Operator",
                      13: "Guardian",
                      14: "Marshal",
                      15: "Spectre",
                      16: "Stinger",
                      17: "Melee",
                      18: "Outlaw",
                    };
                    final gun = homeController.playerLoadout!.guns[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<String>(
                        future: homeController.loadPlayerGunLoadoutImage(gun.chromaID, gun.skinID),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              width: 180,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(147, 139, 144, 1).withOpacity(0.3),
                              ),
                              child: const Center(child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError || snapshot.data == null) {
                            return Container(
                              width: 180,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(147, 139, 144, 1).withOpacity(0.3),
                              ),
                              child: const Center(child: Icon(Icons.error)),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                homeController.selectedLoadoutGunId.value = gun.id;
                                homeController.selectedWeaponLoadoutIndex.value = index;
                                Get.toNamed(AppRoutes.weapon_list_view);
                              },
                              child: Container(
                                width: 180,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(147, 139, 144, 1).withOpacity(0.3),
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot.data!),
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Text(
                                        gunIndex[index] ?? 'Unknown',
                                        style: TextStyle(
                                          color: const Color.fromRGBO(147, 139, 144, 1).withOpacity(1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}