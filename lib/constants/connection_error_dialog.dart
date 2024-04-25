import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionErrorDialog {
  void showErrorDialog() {
    Get.defaultDialog(
      title: 'Error',
      middleText: 'Please connect to the internet.',
      barrierDismissible: false, // Set barrierDismissible to false
      actions: [
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}