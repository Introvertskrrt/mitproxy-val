class WeaponSkinsResponse {
  int status;
  List<WeaponSkinData> data;

  WeaponSkinsResponse({
    required this.status,
    required this.data,
  });

  factory WeaponSkinsResponse.fromJson(Map<String, dynamic> json) => WeaponSkinsResponse(
        status: json['status'],
        data: List<WeaponSkinData>.from(json['data'].map((x) => WeaponSkinData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WeaponSkinData {
  String uuid;
  String displayName;
  String? themeUuid;
  String? contentTierUuid;
  String? displayIcon;
  String? wallpaper;
  String assetPath;
  List<Chroma> chromas;
  List<Level> levels;

  WeaponSkinData({
    required this.uuid,
    required this.displayName,
    this.themeUuid,
    this.contentTierUuid,
    required this.displayIcon,
    this.wallpaper,
    required this.assetPath,
    required this.chromas,
    required this.levels,
  });

  factory WeaponSkinData.fromJson(Map<String, dynamic> json) => WeaponSkinData(
        uuid: json['uuid'],
        displayName: json['displayName'],
        themeUuid: json['themeUuid'],
        contentTierUuid: json['contentTierUuid'],
        displayIcon: json['displayIcon'],
        wallpaper: json['wallpaper'],
        assetPath: json['assetPath'],
        chromas: List<Chroma>.from(json['chromas'].map((x) => Chroma.fromJson(x))),
        levels: List<Level>.from(json['levels'].map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'themeUuid': themeUuid,
        'contentTierUuid': contentTierUuid,
        'displayIcon': displayIcon,
        'wallpaper': wallpaper,
        'assetPath': assetPath,
        'chromas': List<dynamic>.from(chromas.map((x) => x.toJson())),
        'levels': List<dynamic>.from(levels.map((x) => x.toJson())),
      };
}

class Chroma {
  String uuid;
  String displayName;
  String? displayIcon;
  String fullRender;
  String? swatch;
  String? streamedVideo;
  String assetPath;

  Chroma({
    required this.uuid,
    required this.displayName,
    this.displayIcon,
    required this.fullRender,
    this.swatch,
    this.streamedVideo,
    required this.assetPath,
  });

  factory Chroma.fromJson(Map<String, dynamic> json) => Chroma(
        uuid: json['uuid'],
        displayName: json['displayName'],
        displayIcon: json['displayIcon'],
        fullRender: json['fullRender'],
        swatch: json['swatch'],
        streamedVideo: json['streamedVideo'],
        assetPath: json['assetPath'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'displayIcon': displayIcon,
        'fullRender': fullRender,
        'swatch': swatch,
        'streamedVideo': streamedVideo,
        'assetPath': assetPath,
      };
}

class Level {
  String uuid;
  String displayName;
  String? levelItem;
  String? displayIcon;
  String? streamedVideo;
  String assetPath;

  Level({
    required this.uuid,
    required this.displayName,
    this.levelItem,
    this.displayIcon,
    this.streamedVideo,
    required this.assetPath,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        uuid: json['uuid'],
        displayName: json['displayName'],
        levelItem: json['levelItem'],
        displayIcon: json['displayIcon'],
        streamedVideo: json['streamedVideo'],
        assetPath: json['assetPath'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'levelItem': levelItem,
        'displayIcon': displayIcon,
        'streamedVideo': streamedVideo,
        'assetPath': assetPath,
      };
}
