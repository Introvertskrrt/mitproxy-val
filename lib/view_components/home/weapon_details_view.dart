
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';
import 'package:video_player/video_player.dart';

class WeaponDetailsView extends StatefulWidget {
  const WeaponDetailsView({super.key});

  @override
  State<WeaponDetailsView> createState() => _WeaponDetailsViewState();
}

class _WeaponDetailsViewState extends State<WeaponDetailsView> {
  final textStyleConstant = TextStyleConstant();
  final homeController = Get.put(HomeController());

  @override
  void dispose() {
    // Dispose the video controller when the widget is disposed.
    homeController.videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Item Details",
          style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
        ),
      ),
      body: Obx(() {
        if (homeController.isItemDetailsPageLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Obx(() {
                      if (homeController.isWeaponPreviewAvailable.value) {
                        return Column(
                          children: [
                            // video preview
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                width: double.infinity,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  color: ColorConstant.pageColor
                                ),
                                child: Text(
                                  "Preview",
                                  style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorConstant.pageColor
                                ),
                                child: FutureBuilder(
                                  future: homeController.initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      homeController.videoController.setLooping(true);
                                      homeController.videoController.play();
                                      return AspectRatio(
                                        aspectRatio: homeController.videoController.value.aspectRatio,
                                        // Use the VideoPlayer widget to display the video.
                                        child: VideoPlayer(homeController.videoController),
                                      );
                                    } else {
                                      // If the VideoPlayerController is still initializing, show a
                                      // loading spinner.
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                    
                    // item list
                    Column(
                      children: List.generate(homeController.itemDetails!.displayName.length, (index) {
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
                                  image: DecorationImage(image: NetworkImage(homeController.itemDetails!.displayIcon[index]))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    homeController.itemDetails!.displayName[index],
                                    style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: homeController.itemDetails != null &&
                                        homeController.itemDetails!.swatch.isNotEmpty &&
                                        index < homeController.itemDetails!.swatch.length
                                    ? Image.network(
                                        homeController.itemDetails!.swatch[index],
                                        width: 50,
                                        height: 50,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Text("");
                                        },
                                      )
                                    : const Text(""),
                              )]
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
