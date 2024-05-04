import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';
import 'package:mitproxy_val/utils/globals.dart';

class StoreWidget extends StatelessWidget {
  StoreWidget({super.key});
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
            "STORE",
            style: textStyleConstant.TextStyleInterBold(Colors.black38, 14),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorConstant.pageColor2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://media.valorant-api.com/bundles/${Globals.bundleData!.bundleUuid}/displayicon.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Text(
                        '${Globals.bundleData!.bundleName} Bundle',
                        style: textStyleConstant.TextStyleInterBold(
                            Colors.white, 14),
                      ),
                    ),
                    Positioned(
                      left: 33,
                      top: 10,
                      child: Text(
                        '${Globals.bundleData!.bundlePrice}',
                        style: textStyleConstant.TextStyleInterBold(
                            Colors.white, 14),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 12,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://media.valorant-api.com/currencies/85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741/displayicon.png"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Bundle Items",
                          style: textStyleConstant.TextStyleInterBold(
                              Colors.black87, 14),
                        ),
                        const Spacer(),
                        Obx(
                          () => Text(
                            homeController.bundleRemainingTime.value,
                            style: textStyleConstant.TextStyleInterBold(
                                Colors.black87, 14),
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 0.5,
                      height: 1,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    Globals.bundleData!.itemNames.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          width: 180,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Globals.bundleData!.itemTierColor[index],
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
                                        image: NetworkImage(Globals.bundleData!.itemImages[index]),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: Text(
                                  Globals.bundleData!.itemNames[index],
                                  style: textStyleConstant.TextStyleInterBold(
                                      Globals.bundleData!.itemTierColor[index]
                                          .withOpacity(1),
                                      12),
                                ),
                              ),
                              Positioned(
                                left: 30,
                                top: 10,
                                child: Text(
                                  '${Globals.bundleData!.itemPrices[index]}',
                                  style: textStyleConstant.TextStyleInterBold(
                                      Globals.bundleData!.itemTierColor[index]
                                          .withOpacity(1),
                                      12),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://media.valorant-api.com/currencies/85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741/displayicon.png"),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(Globals
                                          .bundleData!.itemTierIcon[index]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // ** Daily Offers **
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Daily Offers",
                          style: textStyleConstant.TextStyleInterBold(
                              Colors.black87, 14),
                        ),
                        const Spacer(),
                        Obx(
                          () => Text(
                            homeController.dailyOffersRemainingTime.value,
                            style: textStyleConstant.TextStyleInterBold(
                                Colors.black87, 14),
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 0.5,
                      height: 1,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    Globals.dailyOffers!.weaponNames.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          width: 180,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Globals.dailyOffers!.weaponRarityColor[index],
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
                                        image: NetworkImage(Globals.dailyOffers!.weaponImages[index]),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: Text(
                                  Globals.dailyOffers!.weaponNames[index],
                                  style: textStyleConstant.TextStyleInterBold(
                                      Globals.dailyOffers!.weaponRarityColor[index]
                                          .withOpacity(1),
                                      12),
                                ),
                              ),
                              Positioned(
                                left: 30,
                                top: 10,
                                child: Text(
                                  '${Globals.dailyOffers!.weaponPrices[index]}',
                                  style: textStyleConstant.TextStyleInterBold(
                                      Globals.dailyOffers!.weaponRarityColor[index]
                                          .withOpacity(1),
                                      12),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://media.valorant-api.com/currencies/85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741/displayicon.png"),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(Globals.dailyOffers!.weaponRarityIcon[index]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
