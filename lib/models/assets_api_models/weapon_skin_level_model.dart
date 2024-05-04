class WeaponSkinLevelsResponse {
  int status;
  List<WeaponSkinLevelData> data;

  WeaponSkinLevelsResponse({
    required this.status,
    required this.data,
  });

  factory WeaponSkinLevelsResponse.fromJson(Map<String, dynamic> json) => WeaponSkinLevelsResponse(
        status: json['status'],
        data: List<WeaponSkinLevelData>.from(json['data'].map((x) => WeaponSkinLevelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WeaponSkinLevelData {
  String uuid;
  String displayName;
  String? levelItem;
  String? displayIcon;
  String? streamedVideo;
  String assetPath;

  WeaponSkinLevelData({
    required this.uuid,
    required this.displayName,
    this.levelItem,
    this.displayIcon,
    this.streamedVideo,
    required this.assetPath,
  });

  factory WeaponSkinLevelData.fromJson(Map<String, dynamic> json) => WeaponSkinLevelData(
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
