// ignore_for_file: non_constant_identifier_names

import 'package:mitproxy_val/utils/cache.dart';

class ValorantEndpoints{
  static String GLZ_URL = "https://glz-${Cache.accountToken!.region}-1.${Cache.accountToken!.shard}.a.pvp.net";
  static String PD_URL = "https://pd.${Cache.accountToken!.shard}.a.pvp.net";
  static dynamic RIOT_HEADERS = {
    'X-Riot-ClientPlatform': Cache.accountToken!.clientPlatform,
    'X-Riot-ClientVersion': Cache.accountToken!.clientVersion,
    'X-Riot-Entitlements-JWT': Cache.accountToken!.entitlementsToken,
    'Authorization': 'Bearer ${Cache.accountToken!.authToken}'
  };

  void updateEndpoints() {
    GLZ_URL = "https://glz-${Cache.accountToken!.region}-1.${Cache.accountToken!.shard}.a.pvp.net";
    PD_URL = "https://pd.${Cache.accountToken!.shard}.a.pvp.net";
    RIOT_HEADERS = {
      'X-Riot-ClientPlatform': Cache.accountToken!.clientPlatform,
      'X-Riot-ClientVersion': Cache.accountToken!.clientVersion,
      'X-Riot-Entitlements-JWT': Cache.accountToken!.entitlementsToken,
      'Authorization': 'Bearer ${Cache.accountToken!.authToken}'
    };
  }
}