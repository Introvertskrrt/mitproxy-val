// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';
import 'package:mitproxy_val/utils/valorant_asset_services.dart';

class WeaponEquipView extends StatefulWidget {
  const WeaponEquipView({super.key});

  @override
  State<WeaponEquipView> createState() => _WeaponEquipViewState();
}

class _WeaponEquipViewState extends State<WeaponEquipView> {
  final textStyleConstant = TextStyleConstant();
  final homeController = Get.put(HomeController());

  List<String> displayName = [];
  List<String> displayIcon = [];
  List<String> chromaUuid = [];

  Future<void> getWeapon() async{
    homeController.isWeaponEquipViewLoading.value = true;

    String skinId = homeController.skinUuid.value;

    dynamic allWeaponData = await ValorantAssetServices.getAllWeaponsData();
    dynamic data_list = allWeaponData['data'];

    for (var data in data_list) {
      for (var skin in data['skins']) {
        if (skin['uuid'] == skinId) {
          for (var chroma in skin['chromas']) {
            chromaUuid.add(chroma['uuid']);
            displayName.add(chroma['displayName']);
            displayIcon.add(chroma['fullRender']);
          }
        }
      }
    }

    homeController.isWeaponEquipViewLoading.value = false;
    setState(() {
      
    });
  }

  @override
  void initState() {
    getWeapon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Equip Weapon Skins",
          style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
        ),
      ),
      body: Obx(() {
        if (homeController.isWeaponEquipViewLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Center(
                child: Wrap(
                  children: List.generate(displayName.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        homeController.onEquipWeaponSkinClicked(chromaUuid[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                        image: NetworkImage(displayIcon[index]),
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
                                  displayName[index],
                                  style: TextStyle(
                                    color: const Color.fromRGBO(147, 139, 144, 1).withOpacity(1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ] 
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
          );
        }
      }),
    );
  }
}
