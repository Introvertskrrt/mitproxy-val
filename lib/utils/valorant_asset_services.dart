import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mitproxy_val/models/assets_api_models/agent_model.dart';
import 'package:mitproxy_val/models/assets_api_models/buddies_model.dart';
import 'package:mitproxy_val/models/assets_api_models/bundle_model.dart';
import 'package:mitproxy_val/models/assets_api_models/competitive_tiers_model.dart';
import 'package:mitproxy_val/models/assets_api_models/content_tiers_model.dart';
import 'package:mitproxy_val/models/assets_api_models/mission_model.dart';
import 'package:mitproxy_val/models/assets_api_models/map_model.dart';
import 'package:mitproxy_val/models/assets_api_models/playercard_model.dart';
import 'package:mitproxy_val/models/assets_api_models/season_model.dart';
import 'package:mitproxy_val/models/assets_api_models/spray_model.dart';
import 'package:mitproxy_val/models/assets_api_models/weapon_skin_level_model.dart';
import 'package:mitproxy_val/models/assets_api_models/weapon_skin_model.dart';

class ValorantAssetServices {
  static Future<AgentsResponse> getAgentsData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/agents'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return AgentsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load AgentsResponse');
    }
  }

  static Future<BuddiesResponse> getBuddiesData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/buddies'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return BuddiesResponse.fromJson(data);
    } else {
      throw Exception('Failed to load BuddiesResponse');
    }
  }

  static Future<BundlesResponse> getBundleData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/bundles'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return BundlesResponse.fromJson(data);
    } else {
      throw Exception('Failed to load BundlesResponse');
    }
  }

  static Future<CompetitiveTiersResponse> getCompetitiveTiersData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/competitivetiers'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return CompetitiveTiersResponse.fromJson(data);
    } else {
      throw Exception('Failed to load CompetitiveTiersResponse');
    }
  }

  static Future<ContentTiersResponse> getContentTiersData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/contenttiers'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return ContentTiersResponse.fromJson(data);
    } else {
      throw Exception('Failed to load ContentTiersResponse');
    }
  }

  static Future<MissionsResponse> getMissionsData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/missions'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return MissionsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load MissionsResponse');
    }
  }

  static Future<MapsResponse> getMapData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/maps'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return MapsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load MapsResponse');
    }
  }

  static Future<PlayerCardsResponse> getPlayerCardsData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/playercards'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return PlayerCardsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load PlayerCardsResponse');
    }
  }

  static Future<SpraysResponse> getSpraysData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/sprays'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return SpraysResponse.fromJson(data);
    } else {
      throw Exception('Failed to load SpraysResponse');
    }
  }

  static Future<WeaponSkinsResponse> getWeaponSkinsData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/weapons/skins'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return WeaponSkinsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load WeaponSkinsResponse');
    }
  }

  static Future<WeaponSkinLevelsResponse> getWeaponSkinlevelsData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/weapons/skinlevels'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return WeaponSkinLevelsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load WeaponSkinLevelsResponse');
    }
  }

  static Future<SeasonsResponse> getSeasonsData() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/seasons'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return SeasonsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load SeasonsResponse');
    }
  }

}