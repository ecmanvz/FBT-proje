import 'package:cryptotracker/models/CryptoCurrency.dart';
import 'package:cryptotracker/providers/market_provider.dart';
import 'package:cryptotracker/widgets/CryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColor,
                    hintText: "Search Coin",
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  marketProvider.searchCoin(value);
                },
              ),
              Divider(),
              Expanded(
                child: marketProvider.searchedCoins.length <= 0
                    ? Text("Coin not found!")
                    : ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 5,
                          );
                        },
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: marketProvider.searchedCoins.length,
                        itemBuilder: (context, index) {
                          CryptoCurrency currentCrypto =
                              marketProvider.searchedCoins[index];

                          return CryptoListTile(currentCrypto: currentCrypto);
                        },
                      ),
              ),
            ],
          );
        }
      },
    );
  }
}
