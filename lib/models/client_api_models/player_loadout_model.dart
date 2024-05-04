// docs: https://valapidocs.techchrism.me/endpoint/player-loadout
class PlayerLoadoutResponse {
  String subject;
  int version;
  List<Gun> guns;
  List<Spray> sprays;
  Identity identity;
  bool incognito;

  PlayerLoadoutResponse({
    required this.subject,
    required this.version,
    required this.guns,
    required this.sprays,
    required this.identity,
    required this.incognito,
  });

  factory PlayerLoadoutResponse.fromJson(Map<String, dynamic> json) {
    return PlayerLoadoutResponse(
      subject: json['Subject'] ?? '',
      version: json['Version'] ?? 0,
      guns: (json['Guns'] as List<dynamic>?)
          ?.map((item) => Gun.fromJson(item))
          .toList() ?? [],
      sprays: (json['Sprays'] as List<dynamic>?)
          ?.map((item) => Spray.fromJson(item))
          .toList() ?? [],
      identity: Identity.fromJson(json['Identity']),
      incognito: json['Incognito'] ?? false,
    );
  }
}

class Gun {
  String id;
  String? charmInstanceID;
  String? charmID;
  String? charmLevelID;
  String skinID;
  String skinLevelID;
  String chromaID;
  List<dynamic> attachments;

  Gun({
    required this.id,
    this.charmInstanceID,
    this.charmID,
    this.charmLevelID,
    required this.skinID,
    required this.skinLevelID,
    required this.chromaID,
    required this.attachments,
  });

  factory Gun.fromJson(Map<String, dynamic> json) {
    return Gun(
      id: json['ID'] ?? '',
      charmInstanceID: json['CharmInstanceID'],
      charmID: json['CharmID'],
      charmLevelID: json['CharmLevelID'],
      skinID: json['SkinID'] ?? '',
      skinLevelID: json['SkinLevelID'] ?? '',
      chromaID: json['ChromaID'] ?? '',
      attachments: json['Attachments'] ?? [],
    );
  }
}

class Spray {
  String equipSlotID;
  String sprayID;
  String? sprayLevelID;

  Spray({
    required this.equipSlotID,
    required this.sprayID,
    this.sprayLevelID,
  });

  factory Spray.fromJson(Map<String, dynamic> json) {
    return Spray(
      equipSlotID: json['EquipSlotID'] ?? '',
      sprayID: json['SprayID'] ?? '',
      sprayLevelID: json['SprayLevelID'],
    );
  }
}

class Identity {
  String playerCardID;
  String playerTitleID;
  int accountLevel;
  String preferredLevelBorderID;
  bool hideAccountLevel;

  Identity({
    required this.playerCardID,
    required this.playerTitleID,
    required this.accountLevel,
    required this.preferredLevelBorderID,
    required this.hideAccountLevel,
  });

  factory Identity.fromJson(Map<String, dynamic> json) {
    return Identity(
      playerCardID: json['PlayerCardID'] ?? '',
      playerTitleID: json['PlayerTitleID'] ?? '',
      accountLevel: json['AccountLevel'] ?? 0,
      preferredLevelBorderID: json['PreferredLevelBorderID'] ?? '',
      hideAccountLevel: json['HideAccountLevel'] ?? false,
    );
  }
}