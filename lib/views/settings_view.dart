import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/settings_controller.dart';
import 'package:mitproxy_val/utils/globals.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final textStyleConstant = TextStyleConstant();
  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.pageColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstant.pageColor2,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://media.valorant-api.com/playercards/${Globals.playerProfile?.playerCardId ?? ""}/smallart.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  title: Text(
                    Globals.playerProfile?.playername ?? "Agent",
                    style: textStyleConstant.TextStyleInterBold(Colors.black.withOpacity(0.9), 18),
                  ),
                  subtitle: Text(
                    "levels ${Globals.playerProfile?.playerLevels ?? 0}",
                    style: textStyleConstant.TextStyleInterBold(Colors.black.withOpacity(0.5), 12),
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(
                          191, 191, 191, 1),
                      borderRadius:
                          BorderRadius.circular(180),
                      border: Border.all(
                          color: const Color.fromRGBO(
                              156, 156, 156, 1)),
                      image: DecorationImage(
                        image: NetworkImage(Globals.playerProfile?.currentRankImage ?? ""),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () async {
                  await settingsController.buttonAccountDetailsClicked();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(0),
                  ),
                ),
                child: const ListTile(
                  title: Text("Account Details"),
                  trailing: Icon(Icons.keyboard_double_arrow_up),
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () async {
                  await settingsController.buttonAccountSecurityClicked();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(0),
                  ),
                ),
                child: const ListTile(
                  title: Text("Account Security"),
                  trailing: Icon(Icons.keyboard_double_arrow_up),
                ),
              ),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        settingsController.buttonSignOutClicked();
                    }, 
                    style: ElevatedButton.styleFrom(
                      elevation: 3, // Elevation shadow
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style:
                          textStyleConstant.TextStyleInterNormal(Colors.black, 14),
                    ),)
                  ),
                ),
              ),
              const SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}