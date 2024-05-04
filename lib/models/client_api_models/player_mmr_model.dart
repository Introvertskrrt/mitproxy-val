// docs: https://valapidocs.techchrism.me/endpoint/player-mmr
class PlayerMMRResponse {
  int version;
  String subject;
  bool newPlayerExperienceFinished;
  Map<String, QueueSkill> queueSkills;
  LatestCompetitiveUpdate latestCompetitiveUpdate;
  bool isLeaderboardAnonymized;
  bool isActRankBadgeHidden;

  PlayerMMRResponse({
    required this.version,
    required this.subject,
    required this.newPlayerExperienceFinished,
    required this.queueSkills,
    required this.latestCompetitiveUpdate,
    required this.isLeaderboardAnonymized,
    required this.isActRankBadgeHidden,
  });

  factory PlayerMMRResponse.fromJson(Map<String, dynamic> json) {
    return PlayerMMRResponse(
      version: json['Version'] ?? 0,
      subject: json['Subject'] ?? '',
      newPlayerExperienceFinished: json['NewPlayerExperienceFinished'] ?? false,
      queueSkills: (json['QueueSkills'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, QueueSkill.fromJson(value))) ?? {},
      latestCompetitiveUpdate: LatestCompetitiveUpdate.fromJson(json['LatestCompetitiveUpdate']),
      isLeaderboardAnonymized: json['IsLeaderboardAnonymized'] ?? false,
      isActRankBadgeHidden: json['IsActRankBadgeHidden'] ?? false,
    );
  }
}

class QueueSkill {
  int totalGamesNeededForRating;
  int totalGamesNeededForLeaderboard;
  int currentSeasonGamesNeededForRating;
  Map<String, SeasonalInfoBySeasonID> seasonalInfoBySeasonID;

  QueueSkill({
    required this.totalGamesNeededForRating,
    required this.totalGamesNeededForLeaderboard,
    required this.currentSeasonGamesNeededForRating,
    required this.seasonalInfoBySeasonID,
  });

  factory QueueSkill.fromJson(Map<String, dynamic> json) {
    return QueueSkill(
      totalGamesNeededForRating: json['TotalGamesNeededForRating'] ?? 0,
      totalGamesNeededForLeaderboard: json['TotalGamesNeededForLeaderboard'] ?? 0,
      currentSeasonGamesNeededForRating: json['CurrentSeasonGamesNeededForRating'] ?? 0,
      seasonalInfoBySeasonID: (json['SeasonalInfoBySeasonID'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, SeasonalInfoBySeasonID.fromJson(value))) ?? {},
    );
  }
}

class SeasonalInfoBySeasonID {
  String seasonID;
  int numberOfWins;
  int numberOfWinsWithPlacements;
  int numberOfGames;
  int rank;
  int capstoneWins;
  int leaderboardRank;
  int competitiveTier;
  int rankedRating;
  Map<String, int>? winsByTier;
  int gamesNeededForRating;
  int totalWinsNeededForRank;

  SeasonalInfoBySeasonID({
    required this.seasonID,
    required this.numberOfWins,
    required this.numberOfWinsWithPlacements,
    required this.numberOfGames,
    required this.rank,
    required this.capstoneWins,
    required this.leaderboardRank,
    required this.competitiveTier,
    required this.rankedRating,
    this.winsByTier,
    required this.gamesNeededForRating,
    required this.totalWinsNeededForRank,
  });

  factory SeasonalInfoBySeasonID.fromJson(Map<String, dynamic> json) {
    return SeasonalInfoBySeasonID(
      seasonID: json['SeasonID'] ?? '',
      numberOfWins: json['NumberOfWins'] ?? 0,
      numberOfWinsWithPlacements: json['NumberOfWinsWithPlacements'] ?? 0,
      numberOfGames: json['NumberOfGames'] ?? 0,
      rank: json['Rank'] ?? 0,
      capstoneWins: json['CapstoneWins'] ?? 0,
      leaderboardRank: json['LeaderboardRank'] ?? 0,
      competitiveTier: json['CompetitiveTier'] ?? 0,
      rankedRating: json['RankedRating'] ?? 0,
      winsByTier: (json['WinsByTier'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, value as int)) ?? {},
      gamesNeededForRating: json['GamesNeededForRating'] ?? 0,
      totalWinsNeededForRank: json['TotalWinsNeededForRank'] ?? 0,
    );
  }
}

class LatestCompetitiveUpdate {
  String matchID;
  String mapID;
  String seasonID;
  int matchStartTime;
  int tierAfterUpdate;
  int tierBeforeUpdate;
  int rankedRatingAfterUpdate;
  int rankedRatingBeforeUpdate;
  int rankedRatingEarned;
  int rankedRatingPerformanceBonus;
  String competitiveMovement;
  int afkPenalty;

  LatestCompetitiveUpdate({
    required this.matchID,
    required this.mapID,
    required this.seasonID,
    required this.matchStartTime,
    required this.tierAfterUpdate,
    required this.tierBeforeUpdate,
    required this.rankedRatingAfterUpdate,
    required this.rankedRatingBeforeUpdate,
    required this.rankedRatingEarned,
    required this.rankedRatingPerformanceBonus,
    required this.competitiveMovement,
    required this.afkPenalty,
  });

  factory LatestCompetitiveUpdate.fromJson(Map<String, dynamic> json) {
    return LatestCompetitiveUpdate(
      matchID: json['MatchID'] ?? '',
      mapID: json['MapID'] ?? '',
      seasonID: json['SeasonID'] ?? '',
      matchStartTime: json['MatchStartTime'] ?? 0,
      tierAfterUpdate: json['TierAfterUpdate'] ?? 0,
      tierBeforeUpdate: json['TierBeforeUpdate'] ?? 0,
      rankedRatingAfterUpdate: json['RankedRatingAfterUpdate'] ?? 0,
      rankedRatingBeforeUpdate: json['RankedRatingBeforeUpdate'] ?? 0,
      rankedRatingEarned: json['RankedRatingEarned'] ?? 0,
      rankedRatingPerformanceBonus: json['RankedRatingPerformanceBonus'] ?? 0,
      competitiveMovement: json['CompetitiveMovement'] ?? '',
      afkPenalty: json['AFKPenalty'] ?? 0,
    );
  }
}