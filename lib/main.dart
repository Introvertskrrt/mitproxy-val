import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/controllers/main_controller.dart';
import 'package:mitproxy_val/utils/dependency_injection.dart';
import 'package:mitproxy_val/utils/routes.dart';
import 'package:mitproxy_val/view_components/home/weapon_details_view.dart';
import 'package:mitproxy_val/views/chatbot_view.dart';
import 'package:mitproxy_val/views/home_view.dart';
import 'package:mitproxy_val/views/intro_view.dart';
import 'package:mitproxy_val/views/live_view.dart';
import 'package:mitproxy_val/views/login_view.dart';
import 'package:mitproxy_val/views/search_view.dart';
import 'package:mitproxy_val/views/settings_view.dart';
import 'package:mitproxy_val/views/splash_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(
    GetMaterialApp(
      home: SplashScreen(),
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
        ),
        GetPage(
          name: AppRoutes.live,
          page: () => LiveView(),
        ),
        GetPage(
          name: AppRoutes.search,
          page: () => SearchView(),
        ),
        GetPage(
          name: AppRoutes.splash,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: AppRoutes.chatbot,
          page: () => ChatBotView(),
        ),
        GetPage(
          name: AppRoutes.intro,
          page: () => IntroductionView(),
        ),
        GetPage(
          name: AppRoutes.settings,
          page: () => SettingsView(),
        ),
        GetPage(
          name: AppRoutes.weapon_details,
          page: () => const WeaponDetailsView(),
        ),
      ],
      initialRoute: AppRoutes.splash,
    ),
  );
  DependencyInjection.init();
}

class MainView extends StatelessWidget {
  MainView({super.key});

  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: mainController.pages[mainController.currentIndex.value],
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),),
      bottomNavigationBar: Obx(
        () => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  background: const Color.fromARGB(255, 0, 0, 0),
                ),
            unselectedWidgetColor: const Color.fromRGBO(147, 147, 147, 1),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor:
                ColorConstant.pageColor, // Set background color to black
            currentIndex: mainController.currentIndex.value,
            onTap: (int newIndex) {
              mainController.currentIndex.value = newIndex;
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
                label: "Chat Bot",
                icon: Icon(Icons.message),
              ),
              BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(Icons.settings),
              ),
            ],
            selectedItemColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
