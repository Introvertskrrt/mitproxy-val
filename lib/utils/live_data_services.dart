// ignore_for_file: non_constant_identifier_names, unused_local_variable, constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/controllers/live_controller.dart';
import 'package:mitproxy_val/models/assets_api_models/agent_model.dart';
import 'package:mitproxy_val/models/assets_api_models/competitive_tiers_model.dart';
import 'package:mitproxy_val/models/assets_api_models/map_model.dart';
import 'package:mitproxy_val/models/client_api_models/currentgame_match_model.dart';
import 'package:mitproxy_val/models/client_api_models/currentgame_player_model.dart';
import 'package:mitproxy_val/models/client_api_models/name_service_model.dart';
import 'package:mitproxy_val/models/client_api_models/party_model.dart';
import 'package:mitproxy_val/models/client_api_models/party_player_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_mmr_model.dart';
import 'package:mitproxy_val/models/client_api_models/pregame_match_model.dart';
import 'package:mitproxy_val/models/client_api_models/pregame_player_model.dart';
import 'package:mitproxy_val/utils/globals.dart';
import 'package:mitproxy_val/utils/mitproxy_notification.dart';
import 'package:mitproxy_val/utils/valorant_asset_services.dart';
import 'package:mitproxy_val/utils/valorant_client_services.dart';

class LiveServices {
  Timer? periodicTimer;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> getAgentsData() async {
    final liveController = Get.put(LiveController());
    List<String> allAgentsIds = [];
    List<String> allAgentsImages = [];
    List<String> allAgentsNames = [];
    
    AgentsResponse agentsResponse = await ValorantAssetServices.getAgentsData();
    var agents_list = agentsResponse.data;

    for (var agent in agents_list) {
      if (agent.isPlayableCharacter == true) {
        allAgentsIds.add(agent.uuid);
        allAgentsImages.add(agent.displayIcon);
        allAgentsNames.add(agent.displayName);
      }
    }

    liveController.allAgentsIds.value = allAgentsIds;
    liveController.allAgentsImages.value = allAgentsImages;
    liveController.allAgentsNames.value = allAgentsNames;
  }

  Future<void> getPartyData() async {
    final liveController = Get.put(LiveController());

    final String partyId;
    final List<String> playerNames = [];
    final List<String> playerCards = [];
    final List<int> playerLevels = [];
    final List<String> playerRanks = [];

    // get party id
    PartyPlayerResponse partyPlayerResponse = await ValorantClientServices.getPartyPlayer();
    partyId = partyPlayerResponse.currentPartyID;

    // get party members
    PartyResponse partyResponse = await ValorantClientServices.getParty(partyId);
    var party_member_list = partyResponse.members;

    List<String> playerUuids = [];
    for (var member in party_member_list) {
      playerUuids.add(member.subject);
      playerCards.add("https://media.valorant-api.com/playercards/${member.playerIdentity.playerCardID}/displayicon.png");
      playerLevels.add(member.playerIdentity.accountLevel);
    }

    // get each party members' name
    List<NameServiceResponse> nameServiceResponse = await ValorantClientServices.nameService(playerUuids);
    for (var pName in nameServiceResponse) {
      playerNames.add('${pName.gameName} #${pName.tagLine}');
    }

    // get each player's rank image
    for (var puuid in playerUuids) {
      PlayerMMRResponse playerMMRResponse = await ValorantClientServices.getPlayerMMRResponse(puuid);
      var _currentCompetitiveSeason = playerMMRResponse.latestCompetitiveUpdate.seasonID;
      var competitiveTier = playerMMRResponse.queueSkills['competitive']?.seasonalInfoBySeasonID[_currentCompetitiveSeason]?.competitiveTier ?? 0;

      // convert competitive tier to actual rank
      CompetitiveTiersResponse competitiveTiersResponse = await ValorantAssetServices.getCompetitiveTiersData();
      var competitiveTier_list = competitiveTiersResponse.data;
      var latestCompetitiveTier = competitiveTier_list.last;
      var tierList = latestCompetitiveTier.tiers;

      for (var tier in tierList) {
        if (tier.tier == competitiveTier) {
          playerRanks.add(tier.largeIcon ?? "");

          liveController.partyId.value = partyId;
          liveController.playerNames.value = playerNames;
          liveController.playerCards.value = playerCards;
          liveController.playerLevels.value = playerLevels;
          liveController.playerRanks.value = playerRanks;
        }
      }
    }
  }

  Future<void> getPreGame() async {
    final liveController = Get.put(LiveController());
    // match data
    String matchId;
    String mapBanner;
    String mapName;
    String gameMode;

    // ally team players data
    String allyTeamId = '';
    Color allyTeamColor = const Color.fromRGBO(255, 255, 255, 1);
    List<String> allyPlayerNames = [];
    List<String> allyAgentImages = [];
    List<bool> allySelectionStates = [];
    List<String> allyRanks = [];

    // enemy team players data
    List<bool> enemySelectionStates = [];

    // get pregame player 
    PreGamePlayerResponse preGamePlayerResponse = await ValorantClientServices.getPreGamePlayer();
    matchId = preGamePlayerResponse.matchID;

    if (matchId.isNotEmpty) {
      // if match id is not empty, it means match found
      if (!liveController.isUserNotified.value) {
        MitproxyNotification.sendNotification(title: "Mitproxy Valorant", body: "Match Found", fln: flutterLocalNotificationsPlugin);
        liveController.isUserNotified.value = true;
      }

      liveController.isOnMatchmaking.value = false;
      liveController.preMatchId.value = matchId;

      // get match info
      PreGameMatchResponse preGameMatchResponse = await ValorantClientServices.getPreGameMatch(matchId);
      String _gameMode = preGameMatchResponse.mode;

      if (preGameMatchResponse.isRanked == true) {
        gameMode = "Competitive";
      } 
      else {
        gameMode = "Casual";
      }
      var mapUrl = preGameMatchResponse.mapID;
      
      // get map info
      MapsResponse mapsResponse = await ValorantAssetServices.getMapData();
      var map_list = mapsResponse.data;

      for (var map in map_list) {
        if (map.mapUrl == mapUrl) {
          mapName = map.displayName;
          mapBanner = "https://media.valorant-api.com/maps/${map.uuid}/listviewicon.png";
          liveController.mapBanner.value = mapBanner;
          liveController.mapName.value = mapName;
          liveController.gameMode.value = gameMode;
        }
      }

      // get ally team players info
      if (preGameMatchResponse.allyTeam!.teamID == "Red") {
        allyTeamId = "Attacker";
        allyTeamColor = const Color(0xFFFF0000);
      } else {
        // Blue
        allyTeamId = "Defender";
        allyTeamColor = const Color(0xFF0000FF);
      }

      var allyPlayers = preGameMatchResponse.allyTeam!.players; // List

      for (var player in allyPlayers) {
        if (player.characterID != null && player.characterID!= "") {
          allyAgentImages.add("https://media.valorant-api.com/agents/${player.characterID}/displayiconsmall.png");
        } else {
          allyAgentImages.add("https://i.imgur.com/aFZAvdh.png");
        }
        var playerId = player.subject;

        List<NameServiceResponse> nameServiceResponse = await ValorantClientServices.nameService([playerId]);
        var pName = "${nameServiceResponse.first.gameName} #${nameServiceResponse.first.tagLine}";
        allyPlayerNames.add(pName);

        var pSelectionState = player.characterSelectionState;
        if (pSelectionState == "" || pSelectionState == "selected") {
          allySelectionStates.add(false);
        } else if (pSelectionState == "locked") {
          allySelectionStates.add(true);
        }

        // get each player's rank
        if (liveController.allyRanks.length != allyPlayers.length) {
          PlayerMMRResponse playerMMRResponse = await ValorantClientServices.getPlayerMMRResponse(playerId);
          var _currentCompetitiveSeason = playerMMRResponse.latestCompetitiveUpdate.seasonID;
          var competitiveTier = playerMMRResponse.queueSkills['competitive']?.seasonalInfoBySeasonID[_currentCompetitiveSeason]?.competitiveTier ?? 0;

          // convert competitive tier to actual rank
          CompetitiveTiersResponse competitiveTiersResponse = await ValorantAssetServices.getCompetitiveTiersData();
          var competitiveTier_list = competitiveTiersResponse.data;
          var latestCompetitiveTier = competitiveTier_list.last;
          var tierList = latestCompetitiveTier.tiers;

          for (var tier in tierList) {
            if (tier.tier == competitiveTier) {
              allyRanks.add(tier.largeIcon ?? "");
            }
          }
          liveController.allyRanks.value = allyRanks;
        }
      }
      liveController.allyTeamId.value = allyTeamId;
      liveController.allyPlayerNames.value = allyPlayerNames;
      liveController.allyAgentImages.value = allyAgentImages;
      liveController.allySelectionStates.value = allySelectionStates;
      liveController.allyTeamColor.value = allyTeamColor;
    } else {
      await getCurrentGame();
    }
  }

  Future<void> getCurrentGame() async {
    final liveController = Get.put(LiveController());

    String allyTeamId = '';
    Color allyTeamColor = const Color.fromRGBO(255, 255, 255, 1);
    List<String> allyPlayerNames = [];
    List<String> allyAgentImages = [];
    List<bool> allySelectionStates = [];
    List<String> allyRanks = [];

    String enemyTeamId = '';
    Color enemyTeamColor = const Color.fromRGBO(255, 255, 255, 1);
    List<String> enemyPlayerNames = [];
    List<String> enemyAgentImages = [];
    List<String> enemyRanks = [];

    String matchId;

    CurrentGamePlayerResponse currentGamePlayerResponse = await ValorantClientServices.getCurrentGamePlayer();
    if (currentGamePlayerResponse.matchID.isNotEmpty) {
      matchId = currentGamePlayerResponse.matchID;
    } else {
      liveController.preMatchId.value = '';
      liveController.mapName.value = '';
      liveController.mapBanner.value = 'https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/listviewicon.png';
      liveController.gameMode.value = '';
      liveController.isUserNotified.value = false;

      // reset ally players value
      liveController.allyTeamId.value = '';
      liveController.allyPlayerNames.clear(); // Clear the list
      liveController.allyAgentImages.clear(); // Clear the list
      liveController.allySelectionStates.clear(); // Clear the list
      liveController.allyRanks.clear(); // Clear the list
      liveController.allyTeamColor.value = const Color.fromARGB(255, 255, 255, 255);

      liveController.enemyTeamId.value = '';
      liveController.enemyPlayerNames.clear(); // Clear the list
      liveController.enemyAgentImages.clear(); // Clear the list
      liveController.enemySelectionStates.clear(); // Clear the list
      liveController.enemyRanks.clear(); // Clear the list
      liveController.enemyTeamColor.value = const Color.fromARGB(255, 255, 255, 255);
      return;
    }

    // core game (get enemy's data)
    CurrentGameMatchResponse currentGameMatchResponse = await ValorantClientServices.getCurrentGameMatch(matchId);
    if (currentGameMatchResponse.matchID.isNotEmpty) {
      var myTeamId;

      // all players in current match
      var allPlayers = currentGameMatchResponse.players; // List
      for (var player in allPlayers) {
        if (player.subject == Globals.accountToken!.puuid) {

          myTeamId = player.teamID; // Red || Blue

          // set Team ID and Border Color
          if (myTeamId == "Red") {
            liveController.allyTeamId.value = "Attacker";
            liveController.allyTeamColor.value = const Color(0xFFFF0000);

            liveController.enemyTeamId.value = "Defender";
            liveController.enemyTeamColor.value = const Color(0xFF0000FF);
          } else {
            liveController.allyTeamId.value = "Defender";
            liveController.allyTeamColor.value = const Color(0xFF0000FF);

            liveController.enemyTeamId.value = "Attacker";
            liveController.enemyTeamColor.value = const Color(0xFFFF0000);
          }
        }
      }

      // filter from all players and select enemy players only
      List<String> allyPlayers = []; // uuid
      List<String> enemyPlayers = []; // uuid
      for (var player in allPlayers) {
        if (player.teamID != myTeamId) {
          enemyAgentImages.add("https://media.valorant-api.com/agents/${player.characterID}/displayiconsmall.png");
          enemyPlayers.add(player.subject);
        } else {
          allyAgentImages.add("https://media.valorant-api.com/agents/${player.characterID}/displayiconsmall.png");
          allyPlayers.add(player.subject);
        }
      }

      // extract enemy data
      if (liveController.enemyRanks.length != enemyPlayers.length) {
        for (var playerId in enemyPlayers) {
          List<NameServiceResponse> nameServiceResponse = await ValorantClientServices.nameService([playerId]);
          var pName = "${nameServiceResponse.first.gameName} #${nameServiceResponse.first.tagLine}";
          enemyPlayerNames.add(pName);

          // get each player's rank
          PlayerMMRResponse playerMMRResponse = await ValorantClientServices.getPlayerMMRResponse(playerId);
          var _currentCompetitiveSeason = playerMMRResponse.latestCompetitiveUpdate.seasonID;
          var competitiveTier = playerMMRResponse.queueSkills['competitive']?.seasonalInfoBySeasonID[_currentCompetitiveSeason]?.competitiveTier ?? 0;

          // convert competitive tier to actual rank
          CompetitiveTiersResponse competitiveTiersResponse = await ValorantAssetServices.getCompetitiveTiersData();
          var competitiveTier_list = competitiveTiersResponse.data;
          var latestCompetitiveTier = competitiveTier_list.last;
          var tierList = latestCompetitiveTier.tiers;

          for (var tier in tierList) {
            if (tier.tier == competitiveTier) {
              enemyRanks.add(tier.largeIcon ?? "");
            }
          }
        }
        liveController.enemyRanks.value = enemyRanks;
        liveController.enemyPlayerNames.value = enemyPlayerNames;
        liveController.enemyTeamColor.value = enemyTeamColor;
      }
      liveController.enemyAgentImages.value = enemyAgentImages;

      // extract ally data
      if (liveController.allyRanks.length != allyPlayers.length) {
        for (var playerId in allyPlayers) {
          List<NameServiceResponse> nameServiceResponse = await ValorantClientServices.nameService([playerId]);
          var pName = "${nameServiceResponse.first.gameName} #${nameServiceResponse.first.tagLine}";
          allyPlayerNames.add(pName);

          // get each player's rank
          PlayerMMRResponse playerMMRResponse = await ValorantClientServices.getPlayerMMRResponse(playerId);
          var _currentCompetitiveSeason = playerMMRResponse.latestCompetitiveUpdate.seasonID;
          var competitiveTier = playerMMRResponse.queueSkills['competitive']?.seasonalInfoBySeasonID[_currentCompetitiveSeason]?.competitiveTier ?? 0;

          // convert competitive tier to actual rank
          CompetitiveTiersResponse competitiveTiersResponse = await ValorantAssetServices.getCompetitiveTiersData();
          var competitiveTier_list = competitiveTiersResponse.data;
          var latestCompetitiveTier = competitiveTier_list.last;
          var tierList = latestCompetitiveTier.tiers;

          for (var tier in tierList) {
            if (tier.tier == competitiveTier) {
              allyRanks.add(tier.largeIcon ?? "");
            }
          }
        }
        liveController.allyRanks.value = allyRanks;
        liveController.allyPlayerNames.value = allyPlayerNames;
        liveController.allyTeamColor.value = allyTeamColor;
      }
      liveController.allyAgentImages.value = allyAgentImages;
      liveController.allySelectionStates.value = [true, true, true, true, true];
    }
  }
}
