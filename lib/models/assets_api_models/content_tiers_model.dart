class ContentTiersResponse {
  int status;
  List<ContentTier> data;

  ContentTiersResponse({
    required this.status,
    required this.data,
  });

  factory ContentTiersResponse.fromJson(Map<String, dynamic> json) =>
      ContentTiersResponse(
        status: json['status'],
        data: List<ContentTier>.from(
            json['data'].map((x) => ContentTier.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ContentTier {
  String uuid;
  String displayName;
  String devName;
  int rank;
  int juiceValue;
  int juiceCost;
  String highlightColor;
  String displayIcon;
  String assetPath;

  ContentTier({
    required this.uuid,
    required this.displayName,
    required this.devName,
    required this.rank,
    required this.juiceValue,
    required this.juiceCost,
    required this.highlightColor,
    required this.displayIcon,
    required this.assetPath,
  });

  factory ContentTier.fromJson(Map<String, dynamic> json) => ContentTier(
        uuid: json['uuid'],
        displayName: json['displayName'],
        devName: json['devName'],
        rank: json['rank'],
        juiceValue: json['juiceValue'],
        juiceCost: json['juiceCost'],
        highlightColor: json['highlightColor'],
        displayIcon: json['displayIcon'],
        assetPath: json['assetPath'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'devName': devName,
        'rank': rank,
        'juiceValue': juiceValue,
        'juiceCost': juiceCost,
        'highlightColor': highlightColor,
        'displayIcon': displayIcon,
        'assetPath': assetPath,
      };
}
