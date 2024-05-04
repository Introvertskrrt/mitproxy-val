// docs: https://valapidocs.techchrism.me/endpoint/account-xp
class AccountXPResponse {
  int version;
  String subject;
  int playerLevel;
  int playerXP;
  List<AccountXPHistory> history;
  String lastTimeGrantedFirstWin;
  String nextTimeFirstWinAvailable;

  AccountXPResponse({
    required this.version,
    required this.subject,
    required this.playerLevel,
    required this.playerXP,
    required this.history,
    required this.lastTimeGrantedFirstWin,
    required this.nextTimeFirstWinAvailable,
  });

  factory AccountXPResponse.fromJson(Map<String, dynamic> json) {
    return AccountXPResponse(
      version: json['Version'] ?? 0,
      subject: json['Subject'] ?? '',
      playerLevel: json['Progress']['Level'] ?? 0,
      playerXP: json['Progress']['XP'] ?? 0,
      history: (json['History'] as List<dynamic>?)
          ?.map((item) => AccountXPHistory.fromJson(item))
          .toList() ??
          [],
      lastTimeGrantedFirstWin: json['LastTimeGrantedFirstWin'] ?? '',
      nextTimeFirstWinAvailable: json['NextTimeFirstWinAvailable'] ?? '',
    );
  }
}

class AccountXPHistory {
  String id;
  String matchStart;
  AccountXPProgress startProgress;
  AccountXPProgress endProgress;
  int xpDelta;
  List<XPSources> xpSources;
  List<dynamic> xpMultipliers;

  AccountXPHistory({
    required this.id,
    required this.matchStart,
    required this.startProgress,
    required this.endProgress,
    required this.xpDelta,
    required this.xpSources,
    required this.xpMultipliers,
  });

  factory AccountXPHistory.fromJson(Map<String, dynamic> json) {
    return AccountXPHistory(
      id: json['ID'] ?? '',
      matchStart: json['MatchStart'] ?? '',
      startProgress: AccountXPProgress.fromJson(json['StartProgress']),
      endProgress: AccountXPProgress.fromJson(json['EndProgress']),
      xpDelta: json['XPDelta'] ?? 0,
      xpSources: (json['XPSources'] as List<dynamic>?)
          ?.map((item) => XPSources.fromJson(item))
          .toList() ??
          [],
      xpMultipliers: json['XPMultipliers'] ?? [],
    );
  }
}

class AccountXPProgress {
  int level;
  int xp;

  AccountXPProgress({
    required this.level,
    required this.xp,
  });

  factory AccountXPProgress.fromJson(Map<String, dynamic> json) {
    return AccountXPProgress(
      level: json['Level'] ?? 0,
      xp: json['XP'] ?? 0,
    );
  }
}

class XPSources {
  String id;
  int amount;

  XPSources({
    required this.id,
    required this.amount,
  });

  factory XPSources.fromJson(Map<String, dynamic> json) {
    return XPSources(
      id: json['ID'] ?? '',
      amount: json['Amount'] ?? 0,
    );
  }
}