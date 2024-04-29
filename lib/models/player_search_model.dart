
class TargetPlayerMmr {
  String playername;
  String playerRank;
  String playerRankImage;
  String playerCard;
  String playerBanner;
  int playerRankedRating;
  int playerMmr;
  int playerLevel;

  TargetPlayerMmr({
    required this.playername,
    required this.playerRank,
    required this.playerRankImage,
    required this.playerCard,
    required this.playerBanner,
    required this.playerRankedRating,
    required this.playerMmr,
    required this.playerLevel,
  });
}

class TargetPlayerHistory {
  List<String> matchIds;
  List<String> mapName;
  List<int> rankedRatingEarned;
  List<String> rankAfterUpdate;
  List<String> mapBanner;
  List<String> agentPicture;

  TargetPlayerHistory({
    required this.matchIds,
    required this.mapName,
    required this.rankedRatingEarned,
    required this.rankAfterUpdate,
    required this.mapBanner,
    required this.agentPicture,
  });
}