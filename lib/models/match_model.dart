class CurrentMatch{
  String mapBanner;
  String gameMode;

  CurrentMatch({
    required this.mapBanner,
    required this.gameMode,
  });
}

class AllyTeam{
  String allyTeamId;
  List<String> allyPlayerNames;
  List<String> allyAgentImages;
  List<bool> allySelectionStates;
  List<String> allyRanks;

  AllyTeam({
    required this.allyTeamId,
    required this.allyPlayerNames,
    required this.allyAgentImages,
    required this.allySelectionStates,
    required this.allyRanks,
  });
}

class EnemyTeam{
  String enemyTeamId;
  List<String> enemyPlayerNames;
  List<String> enemyAgentImages;
  List<bool> enemySelectionStates;
  List<String> enemyRanks;

  EnemyTeam({
    required this.enemyTeamId,
    required this.enemyPlayerNames,
    required this.enemyAgentImages,
    required this.enemySelectionStates,
    required this.enemyRanks,
  });
}