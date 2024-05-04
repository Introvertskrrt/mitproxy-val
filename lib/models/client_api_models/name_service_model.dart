// docs: https://valapidocs.techchrism.me/endpoint/name-service
class NameServiceResponse {
  String displayName;
  String subject;
  String gameName;
  String tagLine;

  NameServiceResponse({
    required this.displayName,
    required this.subject,
    required this.gameName,
    required this.tagLine,
  });

  factory NameServiceResponse.fromJson(Map<String, dynamic> json) {
    return NameServiceResponse(
      displayName: json['DisplayName'] ?? '',
      subject: json['Subject'] ?? '',
      gameName: json['GameName'] ?? '',
      tagLine: json['TagLine'] ?? '',
    );
  }
}