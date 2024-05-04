// docs: https://valapidocs.techchrism.me/endpoint/contracts
class ContractsResponse {
  int version;
  String subject;
  List<Contract> contracts;
  List<ProcessedMatch> processedMatches;
  String activeSpecialContract;
  List<Mission> missions;
  MissionMetadata missionMetadata;

  ContractsResponse({
    required this.version,
    required this.subject,
    required this.contracts,
    required this.processedMatches,
    required this.activeSpecialContract,
    required this.missions,
    required this.missionMetadata,
  });

  factory ContractsResponse.fromJson(Map<String, dynamic> json) {
    return ContractsResponse(
      version: json['Version'] ?? 0,
      subject: json['Subject'] ?? '',
      contracts: (json['Contracts'] as List<dynamic>?)
          ?.map((item) => Contract.fromJson(item))
          .toList() ?? [],
      processedMatches: (json['ProcessedMatches'] as List<dynamic>?)
          ?.map((item) => ProcessedMatch.fromJson(item))
          .toList() ?? [],
      activeSpecialContract: json['ActiveSpecialContract'] ?? '',
      missions: (json['Missions'] as List<dynamic>?)
          ?.map((item) => Mission.fromJson(item))
          .toList() ?? [],
      missionMetadata: MissionMetadata.fromJson(json['MissionMetadata']),
    );
  }
}

class Contract {
  String contractDefinitionID;
  ContractProgression contractProgression;
  int progressionLevelReached;
  int progressionTowardsNextLevel;

  Contract({
    required this.contractDefinitionID,
    required this.contractProgression,
    required this.progressionLevelReached,
    required this.progressionTowardsNextLevel,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      contractDefinitionID: json['ContractDefinitionID'] ?? '',
      contractProgression: ContractProgression.fromJson(json['ContractProgression']),
      progressionLevelReached: json['ProgressionLevelReached'] ?? 0,
      progressionTowardsNextLevel: json['ProgressionTowardsNextLevel'] ?? 0,
    );
  }
}

class ContractProgression {
  int totalProgressionEarned;
  int totalProgressionEarnedVersion;
  Map<String, HighestRewardedLevel> highestRewardedLevel;

  ContractProgression({
    required this.totalProgressionEarned,
    required this.totalProgressionEarnedVersion,
    required this.highestRewardedLevel,
  });

  factory ContractProgression.fromJson(Map<String, dynamic> json) {
    return ContractProgression(
      totalProgressionEarned: json['TotalProgressionEarned'] ?? 0,
      totalProgressionEarnedVersion: json['TotalProgressionEarnedVersion'] ?? 0,
      highestRewardedLevel: (json['HighestRewardedLevel'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, HighestRewardedLevel.fromJson(value))) ?? {},
    );
  }
}

class HighestRewardedLevel {
  int amount;
  int version;

  HighestRewardedLevel({
    required this.amount,
    required this.version,
  });

  factory HighestRewardedLevel.fromJson(Map<String, dynamic> json) {
    return HighestRewardedLevel(
      amount: json['Amount'] ?? 0,
      version: json['Version'] ?? 0,
    );
  }
}

class ProcessedMatch {
  String id;
  int startTime;
  XPGrants? xpGrants;
  RewardGrants? rewardGrants;
  MissionDeltas? missionDeltas;
  ContractDeltas? contractDeltas;
  bool couldProgressMissions;

  ProcessedMatch({
    required this.id,
    required this.startTime,
    this.xpGrants,
    this.rewardGrants,
    this.missionDeltas,
    this.contractDeltas,
    required this.couldProgressMissions,
  });

  factory ProcessedMatch.fromJson(Map<String, dynamic> json) {
    return ProcessedMatch(
      id: json['ID'] ?? '',
      startTime: json['StartTime'] ?? 0,
      xpGrants: json['XPGrants'] != null ? XPGrants.fromJson(json['XPGrants']) : null,
      rewardGrants: json['RewardGrants'] != null ? RewardGrants.fromJson(json['RewardGrants']) : null,
      missionDeltas: json['MissionDeltas'] != null ? MissionDeltas.fromJson(json['MissionDeltas']) : null,
      contractDeltas: json['ContractDeltas'] != null ? ContractDeltas.fromJson(json['ContractDeltas']) : null,
      couldProgressMissions: json['CouldProgressMissions'] ?? false,
    );
  }
}

class XPGrants {
  int gamePlayed;
  int gameWon;
  int roundPlayed;
  int roundWon;
  Map<String, dynamic> missions;
  Modifier modifier;
  int numAFKRounds;

  XPGrants({
    required this.gamePlayed,
    required this.gameWon,
    required this.roundPlayed,
    required this.roundWon,
    required this.missions,
    required this.modifier,
    required this.numAFKRounds,
  });

  factory XPGrants.fromJson(Map<String, dynamic> json) {
    return XPGrants(
      gamePlayed: json['GamePlayed'] ?? 0,
      gameWon: json['GameWon'] ?? 0,
      roundPlayed: json['RoundPlayed'] ?? 0,
      roundWon: json['RoundWon'] ?? 0,
      missions: json['Missions'] ?? {},
      modifier: Modifier.fromJson(json['Modifier']),
      numAFKRounds: json['NumAFKRounds'] ?? 0,
    );
  }
}

class Modifier {
  int value;
  int baseMultiplierValue;
  List<Modifiers> modifiers;

  Modifier({
    required this.value,
    required this.baseMultiplierValue,
    required this.modifiers,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) {
    return Modifier(
      value: json['Value'] ?? 0,
      baseMultiplierValue: json['BaseMultiplierValue'] ?? 0,
      modifiers: (json['Modifiers'] as List<dynamic>?)
          ?.map((item) => Modifiers.fromJson(item))
          .toList() ?? [],
    );
  }
}

class Modifiers {
  int value;
  String name;
  bool baseOnly;

  Modifiers({
    required this.value,
    required this.name,
    required this.baseOnly,
  });

  factory Modifiers.fromJson(Map<String, dynamic> json) {
    return Modifiers(
      value: json['Value'] ?? 0,
      name: json['Name'] ?? '',
      baseOnly: json['BaseOnly'] ?? false,
    );
  }
}

class RewardGrants {
  static fromJson(json) {}
  // Define RewardGrants class properties here
  // ...
}

class MissionDeltas {
  static fromJson(json) {}
  // Define MissionDeltas class properties here
  // ...
}

class ContractDeltas {
  static fromJson(json) {}
  // Define ContractDeltas class properties here
  // ...
}

class Mission {
  String id;
  Map<String, int> objectives;
  bool complete;
  String expirationTime;

  Mission({
    required this.id,
    required this.objectives,
    required this.complete,
    required this.expirationTime,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['ID'] ?? '',
      objectives: (json['Objectives'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, value as int)) ?? {},
      complete: json['Complete'] ?? false,
      expirationTime: json['ExpirationTime'] ?? '',
    );
  }
}

class MissionMetadata {
  bool npeCompleted;
  String weeklyCheckpoint;
  String weeklyRefillTime;

  MissionMetadata({
    required this.npeCompleted,
    required this.weeklyCheckpoint,
    required this.weeklyRefillTime,
  });

  factory MissionMetadata.fromJson(Map<String, dynamic> json) {
    return MissionMetadata(
      npeCompleted: json['NPECompleted'] ?? false,
      weeklyCheckpoint: json['WeeklyCheckpoint'] ?? '',
      weeklyRefillTime: json['WeeklyRefillTime'] ?? '',
    );
  }
}