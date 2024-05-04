class PlayerCardsResponse {
  int status;
  List<PlayerCardData> data;

  PlayerCardsResponse({
    required this.status,
    required this.data,
  });

  factory PlayerCardsResponse.fromJson(Map<String, dynamic> json) =>
      PlayerCardsResponse(
        status: json['status'],
        data: List<PlayerCardData>.from(
            json['data'].map((x) => PlayerCardData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PlayerCardData {
  String uuid;
  String displayName;
  bool isHiddenIfNotOwned;
  dynamic themeUuid;
  String displayIcon;
  String smallArt;
  String wideArt;
  String largeArt;
  String assetPath;

  PlayerCardData({
    required this.uuid,
    required this.displayName,
    required this.isHiddenIfNotOwned,
    required this.themeUuid,
    required this.displayIcon,
    required this.smallArt,
    required this.wideArt,
    required this.largeArt,
    required this.assetPath,
  });

  factory PlayerCardData.fromJson(Map<String, dynamic> json) => PlayerCardData(
        uuid: json['uuid'],
        displayName: json['displayName'],
        isHiddenIfNotOwned: json['isHiddenIfNotOwned'],
        themeUuid: json['themeUuid'],
        displayIcon: json['displayIcon'],
        smallArt: json['smallArt'],
        wideArt: json['wideArt'],
        largeArt: json['largeArt'],
        assetPath: json['assetPath'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'isHiddenIfNotOwned': isHiddenIfNotOwned,
        'themeUuid': themeUuid,
        'displayIcon': displayIcon,
        'smallArt': smallArt,
        'wideArt': wideArt,
        'largeArt': largeArt,
        'assetPath': assetPath,
      };
}
