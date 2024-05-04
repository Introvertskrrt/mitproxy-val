// docs: https://valapidocs.techchrism.me/endpoint/pre-game-player
class PreGamePlayerResponse {
  String subject;
  String matchID;
  int version;

  PreGamePlayerResponse({
    required this.subject,
    required this.matchID,
    required this.version,
  });

  factory PreGamePlayerResponse.fromJson(Map<String, dynamic> json) {
    return PreGamePlayerResponse(
      subject: json['Subject'] ?? '',
      matchID: json['MatchID'] ?? '',
      version: json['Version'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subject': subject,
      'MatchID': matchID,
      'Version': version,
    };
  }
}