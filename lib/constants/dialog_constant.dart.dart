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

  void showEquipWeaponSuccess() {
    Get.defaultDialog(
      title: "Success",
      middleText: 'Skin equipped successfully through the app. Please restart the game to apply changes.'
    );
  }

  void showEula(BuildContext context, String title, String message) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
  }
}