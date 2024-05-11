// docs: https://valapidocs.techchrism.me/endpoint/party
class PartyResponse {
  String id;
  String mucName;
  String voiceRoomID;
  int version;
  String clientVersion;
  List<PartyMember> members;
  String state;
  String previousState;
  String stateTransitionReason;
  String accessibility;
  CustomGameData customGameData;
  MatchmakingData matchmakingData;
  List<dynamic>? invites;
  List<dynamic>? requests;
  String queueEntryTime;
  ErrorNotification errorNotification;
  int restrictedSeconds;
  List<String> eligibleQueues;
  List<String> queueIneligibilities;
  CheatData cheatData;
  List<dynamic>? xpBonuses;
  String inviteCode;

  PartyResponse({
    required this.id,
    required this.mucName,
    required this.voiceRoomID,
    required this.version,
    required this.clientVersion,
    required this.members,
    required this.state,
    required this.previousState,
    required this.stateTransitionReason,
    required this.accessibility,
    required this.customGameData,
    required this.matchmakingData,
    this.invites,
    this.requests,
    required this.queueEntryTime,
    required this.errorNotification,
    required this.restrictedSeconds,
    required this.eligibleQueues,
    required this.queueIneligibilities,
    required this.cheatData,
    this.xpBonuses,
    required this.inviteCode,
  });

  factory PartyResponse.fromJson(Map<String, dynamic> json) {
    return PartyResponse(
      id: json['ID'] ?? '',
      mucName: json['MUCName'] ?? '',
      voiceRoomID: json['VoiceRoomID'] ?? '',
      version: json['Version'] ?? 0,
      clientVersion: json['ClientVersion'] ?? '',
      members: (json['Members'] as List<dynamic>?)
          ?.map((item) => PartyMember.fromJson(item))
          .toList() ?? [],
      state: json['State'] ?? '',
      previousState: json['PreviousState'] ?? '',
      stateTransitionReason: json['StateTransitionReason'] ?? '',
      accessibility: json['Accessibility'] ?? '',
      customGameData: CustomGameData.fromJson(json['CustomGameData'] ?? {}),
      matchmakingData: MatchmakingData.fromJson(json['MatchmakingData'] ?? {}),
      invites: json['Invites'] ?? [],
      requests: json['Requests'] ?? "",
      queueEntryTime: json['QueueEntryTime'] ?? '',
      errorNotification: ErrorNotification.fromJson(json['ErrorNotification'] ?? {}),
      restrictedSeconds: json['RestrictedSeconds'] ?? 0,
      eligibleQueues: List<String>.from(json['EligibleQueues'] ?? []),
      queueIneligibilities: List<String>.from(json['QueueIneligibilities'] ?? []),
      cheatData: CheatData.fromJson(json['CheatData'] ?? {}),
      xpBonuses: json['XPBonuses'],
      inviteCode: json['InviteCode'] ?? '',
    );
  }
}

class PartyMember {
  String subject;
  int competitiveTier;
  PlayerIdentity playerIdentity;
  List<Ping> pings;
  bool isReady;
  bool isModerator;
  bool useBroadcastHUD;
  String platformType;

  PartyMember({
    required this.subject,
    required this.competitiveTier,
    required this.playerIdentity,
    required this.pings,
    required this.isReady,
    required this.isModerator,
    required this.useBroadcastHUD,
    required this.platformType,
  });

  factory PartyMember.fromJson(Map<String, dynamic> json) {
    return PartyMember(
      subject: json['Subject'] ?? '',
      competitiveTier: json['CompetitiveTier'] ?? 0,
      playerIdentity: PlayerIdentity.fromJson(json['PlayerIdentity'] ?? {}),
      pings: (json['Pings'] as List<dynamic>?)
          ?.map((item) => Ping.fromJson(item))
          .toList() ?? [],
      isReady: json['IsReady'] ?? false,
      isModerator: json['IsModerator'] ?? false,
      useBroadcastHUD: json['UseBroadcastHUD'] ?? false,
      platformType: json['PlatformType'] ?? '',
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

class Ping {
  int ping;
  String gamePodID;

  Ping({
    required this.ping,
    required this.gamePodID,
  });

  factory Ping.fromJson(Map<String, dynamic> json) {
    return Ping(
      ping: json['Ping'] ?? 0,
      gamePodID: json['GamePodID'] ?? '',
    );
  }
}

class CustomGameData {
  GameSettings settings;
  Membership membership;
  int maxPartySize;
  bool autobalanceEnabled;
  int autobalanceMinPlayers;
  bool hasRecoveryData;

  CustomGameData({
    required this.settings,
    required this.membership,
    required this.maxPartySize,
    required this.autobalanceEnabled,
    required this.autobalanceMinPlayers,
    required this.hasRecoveryData,
  });

  factory CustomGameData.fromJson(Map<String, dynamic> json) {
    return CustomGameData(
      settings: GameSettings.fromJson(json['Settings'] ?? {}),
      membership: Membership.fromJson(json['Membership'] ?? {}),
      maxPartySize: json['MaxPartySize'] ?? 0,
      autobalanceEnabled: json['AutobalanceEnabled'] ?? false,
      autobalanceMinPlayers: json['AutobalanceMinPlayers'] ?? 0,
      hasRecoveryData: json['HasRecoveryData'] ?? false,
    );
  }
}

class GameSettings {
  String map;
  String mode;
  bool useBots;
  String gamePod;
  GameRules? gameRules;

  GameSettings({
    required this.map,
    required this.mode,
    required this.useBots,
    required this.gamePod,
    this.gameRules,
  });

  factory GameSettings.fromJson(Map<String, dynamic> json) {
    return GameSettings(
      map: json['Map'] ?? '',
      mode: json['Mode'] ?? '',
      useBots: json['UseBots'] ?? false,
      gamePod: json['GamePod'] ?? '',
      gameRules: json['GameRules'] != null ? GameRules.fromJson(json['GameRules']) : null,
    );
  }
}

class GameRules {
  String? allowGameModifiers;
  String? isOvertimeWinByTwo;
  String? playOutAllRounds;
  String? skipMatchHistory;
  String? tournamentMode;

  GameRules({
    this.allowGameModifiers,
    this.isOvertimeWinByTwo,
    this.playOutAllRounds,
    this.skipMatchHistory,
    this.tournamentMode,
  });
  
  static fromJson(param0) {}
}

class Membership {
  List<MembershipTeam>? teamOne;
  List<MembershipTeam>? teamTwo;
  List<MembershipTeam>? teamSpectate;
  List<MembershipTeam>? teamOneCoaches;
  List<MembershipTeam>? teamTwoCoaches;

  Membership({
    this.teamOne,
    this.teamTwo,
    this.teamSpectate,
    this.teamOneCoaches,
    this.teamTwoCoaches,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      teamOne: (json['teamOne'] as List<dynamic>?)
          ?.map((item) => MembershipTeam.fromJson(item))
          .toList(),
      teamTwo: (json['teamTwo'] as List<dynamic>?)
          ?.map((item) => MembershipTeam.fromJson(item))
          .toList(),
      teamSpectate: (json['teamSpectate'] as List<dynamic>?)
          ?.map((item) => MembershipTeam.fromJson(item))
          .toList(),
      teamOneCoaches: (json['teamOneCoaches'] as List<dynamic>?)
          ?.map((item) => MembershipTeam.fromJson(item))
          .toList(),
      teamTwoCoaches: (json['teamTwoCoaches'] as List<dynamic>?)
          ?.map((item) => MembershipTeam.fromJson(item))
          .toList(),
    );
  }
}

class MembershipTeam {
  String subject;

  MembershipTeam({required this.subject});

  factory MembershipTeam.fromJson(Map<String, dynamic> json) {
    return MembershipTeam(subject: json['Subject'] ?? '');
  }
}

class MatchmakingData {
  String queueID;
  List<String> preferredGamePods;
  int skillDisparityRRPenalty;

  MatchmakingData({
    required this.queueID,
    required this.preferredGamePods,
    required this.skillDisparityRRPenalty,
  });

  factory MatchmakingData.fromJson(Map<String, dynamic> json) {
    return MatchmakingData(
      queueID: json['QueueID'] ?? '',
      preferredGamePods: List<String>.from(json['PreferredGamePods'] ?? []),
      skillDisparityRRPenalty: json['SkillDisparityRRPenalty'] ?? 0,
    );
  }
}

class ErrorNotification {
  String errorType;

  ErrorNotification({
    required this.errorType,
  });

  factory ErrorNotification.fromJson(Map<String, dynamic> json) {
    return ErrorNotification(
      errorType: json['ErrorType'] ?? '',
    );
  }
}

class CheatData {
  String gamePodOverride;
  bool forcePostGameProcessing;

  CheatData({
    required this.gamePodOverride,
    required this.forcePostGameProcessing,
  });

  factory CheatData.fromJson(Map<String, dynamic> json) {
    return CheatData(
      gamePodOverride: json['GamePodOverride'] ?? '',
      forcePostGameProcessing: json['ForcePostGameProcessing'] ?? false,
    );
  }
}