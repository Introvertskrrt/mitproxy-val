// ignore_for_file: constant_identifier_names, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/controllers/home_controller.dart';
import 'package:mitproxy_val/models/assets_api_models/buddies_model.dart';
import 'package:mitproxy_val/models/assets_api_models/bundle_model.dart';
import 'package:mitproxy_val/models/assets_api_models/competitive_tiers_model.dart';
import 'package:mitproxy_val/models/assets_api_models/content_tiers_model.dart';
import 'package:mitproxy_val/models/assets_api_models/mission_model.dart';
import 'package:mitproxy_val/models/assets_api_models/playercard_model.dart';
import 'package:mitproxy_val/models/assets_api_models/season_model.dart';
import 'package:mitproxy_val/models/assets_api_models/spray_model.dart';
import 'package:mitproxy_val/models/assets_api_models/weapon_details_model.dart';
import 'package:mitproxy_val/models/assets_api_models/weapon_skin_level_model.dart';
import 'package:mitproxy_val/models/assets_api_models/weapon_skin_model.dart';
import 'package:mitproxy_val/models/personal_models/account_model.dart';
import 'package:mitproxy_val/models/client_api_models/account_xp_model.dart';
import 'package:mitproxy_val/models/client_api_models/name_service_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_contract_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_loadout_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_mmr_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_storefront_model.dart';
import 'package:mitproxy_val/models/client_api_models/wallet_model.dart';
import 'package:mitproxy_val/models/personal_models/store_model.dart';
import 'package:mitproxy_val/utils/globals.dart';
import 'package:mitproxy_val/utils/valorant_asset_services.dart';
import 'package:mitproxy_val/utils/valorant_client_services.dart';

class HomeServices {
  Future<void> getUserProfileData() async {
    String playername = '';
    int valorantPoint = 0;
    int radianite = 0;
    int kingdomCredits = 0;
    int playerXp = 0;
    int playerLevels = 0;
    int playerRankedRating = 0;
    String playerCardId = '';
    String playerTitleId = '';
    List<String> missionNames = [];
    List<int> missionXpRewards = [];
    List<int> missionProgress = [];
    List<int> missionProgressToComplete = [];
    List<String> missionType = [];

    String currentCompetitiveRank = '';
    String currentCompetitiveSeason = '';
    String currentRankImage = '';
    Color rankColor = const Color.fromRGBO(255, 255, 255, 1);

    // get playername and tagline
    List<String> puuid = [Globals.accountToken!.puuid];
    List<NameServiceResponse> responses = await ValorantClientServices.nameService(puuid);
    playername = '${responses.first.gameName} #${responses.first.tagLine}';

    // get player currencies (vp, radianite, kingdom credits)
    WalletData walletData = await ValorantClientServices.getWalletData();
    valorantPoint = walletData.valorantPoint;
    kingdomCredits = walletData.kingdomCredits;
    radianite = walletData.radianite;

    // get player xp and levels
    AccountXPResponse accountXPResponse = await ValorantClientServices.getAccountXPData();
    playerLevels = accountXPResponse.playerLevel;
    playerXp = accountXPResponse.playerXP;

    // get player current rank
    PlayerMMRResponse playerMMRResponse = await ValorantClientServices.getPlayerMMRResponse(Globals.accountToken!.puuid);
    var _currentCompetitiveSeason = playerMMRResponse.latestCompetitiveUpdate.seasonID;
    var rank_tier = playerMMRResponse.queueSkills['competitive']?.seasonalInfoBySeasonID[_currentCompetitiveSeason]?.competitiveTier ?? 0;
    playerRankedRating = playerMMRResponse.queueSkills['competitive']?.seasonalInfoBySeasonID[_currentCompetitiveSeason]?.rankedRating ?? 0;

    // temp string
    var currentAct; var currentEps; var currentRank; var rankImage; var _rankColor;

    // get current episode and act
    SeasonsResponse seasonsResponse = await ValorantAssetServices.getSeasonsData();
    currentAct = seasonsResponse.data[seasonsResponse.data.length - 2].displayName;
    currentEps = seasonsResponse.data.last.displayName;

    // get player rank assets
    CompetitiveTiersResponse competitiveTiersResponse = await ValorantAssetServices.getCompetitiveTiersData();
    var competitiveTier_list = competitiveTiersResponse.data.last.tiers;
    for (var tier in competitiveTier_list) {
      if (tier.tier == rank_tier) {
        currentRank = tier.tierName;
        rankImage = tier.largeIcon;
        _rankColor = tier.color;
      }
    }

    currentCompetitiveSeason = currentEps + ' // ' + currentAct;
    currentCompetitiveRank = currentRank;
    currentRankImage = rankImage;

    String rgbHex = _rankColor.substring(0, 6);
    rankColor = Color(int.parse('0xff$rgbHex'));

    // get player card, banner and title id
    PlayerLoadoutResponse playerLoadoutResponse = await ValorantClientServices.getPlayerLoadout();
    playerCardId = playerLoadoutResponse.identity.playerCardID;
    playerTitleId = playerLoadoutResponse.identity.playerTitleID;

    // get player mission (daily/weekly)
    ContractsResponse contractsResponse = await ValorantClientServices.getPlayerMission();
    var _myMission = contractsResponse.missions;

    MissionsResponse missionsResponse = await ValorantAssetServices.getMissionsData();
    var mission_list = missionsResponse.data;

    for (var myMission in _myMission) {
      for (var mission in mission_list) {
        if (mission.uuid == myMission.id) {
          missionNames.add(mission.title ?? "");
          missionXpRewards.add(mission.xpGrant);
          missionProgressToComplete.add(mission.progressToComplete);

          for (var item in _myMission) {
            Map<String, dynamic> objectives = item.objectives;
            objectives.forEach((key, value) {
              if (value is int) {
                missionProgress.add(value);
              }
            });
          }

          if (mission.type == "EAresMissionType::NPE") {
            missionType.add("New Player");
          }
          if (mission.type == "EAresMissionType::Daily") {
            missionType.add("Daily");
          }
          if (mission.type == "EAresMissionType::Weekly") {
            missionType.add("Weekly");
          }
          if (mission.type == "EAresMissionType::Tutorial") {
            missionType.add("Tutorial");
          }
        }
      }
    }

    Globals.playerProfile = PlayerProfile(
      missionNames: missionNames,
      missionXpRewards: missionXpRewards,
      missionProgress: missionProgress,
      missionProgressToComplete: missionProgressToComplete,
      missionType: missionType,
      valorantPoint: valorantPoint,
      playername: playername,
      radianite: radianite,
      kingdomCredits: kingdomCredits,
      playerXp: playerXp,
      playerLevels: playerLevels,
      playerMmr: playerRankedRating,
      playerCardId: playerCardId,
      playerTitleId: playerTitleId,
      currentCompetitiveRank: currentCompetitiveRank,
      currentCompetitiveSeason: currentCompetitiveSeason,
      currentRankImage: currentRankImage,
      rankColor: rankColor,
    );
  }

  Future<void> getBundleData() async {
    String bundleUuid = '';
    String bundleName = '';
    int bundlePrice = 0;
    List<int> itemPrices = [];
    List<String> itemImages = [];
    List<String> itemNames = [];
    int bundleRemainingTime = 0;
    List<String> itemTierIcon = [];
    List<Color> itemTierColor = [];

    // get bundle data
    StorefrontResponse storefrontResponse = await ValorantClientServices.getStoreFront();
    bundlePrice = storefrontResponse.featuredBundle.bundles.first.totalDiscountedCost!.entries.first.value;
    bundleRemainingTime = storefrontResponse.featuredBundle.bundleRemainingDurationInSeconds;

    bundleUuid = storefrontResponse.featuredBundle.bundle.dataAssetID;
    var _bundle = storefrontResponse.featuredBundle.bundles.first;
    List<ItemOffers>? itemOffers = _bundle.itemOffers;

    if (itemOffers != null) {
      for (ItemOffers item in itemOffers) {
        itemPrices.add(item.offer.cost.entries.first.value);

        // get weapon item name and images
        WeaponSkinLevelsResponse weaponSkinLevelsResponse = await ValorantAssetServices.getWeaponSkinlevelsData();
        var weaponSkinLevels_list = weaponSkinLevelsResponse.data;
        
        for (var weaponSkinLevel in weaponSkinLevels_list) {
          if (weaponSkinLevel.uuid == item.bundleItemOfferID) {
            itemNames.add(weaponSkinLevel.displayName);
            itemImages.add(weaponSkinLevel.displayIcon ?? "");
          }
        }

        // get buddies
        BuddiesResponse buddiesResponse = await ValorantAssetServices.getBuddiesData();
        var buddies_list = buddiesResponse.data;

        for (var buddy in buddies_list) {
          if (buddy.levels.first.uuid == item.bundleItemOfferID) {
            itemNames.add(buddy.displayName);
            itemImages.add(buddy.displayIcon);
          }
        }

        // get spray
        SpraysResponse spraysResponse = await ValorantAssetServices.getSpraysData();
        var sprays_list = spraysResponse.data;

        for (var spray in sprays_list) {
          if (spray.uuid == item.bundleItemOfferID) {
            itemNames.add(spray.displayName);
            itemImages.add(spray.displayIcon);
          }
        }

        // get card
        PlayerCardsResponse playerCardsResponse = await ValorantAssetServices.getPlayerCardsData();
        var playerCard_list = playerCardsResponse.data;

        for (var card in playerCard_list) {
          if (card.uuid == item.bundleItemOfferID) {
            itemNames.add(card.displayName);
            itemImages.add(card.displayIcon);
          }
        }
      }
    }

    // translate bundle name
    BundlesResponse bundlesResponse = await ValorantAssetServices.getBundleData();
    var bundle_list = bundlesResponse.data;

    for (var bundle in bundle_list) {
      if (bundle.uuid == bundleUuid) {
        bundleName = bundle.displayName;
      }
    }

    // put placeholder to the color list (IGNORE THIS)
    for (var x in itemNames) {
      itemTierColor.add(const Color.fromRGBO(147, 139, 144, 1).withOpacity(0.3));
      itemTierIcon.add(
        "https://i.imgur.com/HqE4dQc.png");
    }

    // get weapon/bundle item rarity
    WeaponSkinsResponse weaponSkinsResponse = await ValorantAssetServices.getWeaponSkinsData();
    var weaponSkin_list = weaponSkinsResponse.data;

    ContentTiersResponse contentTiersResponse = await ValorantAssetServices.getContentTiersData();
    var contentTier_list = contentTiersResponse.data;

    for (var item in itemNames) {
      for (var weaponSkin in weaponSkin_list) {
        if (weaponSkin.displayName == item) {
          for (var contentTier in contentTier_list) {
            if (contentTier.uuid == weaponSkin.contentTierUuid) {
              var replacement_index = itemNames.indexOf(weaponSkin.displayName);

              // item tier icon
              var _tierIcon = contentTier.displayIcon;
              var replacement_Icon = _tierIcon;
              itemTierIcon.replaceRange(replacement_index, replacement_index, [replacement_Icon]);

              // item tier color
              var _tierColor = contentTier.highlightColor;
              String rgbHex = _tierColor.substring(0, 6);

              var replacement_color = Color(int.parse('0xff$rgbHex')).withOpacity(0.3);
              itemTierColor.replaceRange(replacement_index, replacement_index, [replacement_color]);
            }
          }
        }
      }
    }
                  
            

    Globals.bundleData = MyBundle(
      bundleUuid: bundleUuid,
      bundleName: bundleName,
      bundlePrice: bundlePrice,
      itemPrices: itemPrices,
      itemImages: itemImages,
      itemNames: itemNames,
      bundleRemainingTime: bundleRemainingTime,
      itemTierIcon: itemTierIcon,
      itemTierColor: itemTierColor,
    );
  }

  Future<void> getDailyStoreData() async {
    List<String> weaponNames = [];
    List<int> weaponPrices = [];
    List<String> weaponImages = [];
    List<String> weaponRarityIcon = [];
    List<Color> weaponRarityColor = [];
    int dailyOffersRemainingTime = 0;

    StorefrontResponse storefrontResponse = await ValorantClientServices.getStoreFront();

    dailyOffersRemainingTime = storefrontResponse.skinsPanelLayout.singleItemOffersRemainingDurationInSeconds;

    // loop 4x because daily offers only contain 4 weapons
    for (int i = 0; i < 4; i++) {
      final offerId = storefrontResponse.skinsPanelLayout.singleItemOffers[i];
      
      // get weapon names and images
      WeaponSkinLevelsResponse weaponSkinLevelsResponse = await ValorantAssetServices.getWeaponSkinlevelsData();
      var weaaponSkinlevel_list = weaponSkinLevelsResponse.data;

      for (var weaponSkinLevel in weaaponSkinlevel_list) {
        if (weaponSkinLevel.uuid == offerId) {
          weaponNames.add(weaponSkinLevel.displayName);
          weaponImages.add(weaponSkinLevel.displayIcon ?? "");
        }
      }

      // get weapon Price
      final price = storefrontResponse.skinsPanelLayout.singleItemStoreOffers[i].cost['85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741'];
      weaponPrices.add(price!);
    }

    // get daily offers weapon rarity
    WeaponSkinsResponse weaponSkinsResponse = await ValorantAssetServices.getWeaponSkinsData();
    var weaponSkins_list = weaponSkinsResponse.data;

    ContentTiersResponse contentTiersResponse = await ValorantAssetServices.getContentTiersData();
    var contentTier_list = contentTiersResponse.data;

    for (var weaponName in weaponNames) {
      for (var weaponSkin in weaponSkins_list) {
        if (weaponSkin.displayName == weaponName) {
          
          for (var contentTier in contentTier_list) {
            if (contentTier.uuid == weaponSkin.contentTierUuid) {
              var replacement_index = weaponNames.indexOf(weaponSkin.displayName);

              // item tier icon
              var _tierIcon = contentTier.displayIcon;
              weaponRarityIcon.add(_tierIcon);

              // item tier color
              var _tierColor = contentTier.highlightColor;
              String rgbHex = _tierColor.substring(0, 6);

              weaponRarityColor.add(Color(int.parse('0xff$rgbHex')).withOpacity(0.3));
            }
          }
        }
      }
    }

    Globals.dailyOffers = DailyOffers(
      weaponNames: weaponNames,
      weaponPrices: weaponPrices,
      weaponImages: weaponImages,
      weaponRarityIcon: weaponRarityIcon,
      weaponRarityColor: weaponRarityColor,
      dailyOffersRemainingTime: dailyOffersRemainingTime,
    );
  }

  Future<void> getItemDetails(String weaponSkinName) async{
    List<String> displayName = [];
    List<String> displayIcon = [];
    List<String> swatch = [];

    final WeaponSkinsResponse weaponSkinsResponse = await ValorantAssetServices.getWeaponSkinsData();
    final weaponSkin_list = weaponSkinsResponse.data;

    for (var weaponSkin in weaponSkin_list) {
      if (weaponSkin.displayName.contains(weaponSkinName)) {
        for (var chromas in weaponSkin.chromas) {
          displayName.add(chromas.displayName);
          displayIcon.add(chromas.displayIcon ?? "");
          swatch.add(chromas.swatch ?? "");
        }
      }
    }

    final homeController = Get.put(HomeController());

    homeController.itemDetails = ItemDetails(
      displayName: displayName, 
      displayIcon: displayIcon,
      swatch: swatch,
    );
  }
}