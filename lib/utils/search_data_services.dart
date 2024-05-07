
// ignore_for_file: non_constant_identifier_names, constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:http/http.dart' as http;
import 'package:mitproxy_val/models/assets_api_models/competitive_tiers_model.dart';
import 'package:mitproxy_val/models/assets_api_models/map_model.dart';
import 'package:mitproxy_val/models/client_api_models/competitive_update_model.dart';
import 'package:mitproxy_val/models/client_api_models/match_details_model.dart';
import 'package:mitproxy_val/models/client_api_models/player_mmr_model.dart';
import 'package:mitproxy_val/models/personal_models/player_search_model.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'dart:convert';
import 'package:mitproxy_val/utils/globals.dart';
import 'package:mitproxy_val/utils/mmr_calculator.dart';
import 'package:mitproxy_val/utils/valorant_asset_services.dart';
import 'package:mitproxy_val/utils/valorant_client_services.dart';


class SearchServices {
  Future<void> getPlayerMatchHistory(String name, String tag) async {
    String playerUuid = '';
    String playerName = '';
    String playerCard = '';
    String playerBanner = '';
    int playerLevel = 0;

    String playerRank = '';
    String playerRankImage = '';
    int playerMmr = 0;
    int playerRankedRating = 0;

    // get player mmr info
    final valorant_tracker_api = "https://api.tracker.gg/api/v2/valorant/standard/matches/riot/$name%23$tag?type=competitive&season=&agent=all&map=all";
    final valorant_tracker_response = await http.get(Uri.parse(valorant_tracker_api));
    if (valorant_tracker_response.statusCode == 200) {
      var tracker_data = json.decode(valorant_tracker_response.body);
      var matches = tracker_data['data']['matches'];

      // use match id to get player's data from client api
      var matchId = matches[0]['attributes']['id'];
      
      String searchedPlayerId = ""; 
      MatchDetailsResponse matchDetailsResponse = await ValorantClientServices.getMatchDetails(matchId);
      var all_players = matchDetailsResponse.players;
      for (var player in all_players!) {
        if (player.gameName == name) {

          // take the player id (puuid)
          searchedPlayerId = player.subject!;

          playerUuid = player.subject!;
          playerName = '${player.gameName!} #${player.tagLine!}';
          playerCard = "https://media.valorant-api.com/playercards/${player.playerCard}/displayicon.png";
          playerLevel = player.accountLevel!;
          playerBanner = "https://media.valorant-api.com/playercards/${player.playerCard}/wideart.png";
        }
      }

      PlayerMMRResponse playerMMRResponse = await ValorantClientServices.getPlayerMMRResponse(searchedPlayerId);
      var _currentCompetitiveSeason = playerMMRResponse.latestCompetitiveUpdate.seasonID;
      var competitiveTier = playerMMRResponse.queueSkills['competitive']?.seasonalInfoBySeasonID[_currentCompetitiveSeason]?.competitiveTier ?? 0;
      var currentRR = playerMMRResponse.queueSkills['competitive']?.seasonalInfoBySeasonID[_currentCompetitiveSeason]?.rankedRating ?? 0;

      CompetitiveTiersResponse competitiveTiersResponse = await ValorantAssetServices.getCompetitiveTiersData();
      var competitiveTier_list = competitiveTiersResponse.data;
      var latestCompetitiveTier = competitiveTier_list.last;
      var tierList = latestCompetitiveTier.tiers;

      for (var tier in tierList) {
        if (tier.tier == competitiveTier) {
          playerRank = tier.tierName;
          playerRankImage = tier.largeIcon!;
          playerMmr = await MMRCalculator.calculateMmr(playerRank, currentRR);
          playerRankedRating = currentRR;
        }
      }
    } else {
      throw ExceptionPlayerNotFound("Player not found");
    }

    // Player stats
    Globals.targetPlayerMmr = TargetPlayerMmr(
      playername: playerName, 
      playerRank: playerRank, 
      playerRankImage: playerRankImage, 
      playerCard: playerCard, 
      playerBanner: playerBanner,
      playerRankedRating: playerRankedRating, 
      playerMmr: playerMmr, 
      playerLevel: playerLevel,
    );
    
    List<String> matchIds = [];
    List<String> mapId = [];

    List<int> rankedRatingEarned = [];
    List<String> rankAfterUpdate = [];
    List<String> mapName = [];
    List<String> mapBanner = [];
    List<String> agentPicture = [];

    // get player matches stats
    CompetitiveUpdatesResponse competitiveUpdatesResponse = await ValorantClientServices.getCompetitiveUpdateData(playerUuid);
    var matches = competitiveUpdatesResponse.matches;

    List<int> rankTier = [];
    for (var match in matches) {
      matchIds.add(match.matchId);
      rankedRatingEarned.add(match.rankedRatingEarned);
      rankTier.add(match.tierAfterUpdate);
      mapId.add(match.mapId);
    }

    // translate mapId
    for (var mapUrl in mapId) {
      MapsResponse mapsResponse = await ValorantAssetServices.getMapData();
      var map_list = mapsResponse.data;

      for (var map in map_list) {
        if (map.mapUrl == mapUrl) {
          mapName.add(map.displayName);
          mapBanner.add(map.listViewIcon);
        }
      }
    }

    // translate competitive tier to rank image
    CompetitiveTiersResponse competitiveTier = await ValorantAssetServices.getCompetitiveTiersData();
    var competitiveTier_list = competitiveTier.data;
    var latestCompetitiveTier = competitiveTier_list.last;

    for (var x in rankTier) {
      for (var tier in latestCompetitiveTier.tiers) {
        if (tier.tier == x) {
          rankAfterUpdate.add(tier.largeIcon ?? "");
        }
      }
    }

    // get agent image for each matches
    for (var matchId in matchIds) {
      MatchDetailsResponse matchDetailsResponse = await ValorantClientServices.getMatchDetails(matchId);
      var all_players = matchDetailsResponse.players;

      for (var player in all_players!) {
        if (player.subject == playerUuid) {
          agentPicture.add("https://media.valorant-api.com/agents/${player.characterId}/displayicon.png");
        }
      }
    }

    // Match history
    Globals.targetPlayerHistory = TargetPlayerHistory(
      matchIds: matchIds, 
      mapName: mapName, 
      rankedRatingEarned: rankedRatingEarned, 
      rankAfterUpdate: rankAfterUpdate, 
      mapBanner: mapBanner,
      agentPicture: agentPicture,
    );
  }

  
}