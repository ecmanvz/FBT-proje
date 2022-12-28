class CryptoCurrency {
  late String? id;
  late String? symbol;
  late String? name;
  late String? image;
  late double? currentPrice;
  late double? marketCap;
  late int? marketCapRank;
  late double? high24;
  late double? low24;
  late double? priceChange24;
  late double? priceChangePercentage24;
  late double? circulatingSupply;
  late double? ath;
  late double? atl;
  bool isFavorite = false;

  CryptoCurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentPrice,
      required this.marketCap,
      required this.marketCapRank,
      required this.high24,
      required this.low24,
      required this.priceChange24,
      required this.priceChangePercentage24,
      required this.circulatingSupply,
      required this.ath,
      required this.atl});

  factory CryptoCurrency.fromJSON(Map<String, dynamic> map) {
    return CryptoCurrency(
        id: map["id"],
        symbol: map["symbol"],
        name: map["name"],
        image: map["image"],
        currentPrice: double.parse(map["current_price"].toString() == "null"
            ? "0.00"
            : map["current_price"].toString()),
        marketCap: double.parse(map["market_cap"].toString() == "null"
            ? "0.00"
            : map["market_cap"].toString()),
        marketCapRank: map["market_cap_rank"],
        high24: double.parse(map["high_24h"].toString() == "null"
            ? "0.00"
            : map["high_24h"].toString()),
        low24: double.parse(map["low_24h"].toString() == "null"
            ? "0.00"
            : map["low_24h"].toString()),
        priceChange24: double.parse(map["price_change_24h"].toString() == "null"
            ? "0.00"
            : map["price_change_24h"].toString()),
        priceChangePercentage24: double.parse(
            map["price_change_percentage_24h"].toString() == "null"
                ? "0.00"
                : map["price_change_percentage_24h"].toString()),
        circulatingSupply: double.parse(
            map["circulating_supply"].toString() == "null"
                ? "0.00"
                : map["circulating_supply"].toString()),
        ath: double.parse(
            map["ath"].toString() == "null" ? "0.00" : map["ath"].toString()),
        atl: double.parse(
            map["atl"].toString() == "null" ? "0.00" : map["atl"].toString()));
  }
}
