import 'package:mitproxy_val/models/account_model.dart';
import 'package:mitproxy_val/models/player_search_model.dart';
import 'package:mitproxy_val/models/store_model.dart';

class Cache{
  static TemporarySavedAccount? temporarySavedAccount;
  static AccountToken? accountToken;
  static PlayerProfile? playerProfile;
  static Bundle? bundleData;
  static DailyOffers? dailyOffers;
  static TargetPlayerMmr? targetPlayerMmr;
  static TargetPlayerHistory? targetPlayerHistory;
}