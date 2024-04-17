import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/controllers/main_controller.dart';
import 'package:mitproxy_val/utils/routes.dart';
import 'package:mitproxy_val/views/home_view.dart';
import 'package:mitproxy_val/views/login_view.dart';

Future<void> main() async {
  runApp(
    GetMaterialApp(
      home: LoginView(),
      getPages: [
        GetPage(
          name: AppRoutes.login,
          page: () => LoginView(),
        ),
        GetPage(
          name: AppRoutes.main,
          page: () => MainView(),
        ),
        GetPage(
          name: AppRoutes.home,
          page: () => HomeView(),
        )
      ], 
      initialRoute: AppRoutes.login,
    ),
  );
}

class MainView extends StatelessWidget {
  MainView({super.key});

  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: mainController.pages[mainController.currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            background: const Color.fromARGB(255, 0, 0, 0),
          ),
          unselectedWidgetColor:
              const Color.fromRGBO(147, 147, 147, 1),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorConstant.pageColor, // Set background color to black
          currentIndex: mainController.currentIndex,
          onTap: (int newIndex) {
            mainController.currentIndex = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Live",
              icon: Icon(Icons.play_arrow_rounded),
            ),
            BottomNavigationBarItem(
              label: "Search",
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(Icons.settings),
            ),
          ],
          selectedItemColor: Colors.blue,
        ),
      ),
    );
  }
}