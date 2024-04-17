
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/views/home_view.dart';

class MainController extends GetxController {
  int currentIndex = 0;
  List<Widget> pages = [HomeView()];
}