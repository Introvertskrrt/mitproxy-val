import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(360),
                image: const DecorationImage(image: AssetImage('assets/val_logo_red.png'))
              ),
            ),
            const SizedBox(height: 20), // Optional: Adds spacing between logo and text
            const Text(
              'Mitproxy Valorant',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
