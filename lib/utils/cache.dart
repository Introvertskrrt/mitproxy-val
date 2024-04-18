import 'package:mitproxy_val/models/account_model.dart';
import 'package:mitproxy_val/models/match_model.dart';
import 'package:mitproxy_val/models/party_model.dart';
import 'package:mitproxy_val/models/store_model.dart';

class Cache{
  static AccountToken? accountToken;
  static PlayerProfile? playerProfile;
  static Bundle? bundleData;
  static DailyOffers? dailyOffers;
  static PartyMembers? partyMembers;
  static CurrentMatch? currentMatch;
  static AllyTeam? allyTeam;
  static EnemyTeam? enemyTeam;
}