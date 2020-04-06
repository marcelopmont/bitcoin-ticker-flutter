import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<String> getCoinData(String currencyFrom, String currencyTo) async {
    var url =
        'https://rest.coinapi.io/v1/exchangerate/$currencyFrom/$currencyTo?apikey=02D882C3-7FA3-47AA-8AC0-7FEED09DA02C';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['rate'].toInt().toString();
    } else {
      return '';
    }
  }
}
