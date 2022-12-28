import 'dart:async';
import 'package:cryptotracker/server/currency_api.dart';
import 'package:cryptotracker/models/CryptoCurrency.dart';
import 'package:cryptotracker/server/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];
  List<CryptoCurrency> top50Coins = [];
  List<CryptoCurrency> searchedCoins = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    List<dynamic> _markets = await API.getMarkets();
    List<String> favorites = await FirebaseService.fetchFavorites(
        FirebaseAuth.instance.currentUser!);

    List<CryptoCurrency> tempMarkets = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);

      if (favorites.contains(newCrypto.id!)) {
        newCrypto.isFavorite = true;
      }
      tempMarkets.add(newCrypto);
    }

    markets = tempMarkets;
    top50Coins = markets.getRange(0, 50).toList();
    isLoading = false;
    notifyListeners();
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void searchCoin(String query) async {
    searchedCoins = [];
    if (query.isEmpty) {
      notifyListeners();
      return;
    }

    for (var coin in markets) {
      if (coin.id!.startsWith(query) ||
          coin.name!.startsWith(query) ||
          coin.symbol!.startsWith(query)) {
        searchedCoins.add(coin);
      }
    }
    notifyListeners();
  }

  void addFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = true;
    await FirebaseService.addFavorites(
        FirebaseAuth.instance.currentUser!, crypto.id!);
    notifyListeners();
  }

  void removeFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = false;
    await FirebaseService.removeFavorites(
        FirebaseAuth.instance.currentUser!, crypto.id!);
    notifyListeners();
  }
}
