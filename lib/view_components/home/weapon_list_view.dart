// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';
import 'package:mitproxy_val/utils/valorant_asset_services.dart';

class WeaponListView extends StatefulWidget {
  const WeaponListView({super.key});

  @override
  State<WeaponListView> createState() => _WeaponListViewState();
}

class _WeaponListViewState extends State<WeaponListView> {
  final textStyleConstant = TextStyleConstant();
  final homeController = Get.put(HomeController());

  List<String> displayName = [];
  List<String> displayIcon = [];
  List<String> skinUuid = [];
  List<String> levelUuid = [];

  Future<void> getWeapon() async{
    homeController.isWeaponListViewLoading.value = true;

    String gunId = homeController.selectedLoadoutGunId.value;

    dynamic allWeaponData = await ValorantAssetServices.getAllWeaponsData();
    dynamic data_list = allWeaponData['data'];

    for (var data in data_list) {
      if (data['uuid'] == gunId) {
        dynamic selectedWeaponSkins = data['skins'];

        for (var skin in selectedWeaponSkins) {
          skinUuid.add(skin['uuid']);
          displayName.add(skin['displayName']);
          displayIcon.add(skin['chromas'].first['fullRender']);
          levelUuid.add(skin['levels'].last['uuid']);
        }
      }
    }

    homeController.isWeaponListViewLoading.value = false;
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
          "Choose Weapon Skins",
          style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
        ),
      ),
      body: Obx(() {
        if (homeController.isWeaponListViewLoading.value) {
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
                        homeController.onWeaponSkinClicked(skinUuid[index], displayName[index], levelUuid[index]);
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
