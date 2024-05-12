// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/constants/color_constant.dart';
import 'package:mitproxy_val/constants/dialog_constant.dart.dart';
import 'package:mitproxy_val/constants/textstyle_constant.dart';
import 'package:mitproxy_val/controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final loginController = Get.put(LoginController());
  final widgetConstant = TextStyleConstant();
  final dialogConstant = DialogConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.pageColor,
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
                          color: Colors.black),
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
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: loginController.username,
                  style: const TextStyle(
                      color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person_2_outlined,
                        color: Colors.black54), // person icon
                  ),
                ),
              ),
              const SizedBox(height: 10), // jarak antara username dan password
              Obx(() => 
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: loginController.password,
                    obscureText: loginController.isObscurePassword.value, // Toggle password visibility based on this boolean
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.lock_outlined, color: Colors.black54),
                      suffixIcon: IconButton(
                        icon: Icon(loginController.isObscurePassword.value ? Icons.visibility_off : Icons.visibility),
                        color: Colors.black54,
                        onPressed: () {
                          loginController.isObscurePassword.value = !loginController.isObscurePassword.value;
                        },
                      ),
                    ),
                  ),
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
                        widgetConstant.TextStyleInterNormal(Colors.black, 14),
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
                    backgroundColor: Colors.deepPurple,
                    elevation: 3, // Elevation shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style:
                        widgetConstant.TextStyleInterNormal(Colors.white, 14),
                  ), // Text displayed on the button
                ),
              ),
              RichText(
                text: TextSpan(
                  style: widgetConstant.TextStyleInterNormal(Colors.black, 14),
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
                      recognizer: TapGestureRecognizer()..onTap = () {
                        dialogConstant.showEula(context, "End-User License and Agreement", loginController.eula);
                      },
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
