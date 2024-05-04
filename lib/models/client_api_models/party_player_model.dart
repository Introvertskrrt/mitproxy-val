// docs: https://valapidocs.techchrism.me/endpoint/party-player
class PartyPlayerResponse {
  String subject;
  int version;
  String currentPartyID;
  List<PartyRequest> requests;
  PlatformInfo platformInfo;

  PartyPlayerResponse({
    required this.subject,
    required this.version,
    required this.currentPartyID,
    required this.requests,
    required this.platformInfo,
  });

  factory PartyPlayerResponse.fromJson(Map<String, dynamic> json) {
    return PartyPlayerResponse(
      subject: json['Subject'] ?? '',
      version: json['Version'] ?? 0,
      currentPartyID: json['CurrentPartyID'] ?? '',
      requests: (json['Requests'] as List<dynamic>?)
          ?.map((item) => PartyRequest.fromJson(item))
          .toList() ?? [],
      platformInfo: PlatformInfo.fromJson(json['PlatformInfo'] ?? {}),
    );
  }
}

class PartyRequest {
  String id;
  String partyID;
  String requestedBySubject;
  List<String> subjects;
  String createdAt;
  String refreshedAt;
  int expiresIn;

  PartyRequest({
    required this.id,
    required this.partyID,
    required this.requestedBySubject,
    required this.subjects,
    required this.createdAt,
    required this.refreshedAt,
    required this.expiresIn,
  });

  factory PartyRequest.fromJson(Map<String, dynamic> json) {
    return PartyRequest(
      id: json['ID'] ?? '',
      partyID: json['PartyID'] ?? '',
      requestedBySubject: json['RequestedBySubject'] ?? '',
      subjects: (json['Subjects'] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      createdAt: json['CreatedAt'] ?? '',
      refreshedAt: json['RefreshedAt'] ?? '',
      expiresIn: json['ExpiresIn'] ?? 0,
    );
  }
}

class PlatformInfo {
  String platformType;
  String platformOS;
  String platformOSVersion;
  String platformChipset;

  PlatformInfo({
    required this.platformType,
    required this.platformOS,
    required this.platformOSVersion,
    required this.platformChipset,
  });

  factory PlatformInfo.fromJson(Map<String, dynamic> json) {
    return PlatformInfo(
      platformType: json['platformType'] ?? '',
      platformOS: json['platformOS'] ?? '',
      platformOSVersion: json['platformOSVersion'] ?? '',
      platformChipset: json['platformChipset'] ?? '',
    );
  }
}