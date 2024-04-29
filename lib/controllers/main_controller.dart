
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/views/home_view.dart';
import 'package:mitproxy_val/views/live_view.dart';
import 'package:mitproxy_val/views/search_view.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  List<Widget> pages = [HomeView(), LiveView(), SearchView()];
}