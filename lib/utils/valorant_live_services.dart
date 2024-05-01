// ignore_for_file: non_constant_identifier_names, unused_local_variable, constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/controllers/live_controller.dart';
import 'package:mitproxy_val/utils/cache.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/valorant_endpoints.dart';

class ValorantLiveServices {
  Timer? periodicTimer;

  Future<void> getAgentsData() async {
    final liveController = Get.put(LiveController());
    List<String> allAgentsIds = [];
    List<String> allAgentsImages = [];
    List<String> allAgentsNames = [];

    const agent_api = "https://valorant-api.com/v1/agents";
    final agent_response = await http.get(Uri.parse(agent_api));
    if (agent_response.statusCode == 200) {
      var agent_data = json.decode(agent_response.body);
      var agent_data_list = agent_data['data'];

      for (var agent in agent_data_list) {
        if (agent['isPlayableCharacter'] == true) {
          allAgentsIds.add(agent['uuid']);
          allAgentsImages.add(agent['displayIcon']);
          allAgentsNames.add(agent['displayName']);
        }
      }

      liveController.allAgentsIds.value = allAgentsIds;
      liveController.allAgentsImages.value = allAgentsImages;
      liveController.allAgentsNames.value = allAgentsNames;
    }
  }

  Future<void> getPartyData() async {
    final liveController = Get.put(LiveController());

    final String partyId;
    final List<String> playerNames = [];
    final List<String> playerCards = [];
    final List<int> playerLevels = [];
    final List<String> playerRanks = [];

    final partyPlayer_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/players/${Cache.accountToken!.puuid}";
    final partyPlayer_response = await http.get(Uri.parse(partyPlayer_api),
        headers: ValorantEndpoints.RIOT_HEADERS);
    if (partyPlayer_response.statusCode == 200) {
      var partyPlayer_data = json.decode(partyPlayer_response.body);
      partyId = partyPlayer_data['CurrentPartyID'];
    } else if (partyPlayer_response.statusCode == 400) {
      throw ExceptionTokenExpired("Token expired");
    } else if (partyPlayer_response.statusCode == 404){
      throw ExceptionPlayerNotInGame("Player not in game");
    }
    else{
      return;
    }

    final party_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId";
    final party_response = await http.get(Uri.parse(party_api), headers: ValorantEndpoints.RIOT_HEADERS);
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
      final nameService_api = "${ValorantEndpoints.PD_URL}/name-service/v2/players";
      final nameService_body = json.encode(playerUuids);
      final nameService_response = await http.put(Uri.parse(nameService_api), headers: ValorantEndpoints.RIOT_HEADERS, body: nameService_body);
      if (nameService_response.statusCode == 200) {
        var nameService_data = json.decode(nameService_response.body);
        for (var pName in nameService_data) {
          playerNames.add('${pName['GameName']} #${pName['TagLine']}');
        }
      } else if (nameService_response.statusCode == 400) {
        throw ExceptionTokenExpired("Token expired");
      } else if (nameService_response.statusCode == 404){
        throw ExceptionPlayerNotInGame("Player not in game");
      }
      else{
        return;
      }

      // get each player's rank image
      for (var puuid in playerUuids) {
        final playerMmr_api = "${ValorantEndpoints.PD_URL}/mmr/v1/players/$puuid";
        final playerMmr_response = await http.get(Uri.parse(playerMmr_api), headers: ValorantEndpoints.RIOT_HEADERS);
        if (playerMmr_response.statusCode == 200) {
          var playerMmr_data = json.decode(playerMmr_response.body);
          var _currentCompetitiveSeason = playerMmr_data['LatestCompetitiveUpdate']['SeasonID'];

          var competitiveTier = playerMmr_data['QueueSkills']['competitive']['SeasonalInfoBySeasonID']?[_currentCompetitiveSeason]?['CompetitiveTier'] ?? 0;

          // convert competitive tier to actual rank
          const competitiveTier_api = "https://valorant-api.com/v1/competitivetiers";
          final competitiveTier_response = await http.get(Uri.parse(competitiveTier_api));
          if (competitiveTier_response.statusCode == 200) {
            var competitiveTier_data = json.decode(competitiveTier_response.body);
            List<dynamic> competitiveTier_list = competitiveTier_data['data'];
            var latestCompetitiveTier = competitiveTier_list.last;
            var tierList = latestCompetitiveTier['tiers'];

            for (var tier in tierList) {
              if (tier['tier'] == competitiveTier) {
                playerRanks.add(tier['largeIcon']);

                liveController.partyId.value = partyId;
                liveController.playerNames.value = playerNames;
                liveController.playerCards.value = playerCards;
                liveController.playerLevels.value = playerLevels;
                liveController.playerRanks.value = playerRanks;
                await Future.delayed(const Duration(seconds: 3));
              }
            }
          }
        } else if (playerMmr_response.statusCode == 400) {
          throw ExceptionTokenExpired("Token expired");
        } else if (playerMmr_response.statusCode == 404){
          throw ExceptionPlayerNotInGame("Player not in game");
        }
        else{
          return;
        }
      }
    }
  }

  Future<void> postPartyReadyState(String partyId, bool readyState) async {
    final partySetReady_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/members/${Cache.accountToken!.puuid}/setReady";
    final partySetReady_body = {"ready": readyState};

    final body = json.encode(partySetReady_body);

    final partySetReady_response = await http.post(Uri.parse(partySetReady_api), headers: ValorantEndpoints.RIOT_HEADERS, body: body);
    if (partySetReady_response.statusCode == 200) {
      return;
    } else if (partySetReady_response.statusCode == 400) {
      throw ExceptionTokenExpired("Token expired");
    } else if (partySetReady_response.statusCode == 404){
      throw ExceptionPlayerNotInGame("Player not in game");
    }
    else{
      return;
    }
  }

  Future<String> postGeneratePartyCode(String partyId) async {
    final generatePartyCode_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/invitecode";
    final genereatePartyCode_response = await http.post(Uri.parse(generatePartyCode_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (genereatePartyCode_response.statusCode == 200) {
      var response_data = json.decode(genereatePartyCode_response.body);
      var partyCode = response_data['InviteCode'];
      return partyCode;
    } else {
      return "error";
    }
  }

  Future<String> postDeletePartyCode(String partyId) async {
    final deletePartyCode_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/invitecode";
    final deletePartyCode_response = await http.delete( Uri.parse(deletePartyCode_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (deletePartyCode_response.statusCode == 200) {
      return "******";
    } else {
      return "******";
    }
  }

  Future<void> postJoinPartyByCode(String partyCode) async {
    final joinParty_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/players/joinbycode/$partyCode";
    final joinParty_headers = ValorantEndpoints.RIOT_HEADERS;
    final joinParty_response = await http.get(Uri.parse(joinParty_api), headers: joinParty_headers);

    if (joinParty_response.statusCode == 200) {
      return;
    }
  }

  Future<void> postPartyAccessibility(String partyId, String partyStatus) async {
    final partyAccessibility_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/accessibility";
    final partyAccessibility_body = {"accessibility": partyStatus};
    final body = json.encode(partyAccessibility_body);

    final partyAccessibility_response = await http.post(Uri.parse(partyAccessibility_api), headers: ValorantEndpoints.RIOT_HEADERS, body: body);

    if (partyAccessibility_response.statusCode == 200) {
      return;
    }
  }

  Future<void> postSetGameMode(String partyId, String gameMode) async {
    final setGameMode_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/queue";
    final setGameMode_headers = ValorantEndpoints.RIOT_HEADERS;
    final setGameMode_body = {'queueId': gameMode};
    final body = json.encode(setGameMode_body);

    final setGameMode_response = await http.post(Uri.parse(setGameMode_api), headers: setGameMode_headers, body: body);

    if (setGameMode_response.statusCode == 200) {
      return;
    }
  }

  Future<void> postEntermatchmaking(String partyId) async {
    final joinMatchmaking_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/matchmaking/join";
    final joinMatchmaking_headers = ValorantEndpoints.RIOT_HEADERS;
    final joinMatchmaking_response = await http.post(Uri.parse(joinMatchmaking_api), headers: joinMatchmaking_headers);

    if (joinMatchmaking_response.statusCode == 200) {
      return;
    }
  }

  Future<void> postLeavematchmaking(String partyId) async {
    final leaveMatchmaking_api ="${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/matchmaking/leave";
    final leaveMatchmaking_headers = ValorantEndpoints.RIOT_HEADERS;
    final leaveMatchmaking_response = await http.post(Uri.parse(leaveMatchmaking_api), headers: leaveMatchmaking_headers);

    if (leaveMatchmaking_response.statusCode == 200) {
      return;
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

    // get pregame player first
    final preGamePlayer_api = "${ValorantEndpoints.GLZ_URL}/pregame/v1/players/${Cache.accountToken!.puuid}";
    final preGamePlayer_response = await http.get(Uri.parse(preGamePlayer_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (preGamePlayer_response.statusCode == 200) {
      liveController.isOnMatchmaking.value = false;
      var preGamePlayer_data = json.decode(preGamePlayer_response.body);
      matchId = preGamePlayer_data['MatchID'];
      liveController.preMatchId.value = matchId;

      // get match info
      final preGameMatch_api = "${ValorantEndpoints.GLZ_URL}/pregame/v1/matches/$matchId";
      final preGameMatch_response = await http.get(Uri.parse(preGameMatch_api), headers: ValorantEndpoints.RIOT_HEADERS);

      if (preGameMatch_response.statusCode == 200) {
        var preGameMatch_data = json.decode(preGameMatch_response.body);
        String _gameMode = preGameMatch_data['Mode'];

        if (preGameMatch_data['IsRanked'] == true) {
          gameMode = "Competitive";
        } 
        else {
          gameMode = "Casual";
        }

        var mapUrl = preGameMatch_data['MapID'];
        var maps_api = "https://valorant-api.com/v1/maps";
        final maps_response = await http.get(Uri.parse(maps_api));
        if (maps_response.statusCode == 200) {
          var map_data_list = json.decode(maps_response.body)['data'];

          for (var maps in map_data_list) {
            if (maps['mapUrl'] == mapUrl) {
              mapName = maps['displayName'];
              mapBanner = "https://media.valorant-api.com/maps/${maps['uuid']}/listviewicon.png";
              liveController.mapBanner.value = mapBanner;
              liveController.mapName.value = mapName;
              liveController.gameMode.value = gameMode;
            }
          }
        }

        // get ally team players info
        if (preGameMatch_data['AllyTeam']['TeamID'] == "Red") {
          allyTeamId = "Attacker";
          allyTeamColor = const Color(0xFFFF0000);
        } else {
          // Blue
          allyTeamId = "Defender";
          allyTeamColor = const Color(0xFF0000FF);
        }

        var allyPlayers = preGameMatch_data['AllyTeam']['Players']; // List

        for (var player in allyPlayers) {
          if (player['CharacterID'] != null && player['CharacterID'] != "") {
            allyAgentImages.add("https://media.valorant-api.com/agents/${player['CharacterID']}/displayiconsmall.png");
          } else {
            allyAgentImages.add("https://i.imgur.com/aFZAvdh.png");
          }
          var playerId = player['Subject'];

          final nameService_api = "${ValorantEndpoints.PD_URL}/name-service/v2/players";
          final nameService_body = [playerId];
          final body = json.encode(nameService_body);

          final nameService_response = await http.put(Uri.parse(nameService_api), headers: ValorantEndpoints.RIOT_HEADERS, body: body);

          if (nameService_response.statusCode == 200) {
            var nameService_data = json.decode(nameService_response.body);
            var playerName = nameService_data[0]['GameName'] + " #" + nameService_data[0]['TagLine'];
            allyPlayerNames.add(playerName);
          }

          var pSelectionState = player['CharacterSelectionState'];
          if (pSelectionState == "" || pSelectionState == "selected") {
            allySelectionStates.add(false);
          } else if (pSelectionState == "locked") {
            allySelectionStates.add(true);
          }

          // get each player's rank
          if (liveController.allyRanks.length != allyPlayers.length) {
            final playerMmr_api = "${ValorantEndpoints.PD_URL}/mmr/v1/players/$playerId";
            final playerMmr_headers = ValorantEndpoints.RIOT_HEADERS;
            final playerMmr_response = await http.get(Uri.parse(playerMmr_api), headers: playerMmr_headers);

            if (playerMmr_response.statusCode == 200) {
              var playerMmr_data = json.decode(playerMmr_response.body);
              var _currentCompetitiveSeason = playerMmr_data['LatestCompetitiveUpdate']['SeasonID'];
              var competitiveTier = playerMmr_data['QueueSkills']['competitive']['SeasonalInfoBySeasonID']?[_currentCompetitiveSeason]?['CompetitiveTier'] ?? 0;

              // convert competitive tier to actual rank
              const competitiveTier_api = "https://valorant-api.com/v1/competitivetiers";
              final competitiveTier_response = await http.get(Uri.parse(competitiveTier_api));
              if (competitiveTier_response.statusCode == 200) {
                var competitiveTier_data = json.decode(competitiveTier_response.body);
                List<dynamic> competitiveTier_list = competitiveTier_data['data'];
                var latestCompetitiveTier = competitiveTier_list.last;
                var tierList = latestCompetitiveTier['tiers'];

                for (var tier in tierList) {
                  if (tier['tier'] == competitiveTier) {
                    allyRanks.add(tier['largeIcon']);
                    await Future.delayed(const Duration(seconds: 1));
                  }
                }
                liveController.allyRanks.value = allyRanks;
              }
            }
          }
        }
        liveController.allyTeamId.value = allyTeamId;
        liveController.allyPlayerNames.value = allyPlayerNames;
        liveController.allyAgentImages.value = allyAgentImages;
        liveController.allySelectionStates.value = allySelectionStates;
        liveController.allyTeamColor.value = allyTeamColor;
      }
    } else {
      liveController.allySelectionStates.value = [true, true, true, true, true];
      await Future.delayed(const Duration(seconds: 5));
      await getCurrentGame();
    }
  }

  Future<void> getCurrentGame() async {
    final liveController = Get.put(LiveController());
    String enemyTeamId = '';
    Color enemyTeamColor = const Color.fromRGBO(255, 255, 255, 1);
    List<String> enemyPlayerNames = [];
    List<String> enemyAgentImages = [];
    List<String> enemyRanks = [];

    String matchId;

    final currentGamePlayer_api = "${ValorantEndpoints.GLZ_URL}/core-game/v1/players/${Cache.accountToken!.puuid}";
    final currentGamePlayer_headers = ValorantEndpoints.RIOT_HEADERS;
    final currentGamePlayers_response = await http.get(Uri.parse(currentGamePlayer_api), headers: currentGamePlayer_headers);

    if (currentGamePlayers_response.statusCode == 200) {
      var currentGamePlayers_data = json.decode(currentGamePlayers_response.body);
      matchId = currentGamePlayers_data['MatchID'];
    } else {

      liveController.preMatchId.value = '';
      liveController.mapName.value = '';
      liveController.mapBanner.value = 'https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/listviewicon.png';
      liveController.gameMode.value = '';

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
    final currentGameMatch_api = "${ValorantEndpoints.GLZ_URL}/core-game/v1/matches/$matchId";
    final currentGameMatch_headers = ValorantEndpoints.RIOT_HEADERS;
    final currentGameMatch_response = await http.get(Uri.parse(currentGameMatch_api), headers: currentGameMatch_headers);

    if (currentGameMatch_response.statusCode == 200) {
      var currentGameMatch_data = json.decode(currentGameMatch_response.body);
      var eTeamId;
      if (liveController.allyTeamId.value == "Attacker") {
        eTeamId = "Red";
      } else {
        eTeamId = "Blue";
      }
      var allPlayers = currentGameMatch_data['Players']; // List

      for (var player in allPlayers) {
        if (player['Subject'] == Cache.accountToken!.puuid && player['TeamID'] == eTeamId) {
          liveController.allyTeamId.value = "Attacker";
          liveController.allyTeamColor.value = const Color(0xFFFF0000);

          liveController.enemyTeamId.value = "Defender";
          liveController.enemyTeamColor.value = const Color(0xFF0000FF);
        } else {
          // Blue
          liveController.allyTeamId.value = "Defender";
          liveController.allyTeamColor.value = const Color(0xFF0000FF);

          liveController.enemyTeamId.value = "Attacker";
          liveController.enemyTeamColor.value = const Color(0xFFFF0000);
        }
      }

      // filter from all players and select enemy players only
      var enemyPlayers = []; // uuid
      for (var player in allPlayers) {
        if (player['TeamID'] != eTeamId) {
          enemyAgentImages.add("https://media.valorant-api.com/agents/${player['CharacterID']}/displayiconsmall.png");
          enemyPlayers.add(player['Subject']);
        }
      }
      if (liveController.enemyRanks.length != enemyPlayers.length) {
        for (var player in enemyPlayers) {
          final nameService_api = "${ValorantEndpoints.PD_URL}/name-service/v2/players";
          final nameService_body = [player];
          final body = json.encode(nameService_body);

          final nameService_response = await http.put(Uri.parse(nameService_api), headers: ValorantEndpoints.RIOT_HEADERS, body: body);

          if (nameService_response.statusCode == 200) {
            var nameService_data = json.decode(nameService_response.body);
            var playerName = nameService_data[0]['GameName'] + " #" + nameService_data[0]['TagLine'];
            enemyPlayerNames.add(playerName);
          }

          // get each player's rank
          final playerMmr_api = "${ValorantEndpoints.PD_URL}/mmr/v1/players/$player";
          final playerMmr_headers = ValorantEndpoints.RIOT_HEADERS;
          final playerMmr_response = await http.get(Uri.parse(playerMmr_api), headers: playerMmr_headers);
          if (playerMmr_response.statusCode == 200) {
            var playerMmr_data = json.decode(playerMmr_response.body);
            var _currentCompetitiveSeason = playerMmr_data['LatestCompetitiveUpdate']['SeasonID'];
            var competitiveTier = playerMmr_data['QueueSkills']['competitive']['SeasonalInfoBySeasonID']?[_currentCompetitiveSeason]?['CompetitiveTier'] ?? 0;

            // convert competitive tier to actual rank
            const competitiveTier_api = "https://valorant-api.com/v1/competitivetiers";
            final competitiveTier_response = await http.get(Uri.parse(competitiveTier_api));
            if (competitiveTier_response.statusCode == 200) {
              var competitiveTier_data = json.decode(competitiveTier_response.body);
              List<dynamic> competitiveTier_list = competitiveTier_data['data'];
              var latestCompetitiveTier = competitiveTier_list.last;
              var tierList = latestCompetitiveTier['tiers'];

              for (var tier in tierList) {
                if (tier['tier'] == competitiveTier) {
                  enemyRanks.add(tier['largeIcon']);
                  await Future.delayed(const Duration(seconds: 2));
                }
              }
            }
          }
        }
        liveController.enemyRanks.value = enemyRanks;
        liveController.enemyPlayerNames.value = enemyPlayerNames;
        liveController.enemyAgentImages.value = enemyAgentImages;
        liveController.enemyTeamColor.value = enemyTeamColor;
      }
    }
  }

  Future<void> postInstalockAgent() async{
    final liveController = Get.put(LiveController());

    // using while loop for locking agent faster
    while (liveController.isInstalocking) {
      try {
        // use select agent api first to prevent instant load to the game
        final selectAgent_api = "${ValorantEndpoints.GLZ_URL}/pregame/v1/matches/${liveController.preMatchId.value}/select/${liveController.selectedAgentId.value}";
        final selectAgent_response = await http.post(Uri.parse(selectAgent_api), headers: ValorantEndpoints.RIOT_HEADERS);
        
        if (selectAgent_response.statusCode == 200) {
          final lockAgent_api = "${ValorantEndpoints.GLZ_URL}/pregame/v1/matches/${liveController.preMatchId.value}/lock/${liveController.selectedAgentId.value}";
          await http.post(Uri.parse(lockAgent_api), headers: ValorantEndpoints.RIOT_HEADERS);
        }
        if (!liveController.isInstalocking) {
          break;
        }
      } on http.ClientException {
        return;
      }
      
    }
  }
}
