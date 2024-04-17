import 'package:flutter/widgets.dart';

class AccountToken {
  String accessTokenType;
  String entitlementsToken;
  String authToken;
  String shard;
  String puuid;
  String clientVersion;
  String clientPlatform;

  AccountToken({
    required this.accessTokenType,
    required this.entitlementsToken,
    required this.authToken,
    required this.shard,
    required this.puuid,
    required this.clientVersion,
    required this.clientPlatform,
  });
}

class PlayerProfile {
  final String playername;
  final int valorantPoint;
  final int radianite;
  final int kingdomCredits;
  final int playerXp;
  final int playerLevels;
  final int playerMmr;
  final String playerCardId;
  final String playerTitleId;
  final List<String> missionNames;
  final List<int> missionXpRewards;
  final List<int> missionProgress;
  final List<int> missionProgressToComplete;
  final List<String> missionType;
  final String currentCompetitiveRank;
  final String currentCompetitiveSeason;
  final String currentRankImage;
  final Color rankColor;

  PlayerProfile({
    required this.missionNames,
    required this.missionXpRewards,
    required this.missionProgress,
    required this.missionProgressToComplete,
    required this.missionType,
    required this.valorantPoint,
    required this.playername,
    required this.radianite,
    required this.kingdomCredits,
    required this.playerXp,
    required this.playerLevels,
    required this.playerMmr,
    required this.playerCardId,
    required this.playerTitleId,
    required this.currentCompetitiveRank,
    required this.currentCompetitiveSeason,
    required this.currentRankImage,
    required this.rankColor,
  });
}
