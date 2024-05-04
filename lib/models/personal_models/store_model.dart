import 'package:flutter/material.dart';

class MyBundle {
  String bundleUuid;
  String bundleName;
  int bundlePrice;
  List<int> itemPrices;
  List<String> itemImages;
  List<String> itemNames;
  int bundleRemainingTime;
  List<String> itemTierIcon;
  List<Color> itemTierColor;

  MyBundle({
    required this.bundleUuid,
    required this.bundleName,
    required this.bundlePrice,
    required this.itemPrices,
    required this.itemImages,
    required this.itemNames,
    required this.bundleRemainingTime,
    required this.itemTierIcon,
    required this.itemTierColor,
  });
}

class DailyOffers {
  List<String> weaponNames;
  List<int> weaponPrices;
  List<String> weaponImages;
  List<String> weaponRarityIcon;
  List<Color> weaponRarityColor;
  int dailyOffersRemainingTime;
  
  DailyOffers({
    required this.weaponNames,
    required this.weaponPrices,
    required this.weaponImages,
    required this.weaponRarityIcon,
    required this.weaponRarityColor,
    required this.dailyOffersRemainingTime,
  });
}