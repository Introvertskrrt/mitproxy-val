// docs: https://valapidocs.techchrism.me/endpoint/storefront
class StorefrontResponse {
  FeaturedBundle featuredBundle;
  SkinsPanelLayout skinsPanelLayout;
  UpgradeCurrencyStore upgradeCurrencyStore;
  AccessoryStore accessoryStore;
  BonusStore? bonusStore;

  StorefrontResponse({
    required this.featuredBundle,
    required this.skinsPanelLayout,
    required this.upgradeCurrencyStore,
    required this.accessoryStore,
    this.bonusStore,
  });

  factory StorefrontResponse.fromJson(Map<String, dynamic> json) =>
      StorefrontResponse(
        featuredBundle: FeaturedBundle.fromJson(json['FeaturedBundle']),
        skinsPanelLayout:
            SkinsPanelLayout.fromJson(json['SkinsPanelLayout']),
        upgradeCurrencyStore:
            UpgradeCurrencyStore.fromJson(json['UpgradeCurrencyStore']),
        accessoryStore: AccessoryStore.fromJson(json['AccessoryStore']),
        bonusStore: json['BonusStore'] != null
            ? BonusStore.fromJson(json['BonusStore'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'FeaturedBundle': featuredBundle.toJson(),
        'SkinsPanelLayout': skinsPanelLayout.toJson(),
        'UpgradeCurrencyStore': upgradeCurrencyStore.toJson(),
        'AccessoryStore': accessoryStore.toJson(),
        'BonusStore': bonusStore?.toJson(),
      };
}

class FeaturedBundle {
  Bundle bundle;
  List<Bundles> bundles;
  int bundleRemainingDurationInSeconds;

  FeaturedBundle({
    required this.bundle,
    required this.bundles,
    required this.bundleRemainingDurationInSeconds,
  });

  factory FeaturedBundle.fromJson(Map<String, dynamic> json) => FeaturedBundle(
        bundle: Bundle.fromJson(json['Bundle']),
        bundles:
            List<Bundles>.from(json['Bundles'].map((x) => Bundles.fromJson(x))),
        bundleRemainingDurationInSeconds:
            json['BundleRemainingDurationInSeconds'],
      );

  Map<String, dynamic> toJson() => {
        'Bundle': bundle.toJson(),
        'Bundles': List<dynamic>.from(bundles.map((x) => x.toJson())),
        'BundleRemainingDurationInSeconds': bundleRemainingDurationInSeconds,
      };
}

class Bundle {
  String id;
  String dataAssetID;
  String currencyID;
  List<Items> items;
  List<ItemOffers>? itemOffers;
  Map<String, dynamic>? totalBaseCost;
  Map<String, dynamic>? totalDiscountedCost;
  int totalDiscountPercent;
  int durationRemainingInSeconds;
  bool wholesaleOnly;

  Bundle({
    required this.id,
    required this.dataAssetID,
    required this.currencyID,
    required this.items,
    this.itemOffers,
    this.totalBaseCost,
    this.totalDiscountedCost,
    required this.totalDiscountPercent,
    required this.durationRemainingInSeconds,
    required this.wholesaleOnly,
  });

  factory Bundle.fromJson(Map<String, dynamic> json) => Bundle(
        id: json['ID'],
        dataAssetID: json['DataAssetID'],
        currencyID: json['CurrencyID'],
        items: List<Items>.from(json['Items'].map((x) => Items.fromJson(x))),
        itemOffers: json['ItemOffers'] != null
            ? List<ItemOffers>.from(
                json['ItemOffers'].map((x) => ItemOffers.fromJson(x)))
            : null,
        totalBaseCost: json['TotalBaseCost'],
        totalDiscountedCost: json['TotalDiscountedCost'],
        totalDiscountPercent: json['TotalDiscountPercent'],
        durationRemainingInSeconds: json['DurationRemainingInSeconds'],
        wholesaleOnly: json['WholesaleOnly'],
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'DataAssetID': dataAssetID,
        'CurrencyID': currencyID,
        'Items': List<dynamic>.from(items.map((x) => x.toJson())),
        'ItemOffers': itemOffers != null
            ? List<dynamic>.from(itemOffers!.map((x) => x.toJson()))
            : null,
        'TotalBaseCost': totalBaseCost,
        'TotalDiscountedCost': totalDiscountedCost,
        'TotalDiscountPercent': totalDiscountPercent,
        'DurationRemainingInSeconds': durationRemainingInSeconds,
        'WholesaleOnly': wholesaleOnly,
      };
}

class Bundles {
  String id;
  String dataAssetID;
  String currencyID;
  List<Items> items;
  List<ItemOffers>? itemOffers;
  Map<String, dynamic>? totalBaseCost;
  Map<String, dynamic>? totalDiscountedCost;
  double totalDiscountPercent;
  int durationRemainingInSeconds;
  bool wholesaleOnly;

  Bundles({
    required this.id,
    required this.dataAssetID,
    required this.currencyID,
    required this.items,
    this.itemOffers,
    this.totalBaseCost,
    this.totalDiscountedCost,
    required this.totalDiscountPercent,
    required this.durationRemainingInSeconds,
    required this.wholesaleOnly,
  });

  factory Bundles.fromJson(Map<String, dynamic> json) => Bundles(
        id: json['ID'],
        dataAssetID: json['DataAssetID'],
        currencyID: json['CurrencyID'],
        items: List<Items>.from(json['Items'].map((x) => Items.fromJson(x))),
        itemOffers: json['ItemOffers'] != null
            ? List<ItemOffers>.from(
                json['ItemOffers'].map((x) => ItemOffers.fromJson(x)))
            : null,
        totalBaseCost: json['TotalBaseCost'],
        totalDiscountedCost: json['TotalDiscountedCost'],
        totalDiscountPercent: json['TotalDiscountPercent'],
        durationRemainingInSeconds: json['DurationRemainingInSeconds'],
        wholesaleOnly: json['WholesaleOnly'],
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'DataAssetID': dataAssetID,
        'CurrencyID': currencyID,
        'Items': List<dynamic>.from(items.map((x) => x.toJson())),
        'ItemOffers': itemOffers != null
            ? List<dynamic>.from(itemOffers!.map((x) => x.toJson()))
            : null,
        'TotalBaseCost': totalBaseCost,
        'TotalDiscountedCost': totalDiscountedCost,
        'TotalDiscountPercent': totalDiscountPercent,
        'DurationRemainingInSeconds': durationRemainingInSeconds,
        'WholesaleOnly': wholesaleOnly,
      };
}

class Items {
  String itemTypeID;
  String itemID;
  int amount;
  int basePrice;
  String currencyID;
  int discountPercent;
  int discountedPrice;
  bool isPromoItem;

  Items({
    required this.itemTypeID,
    required this.itemID,
    required this.amount,
    required this.basePrice,
    required this.currencyID,
    required this.discountPercent,
    required this.discountedPrice,
    required this.isPromoItem,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        itemTypeID: json['ItemTypeID'] ?? "",
        itemID: json['ItemID'] ?? "",
        amount: json['Amount'] ?? 0,
        basePrice: json['BasePrice'] ?? 0,
        currencyID: json['CurrencyID'] ?? "",
        discountPercent: json['DiscountPercent'] ?? 0,
        discountedPrice: json['DiscountedPrice'] ?? 0,
        isPromoItem: json['IsPromoItem'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'ItemTypeID': itemTypeID,
        'ItemID': itemID,
        'Amount': amount,
        'BasePrice': basePrice,
        'CurrencyID': currencyID,
        'DiscountPercent': discountPercent,
        'DiscountedPrice': discountedPrice,
        'IsPromoItem': isPromoItem,
      };
}

class ItemOffers {
  String bundleItemOfferID;
  Offer offer;
  int discountPercent;
  Map<String, dynamic> discountedCost;

  ItemOffers({
    required this.bundleItemOfferID,
    required this.offer,
    required this.discountPercent,
    required this.discountedCost,
  });

  factory ItemOffers.fromJson(Map<String, dynamic> json) => ItemOffers(
        bundleItemOfferID: json['BundleItemOfferID'],
        offer: Offer.fromJson(json['Offer']),
        discountPercent: json['DiscountPercent'],
        discountedCost: json['DiscountedCost'],
      );

  Map<String, dynamic> toJson() => {
        'BundleItemOfferID': bundleItemOfferID,
        'Offer': offer.toJson(),
        'DiscountPercent': discountPercent,
        'DiscountedCost': discountedCost,
      };
}

class Offer {
  String offerID;
  bool isDirectPurchase;
  String startDate;
  Map<String, dynamic> cost;
  List<Rewards> rewards;

  Offer({
    required this.offerID,
    required this.isDirectPurchase,
    required this.startDate,
    required this.cost,
    required this.rewards,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerID: json['OfferID'],
        isDirectPurchase: json['IsDirectPurchase'],
        startDate: json['StartDate'],
        cost: json['Cost'],
        rewards:
            List<Rewards>.from(json['Rewards'].map((x) => Rewards.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'OfferID': offerID,
        'IsDirectPurchase': isDirectPurchase,
        'StartDate': startDate,
        'Cost': cost,
        'Rewards': List<dynamic>.from(rewards.map((x) => x.toJson())),
      };
}

class Rewards {
  String itemTypeID;
  String itemID;
  int quantity;

  Rewards({
    required this.itemTypeID,
    required this.itemID,
    required this.quantity,
  });

  factory Rewards.fromJson(Map<String, dynamic> json) => Rewards(
        itemTypeID: json['ItemTypeID'],
        itemID: json['ItemID'],
        quantity: json['Quantity'],
      );

  Map<String, dynamic> toJson() => {
        'ItemTypeID': itemTypeID,
        'ItemID': itemID,
        'Quantity': quantity,
      };
}

class SkinsPanelLayout {
  List<String> singleItemOffers;
  List<SingleItemStoreOffers> singleItemStoreOffers;
  int singleItemOffersRemainingDurationInSeconds;

  SkinsPanelLayout({
    required this.singleItemOffers,
    required this.singleItemStoreOffers,
    required this.singleItemOffersRemainingDurationInSeconds,
  });

  factory SkinsPanelLayout.fromJson(Map<String, dynamic> json) =>
      SkinsPanelLayout(
        singleItemOffers:
            List<String>.from(json['SingleItemOffers'].map((x) => x)),
        singleItemStoreOffers: List<SingleItemStoreOffers>.from(
            json['SingleItemStoreOffers']
                .map((x) => SingleItemStoreOffers.fromJson(x))),
        singleItemOffersRemainingDurationInSeconds:
            json['SingleItemOffersRemainingDurationInSeconds'],
      );

  Map<String, dynamic> toJson() => {
        'SingleItemOffers': List<dynamic>.from(singleItemOffers.map((x) => x)),
        'SingleItemStoreOffers':
            List<dynamic>.from(singleItemStoreOffers.map((x) => x.toJson())),
        'SingleItemOffersRemainingDurationInSeconds':
            singleItemOffersRemainingDurationInSeconds,
      };
}

class SingleItemStoreOffers {
  String offerID;
  bool isDirectPurchase;
  String startDate;
  Map<String, dynamic> cost;
  List<Rewards> rewards;

  SingleItemStoreOffers({
    required this.offerID,
    required this.isDirectPurchase,
    required this.startDate,
    required this.cost,
    required this.rewards,
  });

  factory SingleItemStoreOffers.fromJson(Map<String, dynamic> json) =>
      SingleItemStoreOffers(
        offerID: json['OfferID'],
        isDirectPurchase: json['IsDirectPurchase'],
        startDate: json['StartDate'],
        cost: json['Cost'],
        rewards:
            List<Rewards>.from(json['Rewards'].map((x) => Rewards.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'OfferID': offerID,
        'IsDirectPurchase': isDirectPurchase,
        'StartDate': startDate,
        'Cost': cost,
        'Rewards': List<dynamic>.from(rewards.map((x) => x.toJson())),
      };
}

class UpgradeCurrencyStore {
  List<UpgradeCurrencyOffers> upgradeCurrencyOffers;

  UpgradeCurrencyStore({
    required this.upgradeCurrencyOffers,
  });

  factory UpgradeCurrencyStore.fromJson(Map<String, dynamic> json) =>
      UpgradeCurrencyStore(
        upgradeCurrencyOffers: List<UpgradeCurrencyOffers>.from(
            json['UpgradeCurrencyOffers']
                .map((x) => UpgradeCurrencyOffers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'UpgradeCurrencyOffers':
            List<dynamic>.from(upgradeCurrencyOffers.map((x) => x.toJson())),
      };
}

class UpgradeCurrencyOffers {
  String offerID;
  String storefrontItemID;
  Offer offer;
  double discountedPercent;

  UpgradeCurrencyOffers({
    required this.offerID,
    required this.storefrontItemID,
    required this.offer,
    required this.discountedPercent,
  });

  factory UpgradeCurrencyOffers.fromJson(Map<String, dynamic> json) =>
      UpgradeCurrencyOffers(
        offerID: json['OfferID'],
        storefrontItemID: json['StorefrontItemID'],
        offer: Offer.fromJson(json['Offer']),
        discountedPercent: json['DiscountedPercent'],
      );

  Map<String, dynamic> toJson() => {
        'OfferID': offerID,
        'StorefrontItemID': storefrontItemID,
        'Offer': offer.toJson(),
        'DiscountedPercent': discountedPercent,
      };
}

class AccessoryStore {
  List<AccessoryStoreOffers> accessoryStoreOffers;
  int accessoryStoreRemainingDurationInSeconds;
  String storefrontID;

  AccessoryStore({
    required this.accessoryStoreOffers,
    required this.accessoryStoreRemainingDurationInSeconds,
    required this.storefrontID,
  });

  factory AccessoryStore.fromJson(Map<String, dynamic> json) => AccessoryStore(
        accessoryStoreOffers: List<AccessoryStoreOffers>.from(
            json['AccessoryStoreOffers']
                .map((x) => AccessoryStoreOffers.fromJson(x))),
        accessoryStoreRemainingDurationInSeconds:
            json['AccessoryStoreRemainingDurationInSeconds'],
        storefrontID: json['StorefrontID'],
      );

  Map<String, dynamic> toJson() => {
        'AccessoryStoreOffers':
            List<dynamic>.from(accessoryStoreOffers.map((x) => x.toJson())),
        'AccessoryStoreRemainingDurationInSeconds':
            accessoryStoreRemainingDurationInSeconds,
        'StorefrontID': storefrontID,
      };
}

class AccessoryStoreOffers {
  Offer offer;
  String contractID;

  AccessoryStoreOffers({
    required this.offer,
    required this.contractID,
  });

  factory AccessoryStoreOffers.fromJson(Map<String, dynamic> json) =>
      AccessoryStoreOffers(
        offer: Offer.fromJson(json['Offer']),
        contractID: json['ContractID'],
      );

  Map<String, dynamic> toJson() => {
        'Offer': offer.toJson(),
        'ContractID': contractID,
      };
}

class BonusStore {
  List<BonusStoreOffers> bonusStoreOffers;
  int bonusStoreRemainingDurationInSeconds;

  BonusStore({
    required this.bonusStoreOffers,
    required this.bonusStoreRemainingDurationInSeconds,
  });

  factory BonusStore.fromJson(Map<String, dynamic> json) => BonusStore(
        bonusStoreOffers: List<BonusStoreOffers>.from(
            json['BonusStoreOffers'].map((x) => BonusStoreOffers.fromJson(x))),
        bonusStoreRemainingDurationInSeconds:
            json['BonusStoreRemainingDurationInSeconds'],
      );

  Map<String, dynamic> toJson() => {
        'BonusStoreOffers':
            List<dynamic>.from(bonusStoreOffers.map((x) => x.toJson())),
        'BonusStoreRemainingDurationInSeconds':
            bonusStoreRemainingDurationInSeconds,
      };
}

class BonusStoreOffers {
  String bonusOfferID;
  Offer offer;
  double discountPercent;
  Map<String, dynamic> discountCosts;
  bool isSeen;

  BonusStoreOffers({
    required this.bonusOfferID,
    required this.offer,
    required this.discountPercent,
    required this.discountCosts,
    required this.isSeen,
  });

  factory BonusStoreOffers.fromJson(Map<String, dynamic> json) => BonusStoreOffers(
        bonusOfferID: json['BonusOfferID'],
        offer: Offer.fromJson(json['Offer']),
        discountPercent: json['DiscountPercent'],
        discountCosts: json['DiscountCosts'],
        isSeen: json['IsSeen'],
      );

  Map<String, dynamic> toJson() => {
        'BonusOfferID': bonusOfferID,
        'Offer': offer.toJson(),
        'DiscountPercent': discountPercent,
        'DiscountCosts': discountCosts,
        'IsSeen': isSeen,
      };
}