import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/search_controller.dart';
import 'package:mitproxy_val/utils/cache.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  final searchController = Get.put(SearchPlayerController());
  final textStyleConstant = TextStyleConstant();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstant.pageColor2,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Player's Competitive Stats",
              style: textStyleConstant.TextStyleInterNormal(Colors.black54, 14),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                  controller: searchController.playername,
                  style: textStyleConstant.TextStyleInterBold(
                      Colors.white, 14),
                  decoration: const InputDecoration(
                    hintText: "Playername",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                  controller: searchController.tag,
                  style: textStyleConstant.TextStyleInterBold(
                      Colors.white, 14),
                  decoration: const InputDecoration(
                    hintText: "tag",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 150,
                height: 25,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!searchController.isOnSearching.value) {
                      await searchController.searchButtonClicked();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3, // Elevation shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          1), // Button border radius
                    ),
                  ),
                  child: Text(
                    "SEARCH PLAYER",
                    style:
                        textStyleConstant.TextStyleInterNormal(
                            Colors.black, 14),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Divider(),
            ),
            Obx(() {
              if (searchController.isOnFirstLoad.value) {
                return const Center(
                  child: Text("Player's stats will be displayed here"),
                );
              }
              if (searchController.isOnSearching.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (searchController.isError.value) {
                return const Center(
                  child: Text("Player not found"),
                );
              }
              else {
                return Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: Stack(
                            children: [
                              // Container untuk latar belakang merah
                              Container(
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        Cache.targetPlayerMmr!.playerBanner),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              // Container untuk foto profil
                              Positioned(
                                top: 80,
                                left: (MediaQuery.of(context).size.width - 110) /
                                    2, // Posisi horizontal foto
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              Cache.targetPlayerMmr!.playerCard),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 145,
                                left: (MediaQuery.of(context).size.width - 82) / 2,
                                child: Container(
                                  width: 50,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 216, 212, 212),
                                    border:
                                        Border.all(color: Colors.grey.withOpacity(0.8)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${Cache.targetPlayerMmr!.playerLevel}',
                                      style: textStyleConstant.TextStyleInterNormal(
                                          Colors.black54, 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      Cache.targetPlayerMmr!.playername,
                      style: textStyleConstant.TextStyleInterBold(Colors.black, 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      Cache.playerProfile!.currentCompetitiveSeason,
                      style:
                          textStyleConstant.TextStyleInterNormal(Colors.black54, 12),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(191, 191, 191, 1),
                        borderRadius: BorderRadius.circular(180),
                        border: Border.all(color: const Color.fromRGBO(156, 156, 156, 1)),
                        image: DecorationImage(
                          image: NetworkImage(Cache.targetPlayerMmr!.playerRankImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      Cache.targetPlayerMmr!.playerRank.toUpperCase(),
                      style: textStyleConstant.TextStyleInterBold(Colors.black, 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${Cache.targetPlayerMmr!.playerMmr} MMR',
                                style: textStyleConstant.TextStyleInterNormal(
                                    Colors.black54, 14),
                              ),
                              Text(
                                "${Cache.targetPlayerMmr!.playerRankedRating} RR",
                                style: textStyleConstant.TextStyleInterNormal(
                                    Colors.black54, 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Competitive History",
                          style: textStyleConstant.TextStyleInterNormal(Colors.black54, 14),
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      children: List.generate(Cache.targetPlayerHistory!.matchIds.length, (index) {
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(Cache.targetPlayerHistory!.mapBanner[index]),
                                  fit: BoxFit.fill,
                                ),
                                border: Border.all(
                                  color: Cache.targetPlayerHistory!.rankedRatingEarned[index] >= 0 ? Colors.green : Colors.red,
                                  width: 2, // Adjust the width of the border as needed
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      Cache.targetPlayerHistory!.mapName[index],
                                      style: textStyleConstant.TextStyleInterBold(Colors.white, 16),
                                    ),
                                  ),
                                  Positioned(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(Cache.targetPlayerHistory!.agentPicture[index]),
                                          fit: BoxFit.fill
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 60,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage(Cache.targetPlayerHistory!.rankAfterUpdate[index]))
                                          ),
                                        ),
                                        Text(
                                          (Cache.targetPlayerHistory!.rankedRatingEarned[index] >= 0 ? '+' : '') +
                                            Cache.targetPlayerHistory!.rankedRatingEarned[index].toString(),
                                          style: textStyleConstant.TextStyleInterBold(
                                            Cache.targetPlayerHistory!.rankedRatingEarned[index] >= 0 ? Colors.green : Colors.red,
                                            12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }
            })
          ],
        ),
      ),
    );
  }
}