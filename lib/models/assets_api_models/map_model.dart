class MapsResponse {
  int status;
  List<MapData> data;

  MapsResponse({
    required this.status,
    required this.data,
  });

  factory MapsResponse.fromJson(Map<String, dynamic> json) => MapsResponse(
        status: json['status'],
        data: List<MapData>.from(json['data'].map((x) => MapData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MapData {
  String uuid;
  String displayName;
  dynamic narrativeDescription;
  String tacticalDescription;
  String coordinates;
  String displayIcon;
  String listViewIcon;
  String listViewIconTall;
  String splash;
  String stylizedBackgroundImage;
  String premierBackgroundImage;
  String assetPath;
  String mapUrl;
  double xMultiplier;
  double yMultiplier;
  double xScalarToAdd;
  double yScalarToAdd;

  MapData({
    required this.uuid,
    required this.displayName,
    required this.narrativeDescription,
    required this.tacticalDescription,
    required this.coordinates,
    required this.displayIcon,
    required this.listViewIcon,
    required this.listViewIconTall,
    required this.splash,
    required this.stylizedBackgroundImage,
    required this.premierBackgroundImage,
    required this.assetPath,
    required this.mapUrl,
    required this.xMultiplier,
    required this.yMultiplier,
    required this.xScalarToAdd,
    required this.yScalarToAdd,
  });

  factory MapData.fromJson(Map<String, dynamic> json) => MapData(
        uuid: json['uuid'],
        displayName: json['displayName'],
        narrativeDescription: json['narrativeDescription'] ?? "",
        tacticalDescription: json['tacticalDescription'] ?? "",
        coordinates: json['coordinates'] ?? "",
        displayIcon: json['displayIcon'] ?? "",
        listViewIcon: json['listViewIcon'] ?? "",
        listViewIconTall: json['listViewIconTall'] ?? "",
        splash: json['splash'] ?? "",
        stylizedBackgroundImage: json['stylizedBackgroundImage'] ?? "",
        premierBackgroundImage: json['premierBackgroundImage'] ?? "",
        assetPath: json['assetPath'] ?? "",
        mapUrl: json['mapUrl'] ?? "",
        xMultiplier: json['xMultiplier'].toDouble(),
        yMultiplier: json['yMultiplier'].toDouble(),
        xScalarToAdd: json['xScalarToAdd'].toDouble(),
        yScalarToAdd: json['yScalarToAdd'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'narrativeDescription': narrativeDescription,
        'tacticalDescription': tacticalDescription,
        'coordinates': coordinates,
        'displayIcon': displayIcon,
        'listViewIcon': listViewIcon,
        'listViewIconTall': listViewIconTall,
        'splash': splash,
        'stylizedBackgroundImage': stylizedBackgroundImage,
        'premierBackgroundImage': premierBackgroundImage,
        'assetPath': assetPath,
        'mapUrl': mapUrl,
        'xMultiplier': xMultiplier,
        'yMultiplier': yMultiplier,
        'xScalarToAdd': xScalarToAdd,
        'yScalarToAdd': yScalarToAdd,
      };
}

class Callout {
  String regionName;
  String superRegionName;
  Location location;

  Callout({
    required this.regionName,
    required this.superRegionName,
    required this.location,
  });

  factory Callout.fromJson(Map<String, dynamic> json) => Callout(
        regionName: json['regionName'],
        superRegionName: json['superRegionName'],
        location: Location.fromJson(json['location']),
      );

  Map<String, dynamic> toJson() => {
        'regionName': regionName,
        'superRegionName': superRegionName,
        'location': location.toJson(),
      };
}

class Location {
  double x;
  double y;

  Location({
    required this.x,
    required this.y,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        x: json['x'].toDouble(),
        y: json['y'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };
}
