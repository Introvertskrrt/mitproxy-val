// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/controllers/live_controller.dart';
import 'package:mitproxy_val/models/client_api_models/account_xp_model.dart';
import 'package:mitproxy_val/models/client_api_models/competitive_update_model.dart';
import 'package:mitproxy_val/models/client_api_models/currentgame_match_model.dart';
import 'package:mitproxy_val/models/client_api_models/currentgame_player_model.dart';
import 'package:mitproxy_val/models/client_api_models/match_details_model.dart';
import 'package:mitproxy_val/models/client_api_models/name_service_model.dart';
import 'package:mitproxy_val/models/client_api_models/party_model.dart';
import 'package:mitproxy_val/models/client_api_models/party_player_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_contract_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_loadout_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_mmr_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_storefront_model.dart';
import 'package:mitproxy_val/models/client_api_models/pregame_match_model.dart';
import 'package:mitproxy_val/models/client_api_models/pregame_player_model.dart';
import 'package:mitproxy_val/models/client_api_models/wallet_model.dart';
import 'package:mitproxy_val/utils/globals.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/valorant_endpoints.dart';

class ValorantClientServices {
  static Future<List<NameServiceResponse>> nameService(List<String> puuid) async {
    final nameService_api = "${ValorantEndpoints.PD_URL}/name-service/v2/players";
    final List<String> nameService_body = puuid;
    final nameService_body_json = json.encode(nameService_body);
    final nameService_response = await http.put(Uri.parse(nameService_api), headers: ValorantEndpoints.RIOT_HEADERS, body: nameService_body_json);

    if (nameService_response.statusCode == 200) {
      var nameService_data = json.decode(nameService_response.body);
      List<NameServiceResponse> responseList = [];
      for (var item in nameService_data) {
        responseList.add(NameServiceResponse.fromJson(item));
      }
      return responseList;
    } else if (nameService_response.statusCode == 400) {
      "Error: Unexpected response code ${nameService_response.statusCode}";
      throw ExceptionTokenExpired("Error: Valorant API return code ${nameService_response.statusCode}");
    } else {
      log("Error: Unexpected response code ${nameService_response.statusCode}");
      throw Exception("Error: Unexpected response code ${nameService_response.statusCode}");
    }
  }

  static Future<WalletData> getWalletData() async {
    final wallet_api = "${ValorantEndpoints.PD_URL}/store/v1/wallet/${Globals.accountToken!.puuid}";
    final wallet_response = await http.get(Uri.parse(wallet_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (wallet_response.statusCode == 200) {
      var wallet_data = json.decode(wallet_response.body);
      return WalletData.fromJson(wallet_data);
    } else if (wallet_response.statusCode == 400){
      throw ExceptionTokenExpired("Error: Valorant API return code ${wallet_response.statusCode}");
    } else {
      throw Exception("Error: Unexpected response code ${wallet_response.statusCode}");
    }
  }

  static Future<AccountXPResponse> getAccountXPData() async {
    final accountXp_api = "${ValorantEndpoints.PD_URL}/account-xp/v1/players/${Globals.accountToken!.puuid}";
    final accountXp_response = await http.get(Uri.parse(accountXp_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (accountXp_response.statusCode == 200) {
      var accountXp_data = json.decode(accountXp_response.body);
      return AccountXPResponse.fromJson(accountXp_data);
    } else if (accountXp_response.statusCode == 400){
      throw ExceptionTokenExpired("Error: Valorant API return code ${accountXp_response.statusCode}");
    } else {
      throw Exception("Error: Unexpected response code ${accountXp_response.statusCode}");
    }
  }

  static Future<PlayerMMRResponse> getPlayerMMRResponse(String puuid) async {
    final rank_api = "${ValorantEndpoints.PD_URL}/mmr/v1/players/$puuid";
    final rank_response = await http.get(Uri.parse(rank_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (rank_response.statusCode == 200) {
      var rank_data = json.decode(rank_response.body);
      return PlayerMMRResponse.fromJson(rank_data);
    } else if (rank_response.statusCode == 400) {
      throw ExceptionTokenExpired("Error: Valorant API return code ${rank_response.statusCode}");
    } else if(rank_response.statusCode == 404) {
      log("player not found");
      throw ExceptionPlayerNotFound("Error: player not found");
    } else {
      throw Exception("Error: Unexpected response code ${rank_response.statusCode}");
    }
    
  }

  static Future<PlayerLoadoutResponse> getPlayerLoadout() async {
    final playerLoadout_api = "${ValorantEndpoints.PD_URL}/personalization/v2/players/${Globals.accountToken!.puuid}/playerloadout";
    final playerLoadout_response = await http.get(Uri.parse(playerLoadout_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (playerLoadout_response.statusCode == 200) {
      var playerLoadout_data = json.decode(playerLoadout_response.body);
      return PlayerLoadoutResponse.fromJson(playerLoadout_data);
    } else if (playerLoadout_response.statusCode == 400){
      throw ExceptionTokenExpired("Error: Valorant API return code ${playerLoadout_response.statusCode}");
    } else {
      throw Exception("Error: Unexpected response code ${playerLoadout_response.statusCode}");
    }
  }

  static Future<ContractsResponse> getPlayerMission() async {
    final playerContract_api = "${ValorantEndpoints.PD_URL}/contracts/v1/contracts/${Globals.accountToken!.puuid}";
    final playerContract_response = await http.get(Uri.parse(playerContract_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (playerContract_response.statusCode == 200) {
      var contracts_data = json.decode(playerContract_response.body);
      return ContractsResponse.fromJson(contracts_data);
    } else if (playerContract_response.statusCode == 400) {
      throw ExceptionTokenExpired("Error: Valorant API return code ${playerContract_response.statusCode}");
    } else {
      throw Exception("Error: Unexpected response code ${playerContract_response.statusCode}");
    }
  }

  static Future<StorefrontResponse> getStoreFront() async {
    final storeFront_api = "${ValorantEndpoints.PD_URL}/store/v2/storefront/${Globals.accountToken!.puuid}";
    final storeFront_response = await http.get(Uri.parse(storeFront_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (storeFront_response.statusCode == 200) {
      var storeFront_data = json.decode(storeFront_response.body);
      return StorefrontResponse.fromJson(storeFront_data);
    } else if (storeFront_response.statusCode == 400) {
      throw ExceptionTokenExpired("Error: Valorant API return code ${storeFront_response.statusCode}");
    } else {
      throw Exception("Error: Unexpected response code ${storeFront_response.statusCode}");
    }
  }

  static Future<PartyPlayerResponse> getPartyPlayer() async{
    final partyPlayer_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/players/${Globals.accountToken!.puuid}";
    final partyPlayer_response = await http.get(Uri.parse(partyPlayer_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (partyPlayer_response.statusCode == 200) {
      var partyPlayer_data = json.decode(partyPlayer_response.body);
      return PartyPlayerResponse.fromJson(partyPlayer_data);
    } else if (partyPlayer_response.statusCode == 400) {
      throw ExceptionTokenExpired("Token expired");
    } else{
      log("Error at getPartyPlayer() $partyPlayer_response");
      throw ExceptionPlayerNotInGame("Player not in game");
    }
  }

  static Future<PartyResponse> getParty(String partyId) async {
    final party_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId";
    final party_response = await http.get(Uri.parse(party_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (party_response.statusCode == 200) {
      var party_data = json.decode(party_response.body);
      return PartyResponse.fromJson(party_data);
    } else if (party_response.statusCode == 400) {
      throw ExceptionTokenExpired("Token expired");
    } else {
      log("Error at getParty() $party_response");
      throw ExceptionPlayerNotInGame("Player not in game");
    }
  }

  static Future<PreGamePlayerResponse> getPreGamePlayer() async {
    final preGamePlayer_api = "${ValorantEndpoints.GLZ_URL}/pregame/v1/players/${Globals.accountToken!.puuid}";
    final preGamePlayer_response = await http.get(Uri.parse(preGamePlayer_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (preGamePlayer_response.statusCode == 200) {
      var preGamePlayer_data = json.decode(preGamePlayer_response.body);
      return PreGamePlayerResponse.fromJson(preGamePlayer_data);
    } else if (preGamePlayer_response.statusCode == 400) {
      throw ExceptionTokenExpired("Token expired");
    } else return PreGamePlayerResponse.fromJson({});
  }

  static Future<PreGameMatchResponse> getPreGameMatch(String matchId) async {
    final preGameMatch_api = "${ValorantEndpoints.GLZ_URL}/pregame/v1/matches/$matchId";
    final preGameMatch_response = await http.get(Uri.parse(preGameMatch_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (preGameMatch_response.statusCode == 200) {
      var preGameMatch_data = json.decode(preGameMatch_response.body);
      return PreGameMatchResponse.fromJson(preGameMatch_data);
    } else if (preGameMatch_response.statusCode == 400) {
      throw ExceptionTokenExpired("Token expired");
    } else {
      return PreGameMatchResponse.fromJson({});
    }
  }

  static Future<void> postPartyReadyState(String partyId, bool readyState) async {
    final partySetReady_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/members/${Globals.accountToken!.puuid}/setReady";
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

  static Future<String> postGeneratePartyCode(String partyId) async {
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

  static Future<String> postDeletePartyCode(String partyId) async {
    final deletePartyCode_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/invitecode";
    final deletePartyCode_response = await http.delete( Uri.parse(deletePartyCode_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (deletePartyCode_response.statusCode == 200) {
      return "******";
    } else {
      return "******";
    }
  }

  static Future<void> postJoinPartyByCode(String partyCode) async {
    final joinParty_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/players/joinbycode/$partyCode";
    final joinParty_headers = ValorantEndpoints.RIOT_HEADERS;
    final joinParty_response = await http.get(Uri.parse(joinParty_api), headers: joinParty_headers);

    if (joinParty_response.statusCode == 200) {
      return;
    }
  }

  static Future<void> postPartyAccessibility(String partyId, String partyStatus) async {
    final partyAccessibility_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/accessibility";
    final partyAccessibility_body = {"accessibility": partyStatus};
    final body = json.encode(partyAccessibility_body);

    final partyAccessibility_response = await http.post(Uri.parse(partyAccessibility_api), headers: ValorantEndpoints.RIOT_HEADERS, body: body);

    if (partyAccessibility_response.statusCode == 200) {
      return;
    }
  }

  static Future<void> postSetGameMode(String partyId, String gameMode) async {
    final setGameMode_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/queue";
    final setGameMode_headers = ValorantEndpoints.RIOT_HEADERS;
    final setGameMode_body = {'queueId': gameMode};
    final body = json.encode(setGameMode_body);

    final setGameMode_response = await http.post(Uri.parse(setGameMode_api), headers: setGameMode_headers, body: body);

    if (setGameMode_response.statusCode == 200) {
      return;
    }
  }

  static Future<void> postEntermatchmaking(String partyId) async {
    final joinMatchmaking_api = "${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/matchmaking/join";
    final joinMatchmaking_headers = ValorantEndpoints.RIOT_HEADERS;
    final joinMatchmaking_response = await http.post(Uri.parse(joinMatchmaking_api), headers: joinMatchmaking_headers);

    if (joinMatchmaking_response.statusCode == 200) {
      return;
    }
  }

  static Future<void> postLeavematchmaking(String partyId) async {
    final leaveMatchmaking_api ="${ValorantEndpoints.GLZ_URL}/parties/v1/parties/$partyId/matchmaking/leave";
    final leaveMatchmaking_headers = ValorantEndpoints.RIOT_HEADERS;
    final leaveMatchmaking_response = await http.post(Uri.parse(leaveMatchmaking_api), headers: leaveMatchmaking_headers);

    if (leaveMatchmaking_response.statusCode == 200) {
      return;
    }
  }

  static Future<void> postInstalockAgent() async{
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

  static Future<CurrentGamePlayerResponse> getCurrentGamePlayer() async {
    final currentGamePlayer_api = "${ValorantEndpoints.GLZ_URL}/core-game/v1/players/${Globals.accountToken!.puuid}";
    final currentGamePlayer_headers = ValorantEndpoints.RIOT_HEADERS;
    final currentGamePlayers_response = await http.get(Uri.parse(currentGamePlayer_api), headers: currentGamePlayer_headers);
    if (currentGamePlayers_response.statusCode == 200) {
      var data = json.decode(currentGamePlayers_response.body);
      return CurrentGamePlayerResponse.fromJson(data);
    } else {
      return CurrentGamePlayerResponse.fromJson({});
    }
  }

  static Future<CurrentGameMatchResponse> getCurrentGameMatch(String matchId) async {
    final currentGamePlayer_api = "${ValorantEndpoints.GLZ_URL}/core-game/v1/matches/$matchId";
    final currentGamePlayer_headers = ValorantEndpoints.RIOT_HEADERS;
    final currentGamePlayers_response = await http.get(Uri.parse(currentGamePlayer_api), headers: currentGamePlayer_headers);
    if (currentGamePlayers_response.statusCode == 200) {
      var data = json.decode(currentGamePlayers_response.body);
      return CurrentGameMatchResponse.fromJson(data);
    } else {
      return CurrentGameMatchResponse.fromJson({});
    }
  }

  static Future<MatchDetailsResponse> getMatchDetails(String matchId) async {
    final matchDetails_api = "${ValorantEndpoints.PD_URL}/match-details/v1/matches/$matchId";
    final matchDetails_response = await http.get(Uri.parse(matchDetails_api), headers: ValorantEndpoints.RIOT_HEADERS);

    if (matchDetails_response.statusCode == 200) {
      var data = json.decode(matchDetails_response.body);
      return MatchDetailsResponse.fromJson(data);
    } else {
      throw ExceptionFailedToGetCareer("Failed to get match career");
    }
  }

  static Future<CompetitiveUpdatesResponse> getCompetitiveUpdateData(String puuid) async {
    final competitiveUpdate_api = "${ValorantEndpoints.PD_URL}/mmr/v1/players/$puuid/competitiveupdates?queue=competitive";
    final competitiveUpdate_response = await http.get(Uri.parse(competitiveUpdate_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (competitiveUpdate_response.statusCode == 200) {
      var data = json.decode(competitiveUpdate_response.body);
      return CompetitiveUpdatesResponse.fromJson(data);
    } else if (competitiveUpdate_response.statusCode == 429) {
      throw ExceptionTooManyRequests("Too Many Requests");
    } else {
      throw ExceptionPlayerNotFound("player not found");
    }
  }
}