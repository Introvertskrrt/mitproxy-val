import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/dialog_constant.dart.dart';
import 'package:mitproxy_val/utils/routes.dart';

class NetworkController extends GetxController {
  DialogConstant connectionErrorDialog = DialogConstant();
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    // Check the last item in the list (current connectivity status)
    ConnectivityResult connectivityResult = connectivityResults.last;

    if (connectivityResult == ConnectivityResult.none) {
      Get.deleteAll();
      Get.offNamed(AppRoutes.intro); 
      connectionErrorDialog.showConnectionError();
    } else {
      if (Get.isDialogOpen != null && Get.isDialogOpen!) {
        Get.back(); // Close the error dialog if it's open
      }
    }
  }

}
