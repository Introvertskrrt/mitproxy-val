// docs: https://valapidocs.techchrism.me/endpoint/current-game-player
class CurrentGamePlayerResponse {
  final String subject;
  final String matchID;
  final int version;

  CurrentGamePlayerResponse({
    required this.subject,
    required this.matchID,
    required this.version,
  });

  factory CurrentGamePlayerResponse.fromJson(Map<String, dynamic> json) {
    return CurrentGamePlayerResponse(
      subject: json['Subject'] ?? "",
      matchID: json['MatchID'] ?? "",
      version: json['Version'] ?? 0,
    );
  }
}
