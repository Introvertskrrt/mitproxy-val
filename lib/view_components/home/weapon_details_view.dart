import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';

class WeaponDetailsView extends StatelessWidget {
  WeaponDetailsView({super.key});

  final textStyleConstant = TextStyleConstant();
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Weapon Details",
          style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
        ),
      ),
      body: Obx(() {
        if (homeController.isWeaponDetailsPageLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: List.generate(homeController.weaponDetails!.displayName.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Stack(
                        children: [
                          Container(
                            width: 400,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstant.pageColor,
                              image: DecorationImage(image: NetworkImage(homeController.weaponDetails!.displayIcon[index]))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                homeController.weaponDetails!.displayName[index],
                                style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Image.network(
                              homeController.weaponDetails!.swatch[index],
                              width: 50,
                              height: 50,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text("");
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        }
      }
      ),
    );
  }
}