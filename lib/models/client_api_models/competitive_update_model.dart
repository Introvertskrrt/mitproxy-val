// docs: https://valapidocs.techchrism.me/endpoint/competitive-updates
class CompetitiveUpdatesResponse {
  int version;
  String subject;
  List<Match> matches;

  CompetitiveUpdatesResponse({
    required this.version,
    required this.subject,
    required this.matches,
  });

  factory CompetitiveUpdatesResponse.fromJson(Map<String, dynamic> json) {
    return CompetitiveUpdatesResponse(
      version: json['Version'],
      subject: json['Subject'],
      matches: List<Match>.from(json['Matches'].map((x) => Match.fromJson(x))),
    );
  }
}

class Match {
  String matchId;
  String mapId;
  String seasonId;
  int matchStartTime;
  int tierAfterUpdate;
  int tierBeforeUpdate;
  int rankedRatingAfterUpdate;
  int rankedRatingBeforeUpdate;
  int rankedRatingEarned;
  int rankedRatingPerformanceBonus;
  String competitiveMovement;
  int afkPenalty;

  Match({
    required this.matchId,
    required this.mapId,
    required this.seasonId,
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

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      matchId: json['MatchID'],
      mapId: json['MapID'],
      seasonId: json['SeasonID'],
      matchStartTime: json['MatchStartTime'],
      tierAfterUpdate: json['TierAfterUpdate'],
      tierBeforeUpdate: json['TierBeforeUpdate'],
      rankedRatingAfterUpdate: json['RankedRatingAfterUpdate'],
      rankedRatingBeforeUpdate: json['RankedRatingBeforeUpdate'],
      rankedRatingEarned: json['RankedRatingEarned'],
      rankedRatingPerformanceBonus: json['RankedRatingPerformanceBonus'],
      competitiveMovement: json['CompetitiveMovement'],
      afkPenalty: json['AFKPenalty'],
    );
  }
}
