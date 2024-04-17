import 'package:get/get.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/valorant_services.dart';

class LiveController extends GetxController {
  final valorantServices = ValorantServices();
  RxBool isPlayerInGame = false.obs;
  RxBool isPartyReady = true.obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    while (true) {
      try{
        await valorantServices.getPartyData();
        isPlayerInGame.value = true;
        await Future.delayed(const Duration(seconds: 3)); 
      } on ExceptionPlayerNotInGame {
        isPlayerInGame.value = false;
      } on ExceptionValApi {
        // re auth
      }
    }
  }
}
