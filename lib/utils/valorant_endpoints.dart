// ignore_for_file: non_constant_identifier_names

import 'package:mitproxy_val/utils/globals.dart';

class ValorantEndpoints{
  static String GLZ_URL = "https://glz-${Globals.accountToken!.region}-1.${Globals.accountToken!.shard}.a.pvp.net";
  static String PD_URL = "https://pd.${Globals.accountToken!.shard}.a.pvp.net";
  static dynamic RIOT_HEADERS = {
    'X-Riot-ClientPlatform': Globals.accountToken!.clientPlatform,
    'X-Riot-ClientVersion': Globals.accountToken!.clientVersion,
    'X-Riot-Entitlements-JWT': Globals.accountToken!.entitlementsToken,
    'Authorization': 'Bearer ${Globals.accountToken!.authToken}'
  };

  void updateEndpoints() {
    GLZ_URL = "https://glz-${Globals.accountToken!.region}-1.${Globals.accountToken!.shard}.a.pvp.net";
    PD_URL = "https://pd.${Globals.accountToken!.shard}.a.pvp.net";
    RIOT_HEADERS = {
      'X-Riot-ClientPlatform': Globals.accountToken!.clientPlatform,
      'X-Riot-ClientVersion': Globals.accountToken!.clientVersion,
      'X-Riot-Entitlements-JWT': Globals.accountToken!.entitlementsToken,
      'Authorization': 'Bearer ${Globals.accountToken!.authToken}'
    };
  }
}