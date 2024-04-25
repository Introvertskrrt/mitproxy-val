import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/connection_error_dialog.dart';
import 'package:mitproxy_val/utils/routes.dart';

class NetworkController extends GetxController {
  ConnectionErrorDialog connectionErrorDialog = ConnectionErrorDialog();
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
      Get.offNamed(AppRoutes.login); 
      connectionErrorDialog.showErrorDialog();
    } else {
      if (Get.isDialogOpen != null && Get.isDialogOpen!) {
        Get.back(); // Close the error dialog if it's open
      }
    }
  }

}
