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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '3398390A-CE42-4870-9E24-74FCFBA3CBED';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    // create a map to hold both the currency selected and price
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apiKey=$apiKey';
      http.Response res = await http.get(requestURL);
      if (res.statusCode == 200) {
        var decodedData = jsonDecode(res.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(res.statusCode);
        throw 'Problem with get request';
      }
    }
    return cryptoPrices;
  }
}
