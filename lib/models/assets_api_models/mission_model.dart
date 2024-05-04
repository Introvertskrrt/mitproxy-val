class MissionsResponse {
  int status;
  List<MissionData> data;

  MissionsResponse({required this.status, required this.data});

  factory MissionsResponse.fromJson(Map<String, dynamic> json) {
    return MissionsResponse(
      status: json['status'],
      data: List<MissionData>.from(json['data'].map((x) => MissionData.fromJson(x))),
    );
  }
}

class MissionData {
  String uuid;
  String? displayName;
  String? title;
  String? type;
  int xpGrant;
  int progressToComplete;
  String activationDate;
  String expirationDate;
  List<String>? tags;
  List<Objective>? objectives;
  String assetPath;

  MissionData({
    required this.uuid,
    this.displayName,
    this.title,
    this.type,
    required this.xpGrant,
    required this.progressToComplete,
    required this.activationDate,
    required this.expirationDate,
    this.tags,
    this.objectives,
    required this.assetPath,
  });

  factory MissionData.fromJson(Map<String, dynamic> json) {
    return MissionData(
      uuid: json['uuid'],
      displayName: json['displayName'],
      title: json['title'],
      type: json['type'],
      xpGrant: json['xpGrant'],
      progressToComplete: json['progressToComplete'],
      activationDate: json['activationDate'],
      expirationDate: json['expirationDate'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      objectives: json['objectives'] != null
          ? List<Objective>.from(json['objectives'].map((x) => Objective.fromJson(x)))
          : null,
      assetPath: json['assetPath'],
    );
  }
}

class Objective {
  String objectiveUuid;
  int value;

  Objective({
    required this.objectiveUuid,
    required this.value,
  });

  factory Objective.fromJson(Map<String, dynamic> json) {
    return Objective(
      objectiveUuid: json['objectiveUuid'],
      value: json['value'],
    );
  }
}
