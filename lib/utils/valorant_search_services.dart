
// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mitproxy_val/models/player_search_model.dart';
import 'dart:convert';
import 'package:mitproxy_val/utils/cache.dart';
import 'package:mitproxy_val/utils/exceptions.dart';
import 'package:mitproxy_val/utils/valorant_endpoints.dart';


class ValorantSearchServices {
  Future<dynamic> getMatchHistory(String puuid) async {
    
  }
  
  Future<void> getPlayerData(String name, String tag) async {
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
    final byName_api = "https://api.henrikdev.xyz/valorant/v1/account/$name/$tag";
    final byName_response = await http.get(Uri.parse(byName_api));
    if (byName_response.statusCode == 200) {
      var player_data = json.decode(byName_response.body);
      
      playerUuid = player_data['data']['puuid'];
      playerName = player_data['data']['name'] + ' #' + player_data['data']['tag'];
      playerCard = player_data['data']['card']['small'] ?? "https://media.valorant-api.com/playercards/9fb348bc-41a0-91ad-8a3e-818035c4e561/displayicon.png";
      playerLevel = player_data['data']['account_level'];
      playerBanner = player_data['data']['card']['wide'];

      final playerMmr_api = "https://api.henrikdev.xyz/valorant/v1/by-puuid/mmr/${Cache.accountToken!.shard}/$playerUuid";
      final playermmr_response = await http.get(Uri.parse(playerMmr_api));
      
      if (playermmr_response.statusCode == 200) {
        var playerMmr_data = json.decode(playermmr_response.body);
        playerRank = playerMmr_data['data']['currenttierpatched'];
        playerRankImage = playerMmr_data['data']['images']['large'];
        playerMmr = playerMmr_data['data']['elo'];
        playerRankedRating = playerMmr_data['data']['ranking_in_tier'];

        Cache.targetPlayerMmr = TargetPlayerMmr(
          playername: playerName, 
          playerRank: playerRank, 
          playerRankImage: playerRankImage, 
          playerCard: playerCard, 
          playerBanner: playerBanner,
          playerRankedRating: playerRankedRating, 
          playerMmr: playerMmr, 
          playerLevel: playerLevel,
        );
      }
    }
    else if (byName_response.statusCode == 404){
      throw ExceptionPlayerNotFound("Player not found");
    }
    
    List<String> matchIds = [];
    List<String> mapId = [];

    List<int> rankedRatingEarned = [];
    List<String> rankAfterUpdate = [];
    List<String> mapName = [];
    List<String> mapBanner = [];
    List<String> agentPicture = [];

    // get player matches stats
    dynamic playerMatchHistory_data;
    final competitiveUpdate_api = "${ValorantEndpoints.PD_URL}/mmr/v1/players/$playerUuid/competitiveupdates?queue=competitive";
    final competitiveUpdate_response = await http.get(Uri.parse(competitiveUpdate_api), headers: ValorantEndpoints.RIOT_HEADERS);
    if (competitiveUpdate_response.statusCode == 200) {
      playerMatchHistory_data = json.decode(competitiveUpdate_response.body);
    } else if (competitiveUpdate_response.statusCode == 429) {
      throw ExceptionTooManyRequests("Too Many Requests");
    }
    var matches = playerMatchHistory_data['Matches'];

    List<int> rankTier = [];
    for (var match in matches) {
      matchIds.add(match['MatchID']);
      rankedRatingEarned.add(match['RankedRatingEarned']);
      rankTier.add(match['TierAfterUpdate']);
      mapId.add(match['MapID']);
    }

    // translate mapId
    for (var x in mapId) {
      const mapData_api = "https://valorant-api.com/v1/maps";
      final mapData_response = await http.get(Uri.parse(mapData_api));
      if (mapData_response.statusCode == 200) {
        var map_data = json.decode(mapData_response.body);
        var map_list = map_data['data'];
        for (var map in map_list) {
          if (map['mapUrl'] == x) {
            mapName.add(map['displayName']);
            mapBanner.add(map['listViewIcon']);
          }
        }
      }
    }

    // translate competitive tier to rank image
    const competitiveTier_api = "https://valorant-api.com/v1/competitivetiers";
    final competitiveTier_response = await http.get(Uri.parse(competitiveTier_api));
    if (competitiveTier_response.statusCode == 200) {
      var competitiveTier_data = json.decode(competitiveTier_response.body);
      List<dynamic> competitiveTier_list = competitiveTier_data['data'];
      var latestCompetitiveTier = competitiveTier_list.last;

      for (var x in rankTier) {
        for (var tier in latestCompetitiveTier['tiers']) {
          if (tier['tier'] == x) {
            rankAfterUpdate.add(tier['largeIcon']);
          }
        }
      }
    }

    // get agent image for each matches
    for (var matchId in matchIds) {
      final matchDetails_api = "${ValorantEndpoints.PD_URL}/match-details/v1/matches/$matchId";
      final matchDetails_response = await http.get(Uri.parse(matchDetails_api), headers: ValorantEndpoints.RIOT_HEADERS);
      if (matchDetails_response.statusCode == 200) {
        var matchDetails_data = json.decode(matchDetails_response.body);

        for (var player in matchDetails_data['players']) {
          if (player['subject'] == playerUuid) {
            agentPicture.add("https://media.valorant-api.com/agents/${player['characterId']}/displayicon.png");
          }
        }
      }
    }

    Cache.targetPlayerHistory = TargetPlayerHistory(
      matchIds: matchIds, 
      mapName: mapName, 
      rankedRatingEarned: rankedRatingEarned, 
      rankAfterUpdate: rankAfterUpdate, 
      mapBanner: mapBanner,
      agentPicture: agentPicture,
    );

    
  }
}