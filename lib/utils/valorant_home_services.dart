// ignore_for_file: constant_identifier_names, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:mitproxy_val/models/account_model.dart';
import 'package:mitproxy_val/models/store_model.dart';
import 'package:mitproxy_val/utils/cache.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/valorant_endpoints.dart';
import 'dart:developer';

class ValorantHomeServices{

  Future<void> getCompetitiveUpdate() async {
    final competitiveUpdate_api = "${ValorantEndpoints.PD_URL}/mmr/v1/players/87386b82-bc51-5870-a016-1cad906b98cb/competitiveupdates?queue=competitive";
    final competitiveUpdate_response = await http.get(Uri.parse(competitiveUpdate_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (competitiveUpdate_response.statusCode == 200) {
      var data = json.decode(competitiveUpdate_response.body);
      log(data.toString());
    } else if (competitiveUpdate_response.statusCode == 429) {
      log("too many request!");
    }
  }

  Future<void> getUserProfileData() async {
    log(Cache.accountToken!.puuid);
    String playername = '';
    int valorantPoint = 0;
    int radianite = 0;
    int kingdomCredits = 0;
    int playerXp = 0;
    int playerLevels = 0;
    int playerMmr = 0;
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
    final nameService_api = "${ValorantEndpoints.PD_URL}/name-service/v2/players";
    final List<String> nameService_body = [Cache.accountToken!.puuid];
    final nameService_body_json = json.encode(nameService_body);
    final nameService_response = await http.put(Uri.parse(nameService_api), headers: ValorantEndpoints.RIOT_HEADERS, body: nameService_body_json);
    if (nameService_response.statusCode == 200) {
      var nameService_data = json.decode(nameService_response.body);
      playername = nameService_data[0]['GameName'] + " #" + nameService_data[0]['TagLine'];
    } else if (nameService_response.statusCode == 400){
      log('Error at getProfileUserData in name service api: ${nameService_response.body.toString()}');
      throw ExceptionTokenExpired("Error: Valorant API return code ${nameService_response.statusCode}");
    }

    // get player currencies (vp, radianite, kingdom credits)
    final wallet_api = "${ValorantEndpoints.PD_URL}/store/v1/wallet/${Cache.accountToken!.puuid}";
    final wallet_response = await http.get(Uri.parse(wallet_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (wallet_response.statusCode == 200) {
      var wallet_data = json.decode(wallet_response.body);

      valorantPoint = wallet_data['Balances']['85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741'];
      radianite = wallet_data['Balances']['e59aa87c-4cbf-517a-5983-6e81511be9b7'];
      kingdomCredits = wallet_data['Balances']['85ca954a-41f2-ce94-9b45-8ca3dd39a00d'];
    } else if (wallet_response.statusCode == 400){
      log('Error at getProfileUserData in wallet api: ${wallet_response.body.toString()}');
      throw ExceptionTokenExpired("Error: Valorant API return code ${wallet_response.statusCode}");
    }

    // get player xp and levels
    final accountXp_api = "${ValorantEndpoints.PD_URL}/account-xp/v1/players/${Cache.accountToken!.puuid}";
    final accountXp_response = await http.get(Uri.parse(accountXp_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (accountXp_response.statusCode == 200) {
      var accountXp_data = json.decode(accountXp_response.body);

      playerLevels = accountXp_data["Progress"]["Level"];
      playerXp = accountXp_data["Progress"]["XP"];
    } else if (accountXp_response.statusCode == 400){
      log('Error at getProfileUserData in account xp api: ${accountXp_response.body.toString()}');
      throw ExceptionTokenExpired("Error: Valorant API return code ${accountXp_response.statusCode}");
    }

    // get player current rank
    final rank_api = "https://api.henrikdev.xyz/valorant/v1/by-puuid/mmr/${Cache.accountToken!.region}/${Cache.accountToken!.puuid}";
    final rank_response = await http.get(Uri.parse(rank_api));

    var rank_data = json.decode(rank_response.body);
    var rank_tier = rank_data['data']['currenttier'];
    playerMmr = rank_data['data']['ranking_in_tier'];

    await Future.delayed(const Duration(seconds: 5)); // prevent too many request error

    final playerMmr_api = "${ValorantEndpoints.PD_URL}/mmr/v1/players/${Cache.accountToken!.puuid}";
    final playerMmr_response = await http.get(Uri.parse(playerMmr_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (playerMmr_response.statusCode == 200) {
      var playerMmr_data = json.decode(playerMmr_response.body);

      // uuid
      var _currentCompetitiveSeason = playerMmr_data['LatestCompetitiveUpdate']['SeasonID'];

      // temp string
      var currectAct;
      var currentEps;
      var currentRank;
      var rankImage;
      var _rankColor;

      final seasons_api = "https://valorant-api.com/v1/seasons/$_currentCompetitiveSeason";
      final seasons_response = await http.get(Uri.parse(seasons_api));
      if (seasons_response.statusCode == 200) {
        var seasons_data = json.decode(seasons_response.body);
        currectAct = seasons_data['data']['displayName'];
      }

      const fullSeasons_api = "https://valorant-api.com/v1/seasons";
      final fullSeasons_response = await http.get(Uri.parse(fullSeasons_api));
      if (fullSeasons_response.statusCode == 200) {
        var fullSeasons_data = json.decode(fullSeasons_response.body);
        List<dynamic> fullSeasons_list = fullSeasons_data['data'];
        Map<String, dynamic> lastItem = fullSeasons_list.last;

        currentEps = lastItem['displayName'];
      }

      const competitiveTier_api = "https://valorant-api.com/v1/competitivetiers";
      final competitiveTier_response = await http.get(Uri.parse(competitiveTier_api));
      if (competitiveTier_response.statusCode == 200) {
        var competitiveTier_data = json.decode(competitiveTier_response.body);
        List<dynamic> competitiveTier_list = competitiveTier_data['data'];
        var latestCompetitiveTier = competitiveTier_list.last;

        for (var tier in latestCompetitiveTier['tiers']) {
          if (tier['tier'] == rank_tier) {
            currentRank = tier['tierName'];
            rankImage = tier['largeIcon'];
            _rankColor = tier['color'];
            log(rankImage.toString());
          }
        }
      }

      currentCompetitiveSeason = currentEps + ' // ' + currectAct;
      currentCompetitiveRank = currentRank;
      currentRankImage = rankImage;

      String rgbHex = _rankColor.substring(0, 6);
      rankColor = Color(int.parse('0xff$rgbHex'));
    } else if (playerMmr_response.statusCode == 400){
      log("Error: Valorant API playerMmr_response return code ${playerMmr_response.statusCode}");
      throw ExceptionTokenExpired("Error: Valorant API return code ${playerMmr_response.statusCode}");
    }

    // get player card, banner and title id
    final playerLoadout_api = "${ValorantEndpoints.PD_URL}/personalization/v2/players/${Cache.accountToken!.puuid}/playerloadout";
    final playerLoadout_response = await http.get(Uri.parse(playerLoadout_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (playerLoadout_response.statusCode == 200) {
      var playerLoadout_data = json.decode(playerLoadout_response.body);

      playerCardId = playerLoadout_data['Identity']['PlayerCardID']; // can be used for banner
      playerTitleId = playerLoadout_data['Identity']['playerTitleID'] ?? "-";
    } else if (playerLoadout_response.statusCode == 400){
      log("Error: Valorant API playerLoadout_response return code ${playerLoadout_response.statusCode}");
      throw ExceptionTokenExpired("Error: Valorant API return code ${playerLoadout_response.statusCode}");
    }

    // get player mission (daily/weekly)
    final playerContract_api = "${ValorantEndpoints.PD_URL}/contracts/v1/contracts/${Cache.accountToken!.puuid}";
    final playerContract_response = await http.get(Uri.parse(playerContract_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (playerContract_response.statusCode == 200) {
      var playerContract_data = json.decode(playerContract_response.body);

      const mission_api = "https://valorant-api.com/v1/missions";
      final mission_response = await http.get(Uri.parse(mission_api));

      if (mission_response.statusCode == 200) {
        var mission_data = json.decode(mission_response.body);
        var mission_list = mission_data['data'];

        for (var myMission in playerContract_data['Missions']) {
          for (var mission in mission_list) {
            if (mission['uuid'] == myMission['ID']) {
              missionNames.add(mission['title']);
              missionXpRewards.add(mission['xpGrant']);
              missionProgressToComplete.add(mission['progressToComplete']);

              playerContract_data['Missions'].forEach((item) {
                Map<String, dynamic> objectives = item['Objectives'];
                objectives.forEach((key, value) {
                  if (value is int) {
                    missionProgress.add(value);
                  }
                });
              });

              if (mission['type'] == "EAresMissionType::NPE") {
                missionType.add("New Player");
              }
              if (mission['type'] == "EAresMissionType::Daily") {
                missionType.add("Daily");
              }
              if (mission['type'] == "EAresMissionType::Weekly") {
                missionType.add("Weekly");
              }
              if (mission['type'] == "EAresMissionType::Tutorial") {
                missionType.add("Tutorial");
              }
            }
          }
        }
      }
    } else if (playerContract_response.statusCode == 400){
      log("Error: Valorant API playerContract_response return code ${playerContract_response.body}");
      throw ExceptionTokenExpired("Error: Valorant API return code ${playerContract_response.statusCode}");
    }

    Cache.playerProfile = PlayerProfile(
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
      playerMmr: playerMmr,
      playerCardId: playerCardId,
      playerTitleId: playerTitleId,
      currentCompetitiveRank: currentCompetitiveRank,
      currentCompetitiveSeason: currentCompetitiveSeason,
      currentRankImage: currentRankImage,
      rankColor: rankColor,
    );
  }

  Future<void> getBundleData() async {
    String bundleUuid;
    String bundleName;
    int bundlePrice;
    List<int> itemPrices = [];
    List<String> itemImages = [];
    List<String> itemNames = [];
    int bundleRemainingTime;
    List<String> itemTierIcon = [];
    List<Color> itemTierColor = [];

    // using third party API because more easier to process the data
    const storeFront_api = "https://api.henrikdev.xyz/valorant/v2/store-featured";

    final storeFront_response = await http.get(Uri.parse(storeFront_api));
    if (storeFront_response.statusCode == 200) {
      var storeFront_data = json.decode(storeFront_response.body);

      // temp vars
      bundlePrice = storeFront_data['data'][0]['bundle_price'];
      bundleRemainingTime = storeFront_data['data'][0]['seconds_remaining'];

      bundleUuid = storeFront_data['data'][0]['bundle_uuid'];
      var items = storeFront_data['data'][0]['items'];

      for (var item in items) {
        itemPrices.add(item['base_price']);
        itemNames.add(item['name']);
        itemImages.add(item['image']);
      }

      // translate bundle name
      final bundleUuid_api = "https://valorant-api.com/v1/bundles/$bundleUuid";
      final bundleUuid_response = await http.get(Uri.parse(bundleUuid_api));
      if (bundleUuid_response.statusCode == 200) {
        var bundleUuid_data = json.decode(bundleUuid_response.body);
        bundleName = bundleUuid_data['data']['displayName'];
      } else {
        bundleName = "Null";
      }
    } else {
      return;
    }

    // put placeholder to the color list
    for (var x in itemNames) {
      itemTierColor.add(const Color.fromRGBO(147, 139, 144, 1).withOpacity(0.3));
      itemTierIcon.add(
        "https://cdn.discordapp.com/attachments/1127494450030051349/1230077457986752564/image.png?ex=663201e7&is=661f8ce7&hm=c7cc261fa7873fa2e91616330ce940496d641c9879e5a6c664167a94aaa191a0&");
    }

    // get weapon/bundle item rarity
    const weaponSkins_api = "https://valorant-api.com/v1/weapons/skins";
    final weaponSkins_response = await http.get(Uri.parse(weaponSkins_api));
    if (weaponSkins_response.statusCode == 200) {
      var weaponSkins_data = json.decode(weaponSkins_response.body);
      var weaponSkins_list = weaponSkins_data['data'];

      for (var item in itemNames) {
        for (var data in weaponSkins_list) {
          if (data['displayName'] == item) {
            const contentTier_api = "https://valorant-api.com/v1/contenttiers";
            final contentTier_response = await http.get(Uri.parse(contentTier_api));
            if (contentTier_response.statusCode == 200) {
              var contentTier_data = json.decode(contentTier_response.body);

              for (var contentTiers in contentTier_data['data']) {
                if (contentTiers['uuid'] == data['contentTierUuid']) {
                  var replacement_index = itemNames.indexOf(data['displayName']);

                  // item tier icon
                  var _tierIcon = contentTiers['displayIcon'];
                  var replacement_Icon = _tierIcon;
                  itemTierIcon.replaceRange(replacement_index, replacement_index, [replacement_Icon]);

                  // item tier color
                  var _tierColor = contentTiers['highlightColor'];
                  String rgbHex = _tierColor.substring(0, 6);

                  var replacement_color = Color(int.parse('0xff$rgbHex')).withOpacity(0.3);
                  itemTierColor.replaceRange(replacement_index, replacement_index, [replacement_color]);
                }
              }
            }
          }
        }
      }
    }

    Cache.bundleData = Bundle(
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

    final storeFront_api = '${ValorantEndpoints.PD_URL}/store/v2/storefront/${Cache.accountToken!.puuid}';
    final storeFront_response = await http.get(Uri.parse(storeFront_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (storeFront_response.statusCode == 200) {
      var storeFront_data = json.decode(storeFront_response.body);

      dailyOffersRemainingTime = storeFront_data['SkinsPanelLayout']['SingleItemOffersRemainingDurationInSeconds'];

      // loop 4x because daily offers only contain 4 weapons
      for (int i = 0; i < 4; i++) {
        final offerId = storeFront_data['SkinsPanelLayout']['SingleItemOffers'][i];

        final weaponNameApi = "https://valorant-api.com/v1/weapons/skinlevels/$offerId";
        final weaponNameResponse = await http.get(Uri.parse(weaponNameApi));

        if (weaponNameResponse.statusCode == 200) {
          final weaponNameData = json.decode(weaponNameResponse.body);

          weaponNames.add(weaponNameData['data']['displayName']);
          weaponImages.add(weaponNameData['data']['displayIcon']);
        }

        // Weapon Price
        final price = storeFront_data['SkinsPanelLayout']['SingleItemStoreOffers'][i]['Cost']['85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741'];
        weaponPrices.add(price);
      }
    } else if (storeFront_response.statusCode == 400){
      log("Error: Valorant API storeFront_response return code ${storeFront_response.statusCode}");
      throw ExceptionTokenExpired("Error: Valorant API return code ${storeFront_response.statusCode}");
    }
    else{
      
    }

    // get daily offers weapon rarity
    const weaponSkins_api = "https://valorant-api.com/v1/weapons/skins";
    final weaponSkins_response = await http.get(Uri.parse(weaponSkins_api));
    if (weaponSkins_response.statusCode == 200) {
      var weaponSkins_data = json.decode(weaponSkins_response.body);
      var weaponSkins_list = weaponSkins_data['data'];

      for (var item in weaponNames) {
        for (var data in weaponSkins_list) {
          if (data['displayName'] == item) {
            const contentTier_api = "https://valorant-api.com/v1/contenttiers";
            final contentTier_response = await http.get(Uri.parse(contentTier_api));
            if (contentTier_response.statusCode == 200) {
              var contentTier_data = json.decode(contentTier_response.body);

              for (var contentTiers in contentTier_data['data']) {
                if (contentTiers['uuid'] == data['contentTierUuid']) {
                  var replacement_index = weaponNames.indexOf(data['displayName']);

                  // item tier icon
                  var _tierIcon = contentTiers['displayIcon'];
                  weaponRarityIcon.add(_tierIcon);

                  // item tier color
                  var _tierColor = contentTiers['highlightColor'];
                  String rgbHex = _tierColor.substring(0, 6);

                  weaponRarityColor.add(Color(int.parse('0xff$rgbHex')).withOpacity(0.3));
                }
              }
            }
          }
        }
      }
    }

    Cache.dailyOffers = DailyOffers(
      weaponNames: weaponNames,
      weaponPrices: weaponPrices,
      weaponImages: weaponImages,
      weaponRarityIcon: weaponRarityIcon,
      weaponRarityColor: weaponRarityColor,
      dailyOffersRemainingTime: dailyOffersRemainingTime,
    );
  }

}