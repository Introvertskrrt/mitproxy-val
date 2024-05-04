// docs: https://valapidocs.techchrism.me/endpoint/current-game-match
class CurrentGameMatchResponse {
  String matchID;
  int version;
  String state;
  String mapID;
  String modeID;
  String provisioningFlow;
  String gamePodID;
  String allMUCName;
  String teamMUCName;
  String teamVoiceID;
  String teamMatchToken;
  bool isReconnectable;
  ConnectionDetails connectionDetails;
  dynamic postGameDetails; // Change type if necessary
  List<Player> players;
  dynamic matchmakingData; // Change type if necessary

  CurrentGameMatchResponse({
    required this.matchID,
    required this.version,
    required this.state,
    required this.mapID,
    required this.modeID,
    required this.provisioningFlow,
    required this.gamePodID,
    required this.allMUCName,
    required this.teamMUCName,
    required this.teamVoiceID,
    required this.teamMatchToken,
    required this.isReconnectable,
    required this.connectionDetails,
    required this.postGameDetails,
    required this.players,
    required this.matchmakingData,
  });

  factory CurrentGameMatchResponse.fromJson(Map<String, dynamic> json) {
    return CurrentGameMatchResponse(
      matchID: json['MatchID'],
      version: json['Version'],
      state: json['State'],
      mapID: json['MapID'],
      modeID: json['ModeID'],
      provisioningFlow: json['ProvisioningFlow'],
      gamePodID: json['GamePodID'],
      allMUCName: json['AllMUCName'],
      teamMUCName: json['TeamMUCName'],
      teamVoiceID: json['TeamVoiceID'],
      teamMatchToken: json['TeamMatchToken'],
      isReconnectable: json['IsReconnectable'],
      connectionDetails: ConnectionDetails.fromJson(json['ConnectionDetails']),
      postGameDetails: json['PostGameDetails'],
      players: List<Player>.from(json['Players'].map((x) => Player.fromJson(x))),
      matchmakingData: json['MatchmakingData'],
    );
  }
}

class ConnectionDetails {
  List<String> gameServerHosts;
  String gameServerHost;
  int gameServerPort;
  int gameServerObfuscatedIP;
  int gameClientHash;
  String playerKey;

  ConnectionDetails({
    required this.gameServerHosts,
    required this.gameServerHost,
    required this.gameServerPort,
    required this.gameServerObfuscatedIP,
    required this.gameClientHash,
    required this.playerKey,
  });

  factory ConnectionDetails.fromJson(Map<String, dynamic> json) {
    return ConnectionDetails(
      gameServerHosts: List<String>.from(json['GameServerHosts']),
      gameServerHost: json['GameServerHost'],
      gameServerPort: json['GameServerPort'],
      gameServerObfuscatedIP: json['GameServerObfuscatedIP'],
      gameClientHash: json['GameClientHash'],
      playerKey: json['PlayerKey'],
    );
  }
}

class Player {
  String subject;
  String teamID;
  String characterID;
  PlayerIdentity playerIdentity;
  SeasonalBadgeInfo seasonalBadgeInfo;
  bool isCoach;
  bool isAssociated;

  Player({
    required this.subject,
    required this.teamID,
    required this.characterID,
    required this.playerIdentity,
    required this.seasonalBadgeInfo,
    required this.isCoach,
    required this.isAssociated,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      subject: json['Subject'],
      teamID: json['TeamID'],
      characterID: json['CharacterID'],
      playerIdentity: PlayerIdentity.fromJson(json['PlayerIdentity']),
      seasonalBadgeInfo: SeasonalBadgeInfo.fromJson(json['SeasonalBadgeInfo']),
      isCoach: json['IsCoach'],
      isAssociated: json['IsAssociated'],
    );
  }
}

class PlayerIdentity {
  String subject;
  String playerCardID;
  String playerTitleID;
  int accountLevel;
  String preferredLevelBorderID;
  bool incognito;
  bool hideAccountLevel;

  PlayerIdentity({
    required this.subject,
    required this.playerCardID,
    required this.playerTitleID,
    required this.accountLevel,
    required this.preferredLevelBorderID,
    required this.incognito,
    required this.hideAccountLevel,
  });

  factory PlayerIdentity.fromJson(Map<String, dynamic> json) {
    return PlayerIdentity(
      subject: json['Subject'],
      playerCardID: json['PlayerCardID'],
      playerTitleID: json['PlayerTitleID'],
      accountLevel: json['AccountLevel'],
      preferredLevelBorderID: json['PreferredLevelBorderID'],
      incognito: json['Incognito'],
      hideAccountLevel: json['HideAccountLevel'],
    );
  }
}

class SeasonalBadgeInfo {
  String seasonID;
  int numberOfWins;
  dynamic winsByTier; // Change type if necessary
  int rank;
  int leaderboardRank;

  SeasonalBadgeInfo({
    required this.seasonID,
    required this.numberOfWins,
    required this.winsByTier,
    required this.rank,
    required this.leaderboardRank,
  });

  factory SeasonalBadgeInfo.fromJson(Map<String, dynamic> json) {
    return SeasonalBadgeInfo(
      seasonID: json['SeasonID'],
      numberOfWins: json['NumberOfWins'],
      winsByTier: json['WinsByTier'],
      rank: json['Rank'],
      leaderboardRank: json['LeaderboardRank'],
    );
  }
}
