import 'package:bitcoin_ticker/coin_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'coin_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  int btcRate = 0;
  int ethRate = 0;
  int ltcRate = 0;

  @override
  void initState() {
    super.initState();
    getCurrentPriceOfBTC();
  }

  void getCurrentPriceOfBTC() async {
    CoinConverter coinConverter = CoinConverter();
    var resForBTC = await coinConverter.getExchangeRate('BTC',selectedCurrency);
    var resForETH = await coinConverter.getExchangeRate('ETH',selectedCurrency);
    var resForLTC = await coinConverter.getExchangeRate('LTC',selectedCurrency);
    setState(() {
      btcRate = resForBTC['rate'].toInt();
      ethRate = resForETH['rate'].toInt();
      ltcRate = resForLTC['rate'].toInt();
    });
  }

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];

    for(String currency in currenciesList) {
      dropdownMenuItems.add(
          DropdownMenuItem(
            child: Text(currency), value: currency,
          )
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownMenuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getCurrentPriceOfBTC();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> dropdownMenuItems = [];

    for(String currency in currenciesList) {
      dropdownMenuItems.add(
        Text(
          currency,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: dropdownMenuItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ReusableCoinCard(crypto: 'BTC', fiat: selectedCurrency, rate: btcRate),
                ReusableCoinCard(crypto: 'ETH', fiat: selectedCurrency, rate: ethRate),
                ReusableCoinCard(crypto: 'LTC', fiat: selectedCurrency, rate: ltcRate),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS? iOSPicker() : androidPicker()
          ),
        ],
      ),
    );
  }
}

