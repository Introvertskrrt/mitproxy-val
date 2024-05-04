class BuddiesResponse {
  int status;
  List<Buddy> data;

  BuddiesResponse({
    required this.status,
    required this.data,
  });

  factory BuddiesResponse.fromJson(Map<String, dynamic> json) => BuddiesResponse(
        status: json['status'],
        data: List<Buddy>.from(json['data'].map((x) => Buddy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Buddy {
  String uuid;
  String displayName;
  bool isHiddenIfNotOwned;
  dynamic themeUuid;
  String displayIcon;
  String assetPath;
  List<Level> levels;

  Buddy({
    required this.uuid,
    required this.displayName,
    required this.isHiddenIfNotOwned,
    required this.themeUuid,
    required this.displayIcon,
    required this.assetPath,
    required this.levels,
  });

  factory Buddy.fromJson(Map<String, dynamic> json) => Buddy(
        uuid: json['uuid'],
        displayName: json['displayName'],
        isHiddenIfNotOwned: json['isHiddenIfNotOwned'],
        themeUuid: json['themeUuid'],
        displayIcon: json['displayIcon'],
        assetPath: json['assetPath'],
        levels: List<Level>.from(json['levels'].map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'isHiddenIfNotOwned': isHiddenIfNotOwned,
        'themeUuid': themeUuid,
        'displayIcon': displayIcon,
        'assetPath': assetPath,
        'levels': List<dynamic>.from(levels.map((x) => x.toJson())),
      };
}

class Level {
  String uuid;
  int charmLevel;
  bool hideIfNotOwned;
  String displayName;
  String displayIcon;
  String assetPath;

  Level({
    required this.uuid,
    required this.charmLevel,
    required this.hideIfNotOwned,
    required this.displayName,
    required this.displayIcon,
    required this.assetPath,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        uuid: json['uuid'],
        charmLevel: json['charmLevel'],
        hideIfNotOwned: json['hideIfNotOwned'],
        displayName: json['displayName'],
        displayIcon: json['displayIcon'],
        assetPath: json['assetPath'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'charmLevel': charmLevel,
        'hideIfNotOwned': hideIfNotOwned,
        'displayName': displayName,
        'displayIcon': displayIcon,
        'assetPath': assetPath,
      };
}
