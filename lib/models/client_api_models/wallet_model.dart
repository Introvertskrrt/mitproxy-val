// docs: https://valapidocs.techchrism.me/endpoint/wallet
class WalletData {
  late int valorantPoint;
  late int radianite;
  late int kingdomCredits;

  WalletData({
    required this.valorantPoint,
    required this.radianite,
    required this.kingdomCredits,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) {
    return WalletData(
      valorantPoint: json['Balances']['85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741'] ?? 0,
      radianite: json['Balances']['e59aa87c-4cbf-517a-5983-6e81511be9b7'] ?? 0,
      kingdomCredits: json['Balances']['85ca954a-41f2-ce94-9b45-8ca3dd39a00d'] ?? 0,
    );
  }
}