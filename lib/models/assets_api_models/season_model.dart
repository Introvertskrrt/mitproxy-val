class SeasonsResponse {
  int status;
  List<SeasonData> data;

  SeasonsResponse({
    required this.status,
    required this.data,
  });

  factory SeasonsResponse.fromJson(Map<String, dynamic> json) => SeasonsResponse(
        status: json['status'],
        data: List<SeasonData>.from(json['data'].map((x) => SeasonData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SeasonData {
  String uuid;
  String displayName;
  String? type;
  DateTime startTime;
  DateTime endTime;
  String? parentUuid;
  String assetPath;

  SeasonData({
    required this.uuid,
    required this.displayName,
    this.type,
    required this.startTime,
    required this.endTime,
    this.parentUuid,
    required this.assetPath,
  });

  factory SeasonData.fromJson(Map<String, dynamic> json) => SeasonData(
        uuid: json['uuid'],
        displayName: json['displayName'],
        type: json['type'],
        startTime: DateTime.parse(json['startTime']),
        endTime: DateTime.parse(json['endTime']),
        parentUuid: json['parentUuid'],
        assetPath: json['assetPath'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'type': type,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'parentUuid': parentUuid,
        'assetPath': assetPath,
      };
}
