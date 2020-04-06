import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var coinData = CoinData();

  var selectedCurrency = currenciesList[0];
  var valueFromBitcoin = '?';
  var valueFromEtherium = '?';
  var valueFromLTC = '?';

  Widget getPicker() {
    if (Platform.isIOS) {
      return getIosPicker();
    } else {
      return getAndroidDropdown();
    }
  }

  DropdownButton getAndroidDropdown() {
    List<DropdownMenuItem<String>> list = currenciesList
        .map((item) => DropdownMenuItem(
              child: Text(item),
              value: item,
            ))
        .toList();

    return DropdownButton(
        value: selectedCurrency,
        items: list,
        onChanged: (value) async {
          selectedCurrency = value;
          onUpdateSelectedCurrency();
        });
  }

  CupertinoPicker getIosPicker() {
    List<Widget> list = currenciesList.map((item) => Text(item)).toList();

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        selectedCurrency = currenciesList[selectedIndex];
        onUpdateSelectedCurrency();
      },
      children: list,
    );
  }

  onUpdateSelectedCurrency() async {
    String currencyForBitcoin =
        await coinData.getCoinData('BTC', selectedCurrency);
    String currencyForEtherium =
        await coinData.getCoinData('ETH', selectedCurrency);
    String currencyForLTC = await coinData.getCoinData('LTC', selectedCurrency);

    setState(() {
      this.selectedCurrency = selectedCurrency;

      valueFromBitcoin = currencyForBitcoin;
      valueFromEtherium = currencyForEtherium;
      valueFromLTC = currencyForLTC;
    });
  }

  @override
  void initState() {
    super.initState();
    onUpdateSelectedCurrency();
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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $valueFromBitcoin $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $valueFromEtherium $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $valueFromLTC $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
