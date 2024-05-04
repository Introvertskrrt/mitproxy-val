class PreGameMatchResponse {
  String id;
  int version;
  List<Team> teams;
  Team? allyTeam;
  Team? enemyTeam;
  List<dynamic> observerSubjects;
  List<dynamic> matchCoaches;
  int enemyTeamSize;
  int enemyTeamLockCount;
  String pregameState;
  String lastUpdated;
  String mapID;
  List<dynamic> mapSelectPool;
  List<dynamic> bannedMapIDs;
  dynamic castedVotes;
  List<dynamic> mapSelectSteps;
  int mapSelectStep;
  String team1;
  String gamePodID;
  String mode;
  String voiceSessionID;
  String mucName;
  String teamMatchToken;
  String queueID;
  String provisioningFlowID;
  bool isRanked;
  int phaseTimeRemainingNS;
  int stepTimeRemainingNS;
  bool altModesFlagADA;
  dynamic tournamentMetadata;
  dynamic rosterMetadata;

  PreGameMatchResponse({
    required this.id,
    required this.version,
    required this.teams,
    this.allyTeam,
    this.enemyTeam,
    required this.observerSubjects,
    required this.matchCoaches,
    required this.enemyTeamSize,
    required this.enemyTeamLockCount,
    required this.pregameState,
    required this.lastUpdated,
    required this.mapID,
    required this.mapSelectPool,
    required this.bannedMapIDs,
    required this.castedVotes,
    required this.mapSelectSteps,
    required this.mapSelectStep,
    required this.team1,
    required this.gamePodID,
    required this.mode,
    required this.voiceSessionID,
    required this.mucName,
    required this.teamMatchToken,
    required this.queueID,
    required this.provisioningFlowID,
    required this.isRanked,
    required this.phaseTimeRemainingNS,
    required this.stepTimeRemainingNS,
    required this.altModesFlagADA,
    required this.tournamentMetadata,
    required this.rosterMetadata,
  });

  factory PreGameMatchResponse.fromJson(Map<String, dynamic> json) {
    return PreGameMatchResponse(
      id: json['ID'] ?? '',
      version: json['Version'] ?? 0,
      teams: (json['Teams'] as List<dynamic>?)
          ?.map((team) => Team.fromJson(team))
          .toList() ??
          [],
      allyTeam: json['AllyTeam'] != null ? Team.fromJson(json['AllyTeam']) : null,
      enemyTeam: json['EnemyTeam'] != null ? Team.fromJson(json['EnemyTeam']) : null,
      observerSubjects: json['ObserverSubjects'] ?? [],
      matchCoaches: json['MatchCoaches'] ?? [],
      enemyTeamSize: json['EnemyTeamSize'] ?? 0,
      enemyTeamLockCount: json['EnemyTeamLockCount'] ?? 0,
      pregameState: json['PregameState'] ?? '',
      lastUpdated: json['LastUpdated'] ?? '',
      mapID: json['MapID'] ?? '',
      mapSelectPool: json['MapSelectPool'] ?? [],
      bannedMapIDs: json['BannedMapIDs'] ?? [],
      castedVotes: json['CastedVotes'],
      mapSelectSteps: json['MapSelectSteps'] ?? [],
      mapSelectStep: json['MapSelectStep'] ?? 0,
      team1: json['Team1'] ?? '',
      gamePodID: json['GamePodID'] ?? '',
      mode: json['Mode'] ?? '',
      voiceSessionID: json['VoiceSessionID'] ?? '',
      mucName: json['MUCName'] ?? '',
      teamMatchToken: json['TeamMatchToken'] ?? '',
      queueID: json['QueueID'] ?? '',
      provisioningFlowID: json['ProvisioningFlowID'] ?? '',
      isRanked: json['IsRanked'] ?? false,
      phaseTimeRemainingNS: json['PhaseTimeRemainingNS'] ?? 0,
      stepTimeRemainingNS: json['StepTimeRemainingNS'] ?? 0,
      altModesFlagADA: json['AltModesFlagADA'] ?? false,
      tournamentMetadata: json['TournamentMetadata'],
      rosterMetadata: json['RosterMetadata'],
    );
  }
}

class Team {
  String teamID;
  List<Player> players;

  Team({
    required this.teamID,
    required this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamID: json['TeamID'] ?? '',
      players: (json['Players'] as List<dynamic>?)
          ?.map((player) => Player.fromJson(player))
          .toList() ??
          [],
    );
  }
}

class Player {
  String subject;
  String characterID;
  String characterSelectionState;
  String pregamePlayerState;
  int competitiveTier;
  PlayerIdentity playerIdentity;
  bool isCaptain;

  Player({
    required this.subject,
    required this.characterID,
    required this.characterSelectionState,
    required this.pregamePlayerState,
    required this.competitiveTier,
    required this.playerIdentity,
    required this.isCaptain,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      subject: json['Subject'] ?? '',
      characterID: json['CharacterID'] ?? '',
      characterSelectionState: json['CharacterSelectionState'] ?? '',
      pregamePlayerState: json['PregamePlayerState'] ?? '',
      competitiveTier: json['CompetitiveTier'] ?? 0,
      playerIdentity: PlayerIdentity.fromJson(json['PlayerIdentity']),
      isCaptain: json['IsCaptain'] ?? false,
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
      subject: json['Subject'] ?? '',
      playerCardID: json['PlayerCardID'] ?? '',
      playerTitleID: json['PlayerTitleID'] ?? '',
      accountLevel: json['AccountLevel'] ?? 0,
      preferredLevelBorderID: json['PreferredLevelBorderID'] ?? '',
      incognito: json['Incognito'] ?? false,
      hideAccountLevel: json['HideAccountLevel'] ?? false,
    );
  }
}
