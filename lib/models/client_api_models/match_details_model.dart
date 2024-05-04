class MatchDetailsResponse {
  MatchInfo? matchInfo;
  List<Player>? players;
  List<dynamic>? bots;
  List<Coach>? coaches;
  List<Team>? teams;
  List<RoundResult>? roundResults;
  List<Kill>? kills;

  MatchDetailsResponse({
    this.matchInfo,
    this.players,
    this.bots,
    this.coaches,
    this.teams,
    this.roundResults,
    this.kills,
  });

  factory MatchDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MatchDetailsResponse(
      matchInfo: json['matchInfo'] != null ? MatchInfo.fromJson(json['matchInfo']) : null,
      players: (json['players'] as List<dynamic>?)?.map((e) => Player.fromJson(e)).toList(),
      bots: json['bots'] as List<dynamic>?,
      coaches: (json['coaches'] as List<dynamic>?)?.map((e) => Coach.fromJson(e)).toList(),
      teams: (json['teams'] as List<dynamic>?)?.map((e) => Team.fromJson(e)).toList(),
      roundResults: (json['roundResults'] as List<dynamic>?)?.map((e) => RoundResult.fromJson(e)).toList(),
      kills: (json['kills'] as List<dynamic>?)?.map((e) => Kill.fromJson(e)).toList(),
    );
  }
}

class MatchInfo {
  String? matchId;
  String? mapId;
  String? gamePodId;
  String? gameLoopZone;
  String? gameServerAddress;
  String? gameVersion;
  dynamic gameLengthMillis;
  dynamic gameStartMillis;
  String? provisioningFlowID;
  bool? isCompleted;
  String? customGameName;
  bool? forcePostProcessing;
  String? queueID;
  String? gameMode;
  bool? isRanked;
  bool? isMatchSampled;
  String? seasonId;
  String? completionState;
  String? platformType;
  dynamic premierMatchInfo;
  Map<String, dynamic>? partyRRPenalties;
  bool? shouldMatchDisablePenalties;

  MatchInfo({
    this.matchId,
    this.mapId,
    this.gamePodId,
    this.gameLoopZone,
    this.gameServerAddress,
    this.gameVersion,
    this.gameLengthMillis,
    this.gameStartMillis,
    this.provisioningFlowID,
    this.isCompleted,
    this.customGameName,
    this.forcePostProcessing,
    this.queueID,
    this.gameMode,
    this.isRanked,
    this.isMatchSampled,
    this.seasonId,
    this.completionState,
    this.platformType,
    this.premierMatchInfo,
    this.partyRRPenalties,
    this.shouldMatchDisablePenalties,
  });

  factory MatchInfo.fromJson(Map<String, dynamic> json) {
    return MatchInfo(
      matchId: json['matchId'],
      mapId: json['mapId'],
      gamePodId: json['gamePodId'],
      gameLoopZone: json['gameLoopZone'],
      gameServerAddress: json['gameServerAddress'],
      gameVersion: json['gameVersion'],
      gameLengthMillis: json['gameLengthMillis'],
      gameStartMillis: json['gameStartMillis'],
      provisioningFlowID: json['provisioningFlowID'],
      isCompleted: json['isCompleted'],
      customGameName: json['customGameName'],
      forcePostProcessing: json['forcePostProcessing'],
      queueID: json['queueID'],
      gameMode: json['gameMode'],
      isRanked: json['isRanked'],
      isMatchSampled: json['isMatchSampled'],
      seasonId: json['seasonId'],
      completionState: json['completionState'],
      platformType: json['platformType'],
      premierMatchInfo: json['premierMatchInfo'],
      partyRRPenalties: (json['partyRRPenalties'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, value)),
      shouldMatchDisablePenalties: json['shouldMatchDisablePenalties'],
    );
  }
}

class Player {
  String? subject;
  String? gameName;
  String? tagLine;
  PlatformInfo? platformInfo;
  String? teamId;
  String? partyId;
  String? characterId;
  Stats? stats;
  List<RoundDamage>? roundDamage;
  dynamic competitiveTier;
  bool? isObserver;
  String? playerCard;
  String? playerTitle;
  String? preferredLevelBorder;
  dynamic accountLevel;
  dynamic sessionPlaytimeMinutes;
  List<XpModification>? xpModifications;
  BehaviorFactors? behaviorFactors;
  NewPlayerExperienceDetails? newPlayerExperienceDetails;

  Player({
    this.subject,
    this.gameName,
    this.tagLine,
    this.platformInfo,
    this.teamId,
    this.partyId,
    this.characterId,
    this.stats,
    this.roundDamage,
    this.competitiveTier,
    this.isObserver,
    this.playerCard,
    this.playerTitle,
    this.preferredLevelBorder,
    this.accountLevel,
    this.sessionPlaytimeMinutes,
    this.xpModifications,
    this.behaviorFactors,
    this.newPlayerExperienceDetails,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      subject: json['subject'],
      gameName: json['gameName'],
      tagLine: json['tagLine'],
      platformInfo: json['platformInfo'] != null ? PlatformInfo.fromJson(json['platformInfo']) : null,
      teamId: json['teamId'],
      partyId: json['partyId'],
      characterId: json['characterId'],
      stats: json['stats'] != null ? Stats.fromJson(json['stats']) : null,
      roundDamage: (json['roundDamage'] as List<dynamic>?)?.map((e) => RoundDamage.fromJson(e)).toList(),
      competitiveTier: json['competitiveTier'],
      isObserver: json['isObserver'],
      playerCard: json['playerCard'],
      playerTitle: json['playerTitle'],
      preferredLevelBorder: json['preferredLevelBorder'],
      accountLevel: json['accountLevel'],
      sessionPlaytimeMinutes: json['sessionPlaytimeMinutes'],
      xpModifications: (json['xpModifications'] as List<dynamic>?)?.map((e) => XpModification.fromJson(e)).toList(),
      behaviorFactors: json['behaviorFactors'] != null ? BehaviorFactors.fromJson(json['behaviorFactors']) : null,
      newPlayerExperienceDetails: json['newPlayerExperienceDetails'] != null
          ? NewPlayerExperienceDetails.fromJson(json['newPlayerExperienceDetails'])
          : null,
    );
  }
}

class PlatformInfo {
  String? platformType;
  String? platformOS;
  String? platformOSVersion;
  String? platformChipset;

  PlatformInfo({
    this.platformType,
    this.platformOS,
    this.platformOSVersion,
    this.platformChipset,
  });

  factory PlatformInfo.fromJson(Map<String, dynamic> json) {
    return PlatformInfo(
      platformType: json['platformType'],
      platformOS: json['platformOS'],
      platformOSVersion: json['platformOSVersion'],
      platformChipset: json['platformChipset'],
    );
  }
}

class Stats {
  dynamic score;
  dynamic roundsPlayed;
  dynamic kills;
  dynamic deaths;
  dynamic assists;
  dynamic playtimeMillis;
  AbilityCasts? abilityCasts;

  Stats({
    this.score,
    this.roundsPlayed,
    this.kills,
    this.deaths,
    this.assists,
    this.playtimeMillis,
    this.abilityCasts,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      score: json['score'],
      roundsPlayed: json['roundsPlayed'],
      kills: json['kills'],
      deaths: json['deaths'],
      assists: json['assists'],
      playtimeMillis: json['playtimeMillis'],
      abilityCasts: json['abilityCasts'] != null ? AbilityCasts.fromJson(json['abilityCasts']) : null,
    );
  }
}

class AbilityCasts {
  dynamic grenadeCasts;
  dynamic ability1Casts;
  dynamic ability2Casts;
  dynamic ultimateCasts;

  AbilityCasts({
    this.grenadeCasts,
    this.ability1Casts,
    this.ability2Casts,
    this.ultimateCasts,
  });

  factory AbilityCasts.fromJson(Map<String, dynamic> json) {
    return AbilityCasts(
      grenadeCasts: json['grenadeCasts'],
      ability1Casts: json['ability1Casts'],
      ability2Casts: json['ability2Casts'],
      ultimateCasts: json['ultimateCasts'],
    );
  }
}

class RoundDamage {
  dynamic round;
  String? receiver;
  dynamic damage;

  RoundDamage({
    this.round,
    this.receiver,
    this.damage,
  });

  factory RoundDamage.fromJson(Map<String, dynamic> json) {
    return RoundDamage(
      round: json['round'],
      receiver: json['receiver'],
      damage: json['damage'],
    );
  }
}

class XpModification {
  dynamic value;
  String? id;

  XpModification({
    this.value,
    this.id,
  });

  factory XpModification.fromJson(Map<String, dynamic> json) {
    return XpModification(
      value: json['Value'],
      id: json['ID'],
    );
  }
}

class BehaviorFactors {
  dynamic afkRounds;
  dynamic collisions;
  dynamic commsRatingRecovery;
  dynamic damageParticipationOutgoing;
  dynamic friendlyFireIncoming;
  dynamic friendlyFireOutgoing;
  dynamic mouseMovement;
  dynamic stayedInSpawnRounds;

  BehaviorFactors({
    this.afkRounds,
    this.collisions,
    this.commsRatingRecovery,
    this.damageParticipationOutgoing,
    this.friendlyFireIncoming,
    this.friendlyFireOutgoing,
    this.mouseMovement,
    this.stayedInSpawnRounds,
  });

  factory BehaviorFactors.fromJson(Map<String, dynamic> json) {
    return BehaviorFactors(
      afkRounds: json['afkRounds'],
      collisions: json['collisions'],
      commsRatingRecovery: json['commsRatingRecovery'],
      damageParticipationOutgoing: json['damageParticipationOutgoing'],
      friendlyFireIncoming: json['friendlyFireIncoming'],
      friendlyFireOutgoing: json['friendlyFireOutgoing'],
      mouseMovement: json['mouseMovement'],
      stayedInSpawnRounds: json['stayedInSpawnRounds'],
    );
  }
}

class NewPlayerExperienceDetails {
  BasicMovement? basicMovement;
  BasicGunSkill? basicGunSkill;
  AdaptiveBots? adaptiveBots;
  Ability? ability;
  BombPlant? bombPlant;
  DefendBombSite? defendBombSite;
  SettingStatus? settingStatus;
  String? versionString;

  NewPlayerExperienceDetails({
    this.basicMovement,
    this.basicGunSkill,
    this.adaptiveBots,
    this.ability,
    this.bombPlant,
    this.defendBombSite,
    this.settingStatus,
    this.versionString,
  });

  factory NewPlayerExperienceDetails.fromJson(Map<String, dynamic> json) {
    return NewPlayerExperienceDetails(
      basicMovement: json['basicMovement'] != null ? BasicMovement.fromJson(json['basicMovement']) : null,
      basicGunSkill: json['basicGunSkill'] != null ? BasicGunSkill.fromJson(json['basicGunSkill']) : null,
      adaptiveBots: json['adaptiveBots'] != null ? AdaptiveBots.fromJson(json['adaptiveBots']) : null,
      ability: json['ability'] != null ? Ability.fromJson(json['ability']) : null,
      bombPlant: json['bombPlant'] != null ? BombPlant.fromJson(json['bombPlant']) : null,
      defendBombSite: json['defendBombSite'] != null ? DefendBombSite.fromJson(json['defendBombSite']) : null,
      settingStatus: json['settingStatus'] != null ? SettingStatus.fromJson(json['settingStatus']) : null,
      versionString: json['versionString'],
    );
  }
}

class BasicMovement {
  dynamic idleTimeMillis;
  dynamic objectiveCompleteTimeMillis;

  BasicMovement({
    this.idleTimeMillis,
    this.objectiveCompleteTimeMillis,
  });

  factory BasicMovement.fromJson(Map<String, dynamic> json) {
    return BasicMovement(
      idleTimeMillis: json['idleTimeMillis'],
      objectiveCompleteTimeMillis: json['objectiveCompleteTimeMillis'],
    );
  }
}

class BasicGunSkill {
  dynamic idleTimeMillis;
  dynamic objectiveCompleteTimeMillis;

  BasicGunSkill({
    this.idleTimeMillis,
    this.objectiveCompleteTimeMillis,
  });

  factory BasicGunSkill.fromJson(Map<String, dynamic> json) {
    return BasicGunSkill(
      idleTimeMillis: json['idleTimeMillis'],
      objectiveCompleteTimeMillis: json['objectiveCompleteTimeMillis'],
    );
  }
}

class AdaptiveBots {
  dynamic adaptiveBotAverageDurationMillisAllAttempts;
  dynamic adaptiveBotAverageDurationMillisFirstAttempt;
  dynamic killDetailsFirstAttempt;
  dynamic idleTimeMillis;
  dynamic objectiveCompleteTimeMillis;

  AdaptiveBots({
    this.adaptiveBotAverageDurationMillisAllAttempts,
    this.adaptiveBotAverageDurationMillisFirstAttempt,
    this.killDetailsFirstAttempt,
    this.idleTimeMillis,
    this.objectiveCompleteTimeMillis,
  });

  factory AdaptiveBots.fromJson(Map<String, dynamic> json) {
    return AdaptiveBots(
      adaptiveBotAverageDurationMillisAllAttempts: json['adaptiveBotAverageDurationMillisAllAttempts'],
      adaptiveBotAverageDurationMillisFirstAttempt: json['adaptiveBotAverageDurationMillisFirstAttempt'],
      killDetailsFirstAttempt: json['killDetailsFirstAttempt'],
      idleTimeMillis: json['idleTimeMillis'],
      objectiveCompleteTimeMillis: json['objectiveCompleteTimeMillis'],
    );
  }
}

class Ability {
  dynamic idleTimeMillis;
  dynamic objectiveCompleteTimeMillis;

  Ability({
    this.idleTimeMillis,
    this.objectiveCompleteTimeMillis,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      idleTimeMillis: json['idleTimeMillis'],
      objectiveCompleteTimeMillis: json['objectiveCompleteTimeMillis'],
    );
  }
}

class BombPlant {
  dynamic idleTimeMillis;
  dynamic objectiveCompleteTimeMillis;

  BombPlant({
    this.idleTimeMillis,
    this.objectiveCompleteTimeMillis,
  });

  factory BombPlant.fromJson(Map<String, dynamic> json) {
    return BombPlant(
      idleTimeMillis: json['idleTimeMillis'],
      objectiveCompleteTimeMillis: json['objectiveCompleteTimeMillis'],
    );
  }
}

class DefendBombSite {
  bool? success;
  dynamic idleTimeMillis;
  dynamic objectiveCompleteTimeMillis;

  DefendBombSite({
    this.success,
    this.idleTimeMillis,
    this.objectiveCompleteTimeMillis,
  });

  factory DefendBombSite.fromJson(Map<String, dynamic> json) {
    return DefendBombSite(
      success: json['success'],
      idleTimeMillis: json['idleTimeMillis'],
      objectiveCompleteTimeMillis: json['objectiveCompleteTimeMillis'],
    );
  }
}

class SettingStatus {
  bool? isMouseSensitivityDefault;
  bool? isCrosshairDefault;

  SettingStatus({
    this.isMouseSensitivityDefault,
    this.isCrosshairDefault,
  });

  factory SettingStatus.fromJson(Map<String, dynamic> json) {
    return SettingStatus(
      isMouseSensitivityDefault: json['isMouseSensitivityDefault'],
      isCrosshairDefault: json['isCrosshairDefault'],
    );
  }
}

class Coach {
  String? subject;
  String? teamId;

  Coach({
    this.subject,
    this.teamId,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      subject: json['subject'],
      teamId: json['teamId'],
    );
  }
}

class Team {
  String? teamId;
  bool? won;
  dynamic roundsPlayed;
  dynamic roundsWon;
  dynamic numPodynamics;

  Team({
    this.teamId,
    this.won,
    this.roundsPlayed,
    this.roundsWon,
    this.numPodynamics,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['teamId'],
      won: json['won'],
      roundsPlayed: json['roundsPlayed'],
      roundsWon: json['roundsWon'],
      numPodynamics: json['numPodynamics'],
    );
  }
}

class RoundResult {
  dynamic roundNum;
  String? roundResult;
  String? roundCeremony;
  String? winningTeam;
  String? bombPlanter;
  String? bombDefuser;
  dynamic plantRoundTime;
  List<PlantPlayerLocation>? plantPlayerLocations;
  PlantLocation? plantLocation;
  String? plantSite;
  dynamic defuseRoundTime;
  List<DefusePlayerLocation>? defusePlayerLocations;
  DefuseLocation? defuseLocation;
  List<PlayerStats>? playerStats;
  String? roundResultCode;
  List<PlayerEconomy>? playerEconomies;
  List<PlayerScore>? playerScores;

  RoundResult({
    this.roundNum,
    this.roundResult,
    this.roundCeremony,
    this.winningTeam,
    this.bombPlanter,
    this.bombDefuser,
    this.plantRoundTime,
    this.plantPlayerLocations,
    this.plantLocation,
    this.plantSite,
    this.defuseRoundTime,
    this.defusePlayerLocations,
    this.defuseLocation,
    this.playerStats,
    this.roundResultCode,
    this.playerEconomies,
    this.playerScores,
  });

  factory RoundResult.fromJson(Map<String, dynamic> json) {
    return RoundResult(
      roundNum: json['roundNum'],
      roundResult: json['roundResult'],
      roundCeremony: json['roundCeremony'],
      winningTeam: json['winningTeam'],
      bombPlanter: json['bombPlanter'],
      bombDefuser: json['bombDefuser'],
      plantRoundTime: json['plantRoundTime'],
      plantPlayerLocations: (json['plantPlayerLocations'] as List<dynamic>?)
          ?.map((e) => PlantPlayerLocation.fromJson(e))
          .toList(),
      plantLocation: json['plantLocation'] != null ? PlantLocation.fromJson(json['plantLocation']) : null,
      plantSite: json['plantSite'],
      defuseRoundTime: json['defuseRoundTime'],
      defusePlayerLocations: (json['defusePlayerLocations'] as List<dynamic>?)
          ?.map((e) => DefusePlayerLocation.fromJson(e))
          .toList(),
      defuseLocation: json['defuseLocation'] != null ? DefuseLocation.fromJson(json['defuseLocation']) : null,
      playerStats: (json['playerStats'] as List<dynamic>?)
          ?.map((e) => PlayerStats.fromJson(e))
          .toList(),
      roundResultCode: json['roundResultCode'],
      playerEconomies: (json['playerEconomies'] as List<dynamic>?)
          ?.map((e) => PlayerEconomy.fromJson(e))
          .toList(),
      playerScores: (json['playerScores'] as List<dynamic>?)
          ?.map((e) => PlayerScore.fromJson(e))
          .toList(),
    );
  }
}

class PlantPlayerLocation {
  String? subject;
  dynamic viewRadians;
  Location? location;

  PlantPlayerLocation({
    this.subject,
    this.viewRadians,
    this.location,
  });

  factory PlantPlayerLocation.fromJson(Map<String, dynamic> json) {
    return PlantPlayerLocation(
      subject: json['subject'],
      viewRadians: json['viewRadians'],
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }
}

class Location {
  dynamic x;
  dynamic y;

  Location({
    this.x,
    this.y,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      x: json['x'],
      y: json['y'],
    );
  }
}

class PlantLocation {
  dynamic x;
  dynamic y;

  PlantLocation({
    this.x,
    this.y,
  });

  factory PlantLocation.fromJson(Map<String, dynamic> json) {
    return PlantLocation(
      x: json['x'],
      y: json['y'],
    );
  }
}

class DefusePlayerLocation {
  String? subject;
  dynamic viewRadians;
  Location? location;

  DefusePlayerLocation({
    this.subject,
    this.viewRadians,
    this.location,
  });

  factory DefusePlayerLocation.fromJson(Map<String, dynamic> json) {
    return DefusePlayerLocation(
      subject: json['subject'],
      viewRadians: json['viewRadians'],
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }
}

class DefuseLocation {
  dynamic x;
  dynamic y;

  DefuseLocation({
    this.x,
    this.y,
  });

  factory DefuseLocation.fromJson(Map<String, dynamic> json) {
    return DefuseLocation(
      x: json['x'],
      y: json['y'],
    );
  }
}

class PlayerStats {
  String? subject;
  List<KillDetail>? kills;
  List<Damage>? damage;
  dynamic score;
  Economy? economy;
  Ability2? ability;
  bool? wasAfk;
  bool? wasPenalized;
  bool? stayedInSpawn;

  PlayerStats({
    this.subject,
    this.kills,
    this.damage,
    this.score,
    this.economy,
    this.ability,
    this.wasAfk,
    this.wasPenalized,
    this.stayedInSpawn,
  });

  factory PlayerStats.fromJson(Map<String, dynamic> json) {
    return PlayerStats(
      subject: json['subject'],
      kills: (json['kills'] as List<dynamic>?)?.map((e) => KillDetail.fromJson(e)).toList(),
      damage: (json['damage'] as List<dynamic>?)?.map((e) => Damage.fromJson(e)).toList(),
      score: json['score'],
      economy: json['economy'] != null ? Economy.fromJson(json['economy']) : null,
      ability: json['ability'] != null ? Ability2.fromJson(json['ability']) : null,
      wasAfk: json['wasAfk'],
      wasPenalized: json['wasPenalized'],
      stayedInSpawn: json['stayedInSpawn'],
    );
  }
}

class KillDetail {
  dynamic gameTime;
  dynamic roundTime;
  String? killer;
  String? victim;
  Location? victimLocation;
  List<String>? assistants;
  List<PlayerLocation>? playerLocations;
  FinishingDamage? finishingDamage;

  KillDetail({
    this.gameTime,
    this.roundTime,
    this.killer,
    this.victim,
    this.victimLocation,
    this.assistants,
    this.playerLocations,
    this.finishingDamage,
  });

  factory KillDetail.fromJson(Map<String, dynamic> json) {
    return KillDetail(
      gameTime: json['gameTime'],
      roundTime: json['roundTime'],
      killer: json['killer'],
      victim: json['victim'],
      victimLocation: json['victimLocation'] != null ? Location.fromJson(json['victimLocation']) : null,
      assistants: json['assistants'] != null ? List<String>.from(json['assistants']) : null,
      playerLocations: (json['playerLocations'] as List<dynamic>?)
          ?.map((e) => PlayerLocation.fromJson(e))
          .toList(),
      finishingDamage: json['finishingDamage'] != null ? FinishingDamage.fromJson(json['finishingDamage']) : null,
    );
  }
}

class PlayerLocation {
  String? subject;
  dynamic viewRadians;
  Location? location;

  PlayerLocation({
    this.subject,
    this.viewRadians,
    this.location,
  });

  factory PlayerLocation.fromJson(Map<String, dynamic> json) {
    return PlayerLocation(
      subject: json['subject'],
      viewRadians: json['viewRadians'],
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }
}

class FinishingDamage {
  String? damageType;
  String? damageItem;
  bool? isSecondaryFireMode;

  FinishingDamage({
    this.damageType,
    this.damageItem,
    this.isSecondaryFireMode,
  });

  factory FinishingDamage.fromJson(Map<String, dynamic> json) {
    return FinishingDamage(
      damageType: json['damageType'],
      damageItem: json['damageItem'],
      isSecondaryFireMode: json['isSecondaryFireMode'],
    );
  }
}

class Damage {
  String? receiver;
  dynamic damage;
  dynamic legshots;
  dynamic bodyshots;
  dynamic headshots;

  Damage({
    this.receiver,
    this.damage,
    this.legshots,
    this.bodyshots,
    this.headshots,
  });

  factory Damage.fromJson(Map<String, dynamic> json) {
    return Damage(
      receiver: json['receiver'],
      damage: json['damage'],
      legshots: json['legshots'],
      bodyshots: json['bodyshots'],
      headshots: json['headshots'],
    );
  }
}

class Economy {
  dynamic loadoutValue;
  String? weapon;
  String? armor;
  dynamic remaining;
  dynamic spent;

  Economy({
    this.loadoutValue,
    this.weapon,
    this.armor,
    this.remaining,
    this.spent,
  });

  factory Economy.fromJson(Map<String, dynamic> json) {
    return Economy(
      loadoutValue: json['loadoutValue'],
      weapon: json['weapon'],
      armor: json['armor'],
      remaining: json['remaining'],
      spent: json['spent'],
    );
  }
}

class Ability2 {
  dynamic grenadeEffects;
  dynamic ability1Effects;
  dynamic ability2Effects;
  dynamic ultimateEffects;

  Ability2({
    this.grenadeEffects,
    this.ability1Effects,
    this.ability2Effects,
    this.ultimateEffects,
  });

  factory Ability2.fromJson(Map<String, dynamic> json) {
    return Ability2(
      grenadeEffects: json['grenadeEffects'],
      ability1Effects: json['ability1Effects'],
      ability2Effects: json['ability2Effects'],
      ultimateEffects: json['ultimateEffects'],
    );
  }
}

class PlayerEconomy {
  String? subject;
  dynamic loadoutValue;
  String? weapon;
  String? armor;
  dynamic remaining;
  dynamic spent;

  PlayerEconomy({
    this.subject,
    this.loadoutValue,
    this.weapon,
    this.armor,
    this.remaining,
    this.spent,
  });

  factory PlayerEconomy.fromJson(Map<String, dynamic> json) {
    return PlayerEconomy(
      subject: json['subject'],
      loadoutValue: json['loadoutValue'],
      weapon: json['weapon'],
      armor: json['armor'],
      remaining: json['remaining'],
      spent: json['spent'],
    );
  }
}

class PlayerScore {
  String? subject;
  dynamic score;

  PlayerScore({
    this.subject,
    this.score,
  });

  factory PlayerScore.fromJson(Map<String, dynamic> json) {
    return PlayerScore(
      subject: json['subject'],
      score: json['score'],
    );
  }
}

class Kill {
  dynamic gameTime;
  dynamic roundTime;
  String? killer;
  String? victim;
  Location? victimLocation;
  List<String>? assistants;
  List<PlayerLocation>? playerLocations;
  FinishingDamage? finishingDamage;
  dynamic round;

  Kill({
    this.gameTime,
    this.roundTime,
    this.killer,
    this.victim,
    this.victimLocation,
    this.assistants,
    this.playerLocations,
    this.finishingDamage,
    this.round,
  });

  factory Kill.fromJson(Map<String, dynamic> json) {
    return Kill(
      gameTime: json['gameTime'],
      roundTime: json['roundTime'],
      killer: json['killer'],
      victim: json['victim'],
      victimLocation: json['victimLocation'] != null ? Location.fromJson(json['victimLocation']) : null,
      assistants: json['assistants'] != null ? List<String>.from(json['assistants']) : null,
      playerLocations: (json['playerLocations'] as List<dynamic>?)
          ?.map((e) => PlayerLocation.fromJson(e))
          .toList(),
      finishingDamage: json['finishingDamage'] != null ? FinishingDamage.fromJson(json['finishingDamage']) : null,
      round: json['round'],
    );
  }
}
