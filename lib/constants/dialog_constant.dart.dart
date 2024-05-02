import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogConstant {
  void showConnectionError() {
    Get.defaultDialog(
      title: 'Error',
      middleText: 'Please connect to the internet.',
      barrierDismissible: false,
      actions: [
        const Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }

  void showLoginError(String errorMsg) {
    Get.defaultDialog(
      title: 'Error',
      middleText: errorMsg,
      barrierDismissible: true,
    );
  }

  void showAuthDialog() {
    Get.defaultDialog(
      title: "Auth",
      middleText: 'Please wait a moment...',
      barrierDismissible: false,
      actions: [
        const Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }

  void showSuccessLogin() {
    Get.defaultDialog(
      title: "Auth",
      middleText: 'Login Success',
      barrierDismissible: true,
    );
  }
}