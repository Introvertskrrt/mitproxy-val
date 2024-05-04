class SpraysResponse {
  int status;
  List<SprayData> data;

  SpraysResponse({
    required this.status,
    required this.data,
  });

  factory SpraysResponse.fromJson(Map<String, dynamic> json) => SpraysResponse(
        status: json['status'],
        data: List<SprayData>.from(json['data'].map((x) => SprayData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SprayData {
  String uuid;
  String displayName;
  dynamic category;
  dynamic themeUuid;
  bool isNullSpray;
  bool hideIfNotOwned;
  String displayIcon;
  String fullIcon;
  String fullTransparentIcon;
  dynamic animationPng;
  dynamic animationGif;
  String assetPath;
  List<Level> levels;

  SprayData({
    required this.uuid,
    required this.displayName,
    required this.category,
    required this.themeUuid,
    required this.isNullSpray,
    required this.hideIfNotOwned,
    required this.displayIcon,
    required this.fullIcon,
    required this.fullTransparentIcon,
    required this.animationPng,
    required this.animationGif,
    required this.assetPath,
    required this.levels,
  });

  factory SprayData.fromJson(Map<String, dynamic> json) => SprayData(
        uuid: json['uuid'],
        displayName: json['displayName'],
        category: json['category'],
        themeUuid: json['themeUuid'],
        isNullSpray: json['isNullSpray'],
        hideIfNotOwned: json['hideIfNotOwned'],
        displayIcon: json['displayIcon'],
        fullIcon: json['fullIcon'] ?? "",
        fullTransparentIcon: json['fullTransparentIcon'] ?? "",
        animationPng: json['animationPng'] ?? "",
        animationGif: json['animationGif'] ?? "",
        assetPath: json['assetPath'] ?? "",
        levels: List<Level>.from(json['levels'].map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'category': category,
        'themeUuid': themeUuid,
        'isNullSpray': isNullSpray,
        'hideIfNotOwned': hideIfNotOwned,
        'displayIcon': displayIcon,
        'fullIcon': fullIcon,
        'fullTransparentIcon': fullTransparentIcon,
        'animationPng': animationPng,
        'animationGif': animationGif,
        'assetPath': assetPath,
        'levels': List<dynamic>.from(levels.map((x) => x.toJson())),
      };
}

class Level {
  String uuid;
  int sprayLevel;
  String displayName;
  String displayIcon;
  String assetPath;

  Level({
    required this.uuid,
    required this.sprayLevel,
    required this.displayName,
    required this.displayIcon,
    required this.assetPath,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        uuid: json['uuid'] ?? "",
        sprayLevel: json['sprayLevel'] ?? "",
        displayName: json['displayName'] ?? "",
        displayIcon: json['displayIcon'] ?? "",
        assetPath: json['assetPath'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'sprayLevel': sprayLevel,
        'displayName': displayName,
        'displayIcon': displayIcon,
        'assetPath': assetPath,
      };
}
