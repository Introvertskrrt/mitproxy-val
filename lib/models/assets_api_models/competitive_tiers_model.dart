class CompetitiveTiersResponse {
  int status;
  List<CompetitiveTier> data;

  CompetitiveTiersResponse({
    required this.status,
    required this.data,
  });

  factory CompetitiveTiersResponse.fromJson(Map<String, dynamic> json) =>
      CompetitiveTiersResponse(
        status: json['status'],
        data: List<CompetitiveTier>.from(
            json['data'].map((x) => CompetitiveTier.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CompetitiveTier {
  String uuid;
  String assetObjectName;
  List<Tier> tiers;

  CompetitiveTier({
    required this.uuid,
    required this.assetObjectName,
    required this.tiers,
  });

  factory CompetitiveTier.fromJson(Map<String, dynamic> json) => CompetitiveTier(
        uuid: json['uuid'],
        assetObjectName: json['assetObjectName'],
        tiers: List<Tier>.from(json['tiers'].map((x) => Tier.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'assetObjectName': assetObjectName,
        'tiers': List<dynamic>.from(tiers.map((x) => x.toJson())),
      };
}

class Tier {
  int tier;
  String tierName;
  String division;
  String divisionName;
  String color;
  String backgroundColor;
  String? smallIcon;
  String? largeIcon;
  dynamic rankTriangleDownIcon;
  dynamic rankTriangleUpIcon;

  Tier({
    required this.tier,
    required this.tierName,
    required this.division,
    required this.divisionName,
    required this.color,
    required this.backgroundColor,
    this.smallIcon,
    this.largeIcon,
    this.rankTriangleDownIcon,
    this.rankTriangleUpIcon,
  });

  factory Tier.fromJson(Map<String, dynamic> json) => Tier(
        tier: json['tier'],
        tierName: json['tierName'],
        division: json['division'],
        divisionName: json['divisionName'],
        color: json['color'],
        backgroundColor: json['backgroundColor'],
        smallIcon: json['smallIcon'],
        largeIcon: json['largeIcon'],
        rankTriangleDownIcon: json['rankTriangleDownIcon'],
        rankTriangleUpIcon: json['rankTriangleUpIcon'],
      );

  Map<String, dynamic> toJson() => {
        'tier': tier,
        'tierName': tierName,
        'division': division,
        'divisionName': divisionName,
        'color': color,
        'backgroundColor': backgroundColor,
        'smallIcon': smallIcon,
        'largeIcon': largeIcon,
        'rankTriangleDownIcon': rankTriangleDownIcon,
        'rankTriangleUpIcon': rankTriangleUpIcon,
      };
}
