class BundlesResponse {
  int status;
  List<Bundle> data;

  BundlesResponse({
    required this.status,
    required this.data,
  });

  factory BundlesResponse.fromJson(Map<String, dynamic> json) => BundlesResponse(
        status: json['status'],
        data: List<Bundle>.from(json['data'].map((x) => Bundle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Bundle {
  String uuid;
  String displayName;
  String? displayNameSubText;
  String description;
  String? extraDescription;
  String? promoDescription;
  bool useAdditionalContext;
  String displayIcon;
  String displayIcon2;
  String? logoIcon;
  String verticalPromoImage;
  String assetPath;

  Bundle({
    required this.uuid,
    required this.displayName,
    this.displayNameSubText,
    required this.description,
    this.extraDescription,
    this.promoDescription,
    required this.useAdditionalContext,
    required this.displayIcon,
    required this.displayIcon2,
    this.logoIcon,
    required this.verticalPromoImage,
    required this.assetPath,
  });

  factory Bundle.fromJson(Map<String, dynamic> json) => Bundle(
        uuid: json['uuid'],
        displayName: json['displayName'],
        displayNameSubText: json['displayNameSubText'] ?? "",
        description: json['description']?? "",
        extraDescription: json['extraDescription'] ?? "",
        promoDescription: json['promoDescription'] ?? "",
        useAdditionalContext: json['useAdditionalContext'] ?? "",
        displayIcon: json['displayIcon'] ?? "",
        displayIcon2: json['displayIcon2'] ?? "",
        logoIcon: json['logoIcon'] ?? "",
        verticalPromoImage: json['verticalPromoImage'] ?? "",
        assetPath: json['assetPath'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'displayNameSubText': displayNameSubText,
        'description': description,
        'extraDescription': extraDescription,
        'promoDescription': promoDescription,
        'useAdditionalContext': useAdditionalContext,
        'displayIcon': displayIcon,
        'displayIcon2': displayIcon2,
        'logoIcon': logoIcon,
        'verticalPromoImage': verticalPromoImage,
        'assetPath': assetPath,
      };
}
