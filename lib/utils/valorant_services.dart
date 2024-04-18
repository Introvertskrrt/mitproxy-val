// ignore_for_file: non_constant_identifier_names, unused_local_variable, constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'package:flutter/widgets.dart';
import 'package:mitproxy_val/models/account_model.dart';
import 'package:mitproxy_val/models/match_model.dart';
import 'package:mitproxy_val/models/party_model.dart';
import 'package:mitproxy_val/models/store_model.dart';
import 'package:mitproxy_val/utils/cache.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/utils/exceptions.dart';

class ValorantServices {
  static String GLZ_URL = "https://glz-${Cache.accountToken!.region}-1.${Cache.accountToken!.shard}.a.pvp.net";
  static String PD_URL = "https://pd.${Cache.accountToken!.shard}.a.pvp.net";
  static dynamic RIOT_HEADERS = {
    'X-Riot-ClientPlatform': Cache.accountToken!.clientPlatform,
    'X-Riot-ClientVersion': Cache.accountToken!.clientVersion,
    'X-Riot-Entitlements-JWT': Cache.accountToken!.entitlementsToken,
    'Authorization': 'Bearer ${Cache.accountToken!.authToken}'
  };

  // used for home page
  Future<void> getUserProfileData() async {
    final String playername;
    final int valorantPoint;
    final int radianite;
    final int kingdomCredits;
    final int playerXp;
    final int playerLevels;
    final int playerMmr;
    final String playerCardId;
    final String playerTitleId;
    final List<String> missionNames = [];
    final List<int> missionXpRewards = [];
    final List<int> missionProgress = [];
    final List<int> missionProgressToComplete = [];
    final List<String> missionType = [];

    final String currentCompetitiveRank;
    final String currentCompetitiveSeason;
    final String currentRankImage;
    final Color rankColor;

    // get playername and tagline
    final nameService_api = "$PD_URL/name-service/v2/players";
    final nameService_headers = RIOT_HEADERS;
    final List<String> nameService_body = [Cache.accountToken!.puuid];
    final nameService_body_json = json.encode(nameService_body);
    final nameService_response = await http.put(Uri.parse(nameService_api),
        headers: nameService_headers, body: nameService_body_json);
    if (nameService_response.statusCode == 200) {
      var nameService_data = json.decode(nameService_response.body);
      playername = nameService_data[0]['GameName'] +
          " #" +
          nameService_data[0]['TagLine'];
    } else {
      throw ExceptionValApi(
          "Error: Valorant API return code ${nameService_response.statusCode}");
    }

    // get player currencies (vp, radianite, kingdom credits)
    final wallet_api =
        "$PD_URL/store/v1/wallet/${Cache.accountToken!.puuid}";
    final wallet_headers = RIOT_HEADERS;
    final wallet_response =
        await http.get(Uri.parse(wallet_api), headers: wallet_headers);
    if (wallet_response.statusCode == 200) {
      var wallet_data = json.decode(wallet_response.body);

      valorantPoint =
          wallet_data['Balances']['85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741'];
      radianite =
          wallet_data['Balances']['e59aa87c-4cbf-517a-5983-6e81511be9b7'];
      kingdomCredits =
          wallet_data['Balances']['85ca954a-41f2-ce94-9b45-8ca3dd39a00d'];
    } else {
      throw ExceptionValApi(
          "Error: Valorant API return code ${wallet_response.statusCode}");
    }

    // get player xp and levels
    final accountXp_api =
        "$PD_URL/account-xp/v1/players/${Cache.accountToken!.puuid}";
    final accountXp_headers = RIOT_HEADERS;
    final accountXp_response =
        await http.get(Uri.parse(accountXp_api), headers: accountXp_headers);
    if (accountXp_response.statusCode == 200) {
      var accountXp_data = json.decode(accountXp_response.body);

      playerLevels = accountXp_data["Progress"]["Level"];
      playerXp = accountXp_data["Progress"]["XP"];
    } else {
      throw ExceptionValApi(
          "Error: Valorant API return code ${accountXp_response.statusCode}");
    }

    // get player mmr
    final playerMmr_api =
        "$PD_URL/mmr/v1/players/${Cache.accountToken!.puuid}";
    final playerMmr_headers = RIOT_HEADERS;
    final playerMmr_response =
        await http.get(Uri.parse(playerMmr_api), headers: playerMmr_headers);
    if (playerMmr_response.statusCode == 200) {
      var playerMmr_data = json.decode(playerMmr_response.body);

      playerMmr =
          playerMmr_data['LatestCompetitiveUpdate']['RankedRatingAfterUpdate'];

      // uuid
      var _currentCompetitiveRank =
          playerMmr_data['LatestCompetitiveUpdate']['TierAfterUpdate'];
      var _currentCompetitiveSeason =
          playerMmr_data['LatestCompetitiveUpdate']['SeasonID'];

      // temp string
      var currectAct;
      var currentEps;
      var currentRank;
      var rankImage;
      var _rankColor;

      final seasons_api =
          "https://valorant-api.com/v1/seasons/$_currentCompetitiveSeason";
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

      const competitiveTier_api =
          "https://valorant-api.com/v1/competitivetiers";
      final competitiveTier_response =
          await http.get(Uri.parse(competitiveTier_api));
      if (competitiveTier_response.statusCode == 200) {
        var competitiveTier_data = json.decode(competitiveTier_response.body);
        List<dynamic> competitiveTier_list = competitiveTier_data['data'];
        var latestCompetitiveTier = competitiveTier_list.last;

        for (var tier in latestCompetitiveTier['tiers']) {
          if (tier['tier'] == _currentCompetitiveRank) {
            currentRank = tier['tierName'];
            rankImage = tier['largeIcon'];
            _rankColor = tier['color'];
          }
        }
      }

      currentCompetitiveSeason = currentEps + ' // ' + currectAct;
      currentCompetitiveRank = currentRank;
      currentRankImage = rankImage;

      String rgbHex = _rankColor.substring(0, 6);
      rankColor = Color(int.parse('0xff$rgbHex'));
    } else {
      throw ExceptionValApi(
          "Error: Valorant API return code ${playerMmr_response.statusCode}");
    }

    // get player card, banner and title id
    final playerLoadout_api =
        "$PD_URL/personalization/v2/players/${Cache.accountToken!.puuid}/playerloadout";
    final playerLoadout_haders = RIOT_HEADERS;
    final playerLoadout_response = await http.get(Uri.parse(playerLoadout_api),
        headers: playerLoadout_haders);
    if (playerLoadout_response.statusCode == 200) {
      var playerLoadout_data = json.decode(playerLoadout_response.body);

      playerCardId = playerLoadout_data['Identity']
          ['PlayerCardID']; // can be used for banner
      playerTitleId = playerLoadout_data['Identity']['playerTitleID'] ?? "-";
    } else {
      throw ExceptionValApi(
          "Error: Valorant API return code ${playerLoadout_response.statusCode}");
    }

    // get player mission (daily/weekly)
    final playerContract_api =
        "$PD_URL/contracts/v1/contracts/${Cache.accountToken!.puuid}";
    final playerContract_headers = RIOT_HEADERS;
    final playerContract_response = await http
        .get(Uri.parse(playerContract_api), headers: playerContract_headers);
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
    } else {
      throw ExceptionValApi(
          "Error: Valorant API return code ${playerContract_response.statusCode}");
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
    const storeFront_api =
        "https://api.henrikdev.xyz/valorant/v2/store-featured";

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
      throw ExceptionValApi(
          "Error: Valorant API return code ${storeFront_response.statusCode}");
    }

    // put placeholder to the color list
    for (var x in itemNames) {
      itemTierColor
          .add(const Color.fromRGBO(147, 139, 144, 1).withOpacity(0.3));
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
            final contentTier_response =
                await http.get(Uri.parse(contentTier_api));
            if (contentTier_response.statusCode == 200) {
              var contentTier_data = json.decode(contentTier_response.body);

              for (var contentTiers in contentTier_data['data']) {
                if (contentTiers['uuid'] == data['contentTierUuid']) {
                  var replacement_index =
                      itemNames.indexOf(data['displayName']);

                  // item tier icon
                  var _tierIcon = contentTiers['displayIcon'];
                  var replacement_Icon = _tierIcon;
                  itemTierIcon.replaceRange(
                      replacement_index, replacement_index, [replacement_Icon]);

                  // item tier color
                  var _tierColor = contentTiers['highlightColor'];
                  String rgbHex = _tierColor.substring(0, 6);

                  var replacement_color =
                      Color(int.parse('0xff$rgbHex')).withOpacity(0.3);
                  itemTierColor.replaceRange(replacement_index,
                      replacement_index, [replacement_color]);
                }
              }
            }
          }
        }
      }
    } else {
      throw ExceptionValApi(
        "Error: Valorant API return code ${weaponSkins_response.statusCode}");
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
    int dailyOffersRemainingTime;

    final storeFront_api = '$PD_URL/store/v2/storefront/${Cache.accountToken!.puuid}';
    final storeFront_headers = RIOT_HEADERS;
    final storeFront_response = await http.get(Uri.parse(storeFront_api), headers: storeFront_headers);
    if (storeFront_response.statusCode == 200) {
      var storeFront_data = json.decode(storeFront_response.body);

      dailyOffersRemainingTime = storeFront_data['SkinsPanelLayout']['SingleItemOffersRemainingDurationInSeconds'];

      // loop 4x because daily offers only contain 4 weapons
      for (int i = 0; i < 4; i++) {
        final offerId = storeFront_data['SkinsPanelLayout']['SingleItemOffers'][i];

        final weaponNameApi =
            "https://valorant-api.com/v1/weapons/skinlevels/$offerId";
        final weaponNameResponse = await http.get(Uri.parse(weaponNameApi));

        if (weaponNameResponse.statusCode == 200) {
          final weaponNameData = json.decode(weaponNameResponse.body);

          weaponNames.add(weaponNameData['data']['displayName']);
          weaponImages.add(weaponNameData['data']['displayIcon']);
        }

        // Weapon Price
        final price = storeFront_data['SkinsPanelLayout']['SingleItemStoreOffers'][i]
            ['Cost']['85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741'];
        weaponPrices.add(price);
      }
    }
    else {
      throw ExceptionValApi(
        "Error: Valorant API return code ${storeFront_response.statusCode}");
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
            final contentTier_response =
                await http.get(Uri.parse(contentTier_api));
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
    else {
      throw ExceptionValApi(
        "Error: Valorant API return code ${storeFront_response.statusCode}");
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

  // used for live page
  Future<void> getPartyData() async {
    final String partyId;
    final List<String> playerNames = [];
    final List<String> playerCards = [];
    final List<int> playerLevels = [];
    final List<String> playerRanks = [];

    final partyPlayer_api = "$GLZ_URL/parties/v1/players/${Cache.accountToken!.puuid}";
    final partyPlayer_headers = RIOT_HEADERS;
    final partyPlayer_response = await http.get(Uri.parse(partyPlayer_api), headers: partyPlayer_headers);
    if (partyPlayer_response.statusCode == 200) {
      var partyPlayer_data = json.decode(partyPlayer_response.body);
      partyId = partyPlayer_data['CurrentPartyID'];
    }
    else{
      throw ExceptionPlayerNotInGame("Error getting party ID: ${partyPlayer_response.statusCode}");
    }

    final party_api = "$GLZ_URL/parties/v1/parties/$partyId";
    final party_headers = RIOT_HEADERS;
    final party_response = await http.get(Uri.parse(party_api), headers: party_headers);
    if (party_response.statusCode == 200) {
      var party_data = json.decode(party_response.body);
      var party_member_list = party_data['Members'];
      
      var playerUuids = [];
      for (var member in party_member_list) {
        playerUuids.add(member['Subject']);
        playerCards.add("https://media.valorant-api.com/playercards/${member['PlayerIdentity']['PlayerCardID']}/displayicon.png");
        playerLevels.add(member['PlayerIdentity']['AccountLevel']);
      }

      // translate uuid to name
      final nameService_api = "$PD_URL/name-service/v2/players";
      final nameService_headers = RIOT_HEADERS;
      final nameService_body = json.encode(playerUuids);
      final nameService_response = await http.put(Uri.parse(nameService_api), headers: nameService_headers, body: nameService_body);
      if (nameService_response.statusCode == 200) {
        var nameService_data = json.decode(nameService_response.body);
        for (var pName in nameService_data) {
          playerNames.add('${pName['GameName']} #${pName['TagLine']}');
        }
      }
      else{
        throw ExceptionValApi("Error while getting player names: ${nameService_response.statusCode}");
      }

      // get each player's rank
      for (var puuid in playerUuids) {
        final playerMmr_api = "$PD_URL/mmr/v1/players/$puuid";
        final playerMmr_headers = RIOT_HEADERS;
        final playerMmr_response = await http.get(Uri.parse(playerMmr_api), headers: playerMmr_headers);
        if (playerMmr_response.statusCode == 200) {
          var playerMmr_data = json.decode(playerMmr_response.body);
          // uuid
          var _currentCompetitiveRank = playerMmr_data['LatestCompetitiveUpdate']['TierAfterUpdate'];

          // temp string
          var rankImage;

          const competitiveTier_api =
              "https://valorant-api.com/v1/competitivetiers";
          final competitiveTier_response =
              await http.get(Uri.parse(competitiveTier_api));
          if (competitiveTier_response.statusCode == 200) {
            var competitiveTier_data = json.decode(competitiveTier_response.body);
            List<dynamic> competitiveTier_list = competitiveTier_data['data'];
            var latestCompetitiveTier = competitiveTier_list.last;

            for (var tier in latestCompetitiveTier['tiers']) {
              if (tier['tier'] == _currentCompetitiveRank) {
                rankImage = tier['largeIcon'];
                playerRanks.add(rankImage);
              }
            }
          }
        } else {
          throw ExceptionValApi(
            "Error: Valorant API return code ${playerMmr_response.statusCode}");
        }
      }
    }
    Cache.partyMembers = PartyMembers(
      partyId: partyId,
      playerNames: playerNames, 
      playerCards: playerCards, 
      playerLevels: playerLevels, 
      playerRanks: playerRanks,
    );
  }

  Future<void> postPartyReadyState(String partyId, bool readyState) async {
    final partySetReady_api = "$GLZ_URL/parties/v1/parties/$partyId/members/${Cache.accountToken!.puuid}/setReady";
    final partySetReady_headers = RIOT_HEADERS;
    final partySetReady_body = {
      "ready": readyState
    };

    final body = json.encode(partySetReady_body);

    final partySetReady_response = await http.post(Uri.parse(partySetReady_api), headers: partySetReady_headers, body: body);
    if (partySetReady_response.statusCode == 200) {
      return;
    }
    else{
      throw ExceptionValApi("Error set party ready state: ${partySetReady_response.statusCode}");
    }
  }

  Future<String> postGeneratePartyCode(String partyId) async {
    final generatePartyCode_api = "$GLZ_URL/parties/v1/parties/$partyId/invitecode";
    final generatePartyCode_headers = RIOT_HEADERS;
    final genereatePartyCode_response = await http.post(Uri.parse(generatePartyCode_api), headers: generatePartyCode_headers);
    
    if (genereatePartyCode_response.statusCode == 200) {
      var response_data = json.decode(genereatePartyCode_response.body);
      var partyCode = response_data['InviteCode'];
      return partyCode;
    }
    else{
      print(genereatePartyCode_response.statusCode);
      return "error";
    }
  }

  Future<String> postDeletePartyCode(String partyId) async {
    final deletePartyCode_api = "$GLZ_URL/parties/v1/parties/$partyId/invitecode";
    final deletePartyCode_headers = RIOT_HEADERS;
    final deletePartyCode_response = await http.delete(Uri.parse(deletePartyCode_api), headers: deletePartyCode_headers);

    if (deletePartyCode_response.statusCode == 200) {
      return "******";
    }
    else{
      return "******";
    }
  }

  Future<void> postJoinPartyByCode(String partyCode) async {
    final joinParty_api = "$GLZ_URL/parties/v1/players/joinbycode/$partyCode";
    final joinParty_headers = RIOT_HEADERS;
    final joinParty_response = await http.get(Uri.parse(joinParty_api), headers: joinParty_headers);

    if (joinParty_response.statusCode == 200) {
      return;
    }
  }

  Future<void> postPartyAccessibility(String partyId, String partyStatus) async {
    final partyAccessibility_api = "$GLZ_URL/parties/v1/parties/$partyId/accessibility";
    final partyAccessibility_headers = RIOT_HEADERS;
    final partyAccessibility_body = {
      "accessibility": partyStatus 
    };
    final body = json.encode(partyAccessibility_body);

    final partyAccessibility_response = await http.post(Uri.parse(partyAccessibility_api), headers: partyAccessibility_headers, body: body);

    if (partyAccessibility_response.statusCode == 200) {
      return;
    }
  }

  Future<void> postSetGameMode(String partyId, String gameMode) async{
    final setGameMode_api = "$GLZ_URL/parties/v1/parties/$partyId/queue";
    final setGameMode_headers = RIOT_HEADERS;
    final setGameMode_body = {
      'queueId': gameMode
    };
    final body = json.encode(setGameMode_body);

    final setGameMode_response = await http.post(Uri.parse(setGameMode_api), headers: setGameMode_headers, body: body);

    if (setGameMode_response.statusCode == 200) {
      return;
    }
  }

  Future<void> postEntermatchmaking(String partyId) async {
    final joinMatchmaking_api = "$GLZ_URL/parties/v1/parties/$partyId/matchmaking/join";
    final joinMatchmaking_headers = RIOT_HEADERS;
    final joinMatchmaking_response = await http.post(Uri.parse(joinMatchmaking_api), headers: joinMatchmaking_headers);

    if (joinMatchmaking_response.statusCode == 200) {
      return;
    }
  }

  Future<void> postLeavematchmaking(String partyId) async {
    final leaveMatchmaking_api = "$GLZ_URL/parties/v1/parties/$partyId/matchmaking/leave";
    final leaveMatchmaking_headers = RIOT_HEADERS;
    final leaveMatchmaking_response = await http.post(Uri.parse(leaveMatchmaking_api), headers: leaveMatchmaking_headers);

    if (leaveMatchmaking_response.statusCode == 200) {
      return;
    }
  }

  Future<void> getPreGameMatch() async {
    // match data
    String matchId;
    String mapBanner;
    String mapName;
    String gameMode;

    // ally team players data
    String allyTeamId;
    List<String> allyPlayerNames = [];
    List<String> allyAgentImages = [];
    List<bool> allySelectionStates = [];
    List<String> allyRanks = [];
    
    // enemy team players data
    String enemyTeamId;
    List<String> enemyPlayerNames = [];
    List<String> enemyAgentImages = [];
    List<bool> enemySelectionStates = [];
    List<String> enemyRanks = [];

    // get pregame player first
    final preGamePlayer_api = "$GLZ_URL/pregame/v1/players/${Cache.accountToken!.puuid}";
    final preGamePlayer_headers = RIOT_HEADERS;
    final preGamePlayer_response = await http.get(Uri.parse(preGamePlayer_api), headers: preGamePlayer_headers);

    if (preGamePlayer_response.statusCode == 200) {
      var preGamePlayer_data = json.decode(preGamePlayer_response.body);
      matchId = preGamePlayer_data['MatchID'];
    }
    else{
      return;
    }

    // get match info
    final preGameMatch_api = "$GLZ_URL/pregame/v1/matches/$matchId";
    final preGameMatch_headers = RIOT_HEADERS;
    final preGameMatch_response = await http.get(Uri.parse(preGameMatch_api), headers: preGameMatch_headers);

    if (preGameMatch_response.statusCode == 200) {
      var preGameMatch_data = json.decode(preGameMatch_response.body);
      mapBanner = "https://media.valorant-api.com/maps/${preGameMatch_data['MapID']}/listviewicon.png";
      gameMode = preGameMatch_data['Mode'];

      // get map data
      final maps_api = "https://valorant-api.com/v1/maps/${preGameMatch_data['MapID']}";
      final maps_response = await http.get(Uri.parse(maps_api));

      if (maps_response.statusCode == 200) {
        var maps_data = json.decode(maps_response.body);
        mapName = maps_data['displayName'];
      }

      Cache.currentMatch = CurrentMatch(
        mapBanner: mapBanner, 
        gameMode: gameMode,
      );

      // get ally team players info
      allyTeamId = preGameMatch_data['AllyTeam']['TeamID'];
      
      var allyPlayers = preGameMatch_data['AllyTeam']['Players']; // List

      for (var player in allyPlayers) {
        if (player['CharacterID'] != null && player['CharacterID'] != ""){
          allyAgentImages.add("https:/media.valorant-api.com/agents/${player['CharacterID']}/displayicon.png");
        }
        else{
          allyAgentImages.add("https://cdn.discordapp.com/attachments/1127494450030051349/1230609946920615996/image.png?ex=6633f1d2&is=66217cd2&hm=a516f2012a6689fac0e4d21ddeff4f000f414ae1ab9a749bbe7aa714367140c8&");
        }
        var playerId = player['Subject'];

        final nameService_api ="$PD_URL/name-service/v2/players";
        final nameService_headers = RIOT_HEADERS;
        final nameService_body = [playerId];
        final body = json.encode(nameService_body);

        final nameService_response = await http.put(Uri.parse(nameService_api), headers: nameService_headers, body: body);

        if (nameService_response.statusCode == 200) {
          var nameService_data = json.decode(nameService_response.body);
          var playerName = nameService_data[0]['GameName'] + " #" + nameService_data[0]['TagLine'];
          allyPlayerNames.add(playerName);
        }

        var pSelectionState = player['CharacterSelectionState'];
        if (pSelectionState == "" || pSelectionState == "selected") {
          allySelectionStates.add(false);
        }
        else if (pSelectionState == "locked"){
          allySelectionStates.add(true);
        }
        
        final rank_api = "https://api.henrikdev.xyz/valorant/v1/by-puuid/mmr/${Cache.accountToken!.region}/$playerId";
        final rank_response = await http.get(Uri.parse(rank_api));

        if (rank_response.statusCode == 200) {
          var rank_data = json.decode(rank_response.body);
          allyRanks.add(rank_data['data']['images']['large']);
        }
      }

      Cache.allyTeam = AllyTeam(
        allyTeamId: allyTeamId, 
        allyPlayerNames: allyPlayerNames, 
        allyAgentImages: allyAgentImages, 
        allySelectionStates: allySelectionStates, 
        allyRanks: allyRanks,
      );

      // get enemy team players info
      enemyTeamId = preGameMatch_data['EnemyTeam']?['TeamID'] ?? "";

      if (enemyTeamId != null && enemyTeamId != "") {
        var enemyPlayers = preGameMatch_data['EnemyTeam']['Players'];

        for (var player in enemyPlayers) {
          if (player['CharacterID'] != null && player['CharacterID'] != ""){
          enemyAgentImages.add("https:/media.valorant-api.com/agents/${player['CharacterID']}/displayicon.png");
        }
        else{
          enemyAgentImages.add("https://cdn.discordapp.com/attachments/1127494450030051349/1230609946920615996/image.png?ex=6633f1d2&is=66217cd2&hm=a516f2012a6689fac0e4d21ddeff4f000f414ae1ab9a749bbe7aa714367140c8&");
        }
          var playerId = player['Subject'];

          final nameService_api ="$PD_URL/name-service/v2/players";
          final nameService_headers = RIOT_HEADERS;
          final nameService_body = [playerId];
          final body = json.encode(nameService_body);

          final nameService_response = await http.put(Uri.parse(nameService_api), headers: nameService_headers, body: body);

          if (nameService_response.statusCode == 200) {
            var nameService_data = json.decode(nameService_response.body);
            var playerName = nameService_data[0]['GameName'] + " #" + nameService_data[0]['TagLine'];
            enemyPlayerNames.add(playerName);
          }

          var pSelectionState = player['CharacterSelectionState'];
          if (pSelectionState == "" || pSelectionState == "selected") {
            enemySelectionStates.add(false);
          }
          else if (pSelectionState == "locked"){
            enemySelectionStates.add(true);
          }
          
          final rank_api = "https://api.henrikdev.xyz/valorant/v1/by-puuid/mmr/${Cache.accountToken!.region}/$playerId";
          final rank_response = await http.get(Uri.parse(rank_api));

          if (rank_response.statusCode == 200) {
            var rank_data = json.decode(rank_response.body);
            enemyRanks.add(rank_data['data']['images']['large']);
          }
        }

        Cache.enemyTeam = EnemyTeam(
          enemyTeamId: enemyTeamId, 
          enemyPlayerNames: enemyPlayerNames, 
          enemyAgentImages: enemyAgentImages, 
          enemySelectionStates: enemySelectionStates, 
          enemyRanks: enemyRanks,
        );
      }
    }
  }

}
