import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/components/home/profile_widget.dart';
import 'package:mitproxy_val/components/home/store_widget.dart';
import 'package:mitproxy_val/components/skeletons/home_skeleton.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final textStyleConstant = TextStyleConstant();
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.isPageLoading.value) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConstant.pageColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Home",
              style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
            ),
          ),
          body: const SingleChildScrollView(
            child: SafeArea(child: HomeSkeleton()),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: ColorConstant.pageColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Home",
              style: textStyleConstant.TextStyleInterBold(Colors.black, 18),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: homeController.onLoginSuccess,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileWidget(),
                    const SizedBox(height: 20),
                    StoreWidget(),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
