// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final loginController = Get.put(LoginController());
  final widgetConstant = TextStyleConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Welcome\nSign-in With Riot Account",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: loginController.username,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person_2_outlined,
                        color: Colors.white), // person icon
                  ),
                ),
              ),
              const SizedBox(height: 10), // jarak antara username dan password
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: loginController.password,
                  obscureText: true,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon:
                          Icon(Icons.lock_outlined, color: Colors.white),
                      suffixIcon: Icon(Icons.remove_red_eye_outlined,
                          color: Colors.white)),
                ),
              ),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: loginController.isRememberMe.value,
                      onChanged: (value) {
                        loginController.isRememberMe.value = value ?? false;
                      },
                      checkColor: Colors.white,
                    ),
                  ),
                  Text(
                    "Remember Me",
                    style:
                        widgetConstant.TextStyleInterNormal(Colors.white, 14),
                  )
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await loginController.loginButtonClicked(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3, // Elevation shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style:
                        widgetConstant.TextStyleInterNormal(Colors.black, 14),
                  ), // Text displayed on the button
                ),
              ),
              RichText(
                text: TextSpan(
                  style: widgetConstant.TextStyleInterNormal(Colors.white, 14),
                  children: [
                    const TextSpan(
                      text:
                          "By continuing, you acknowledge that you have read, and understood and agree to our ",
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      style: const TextStyle(
                          color:
                              Colors.purple), // Purple color for clickable text
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
