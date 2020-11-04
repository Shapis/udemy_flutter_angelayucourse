import 'package:bitcoin_ticker/services/networking.dart';

import 'constants.dart';

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
  Future<Map<String, String>> getCoinData(String currencyType) async {
    Map<String, String> coinData = {};
    List<Future> futureDecodedDataList = [];

    for (var i = 0; i < cryptoList.length; i++) {
      NetworkHelper networkHelper = NetworkHelper(
          'http://$kURL/${cryptoList[i]}/$currencyType?apikey=$kAPIKey');
      futureDecodedDataList.add(networkHelper.getData());
    }

    for (var i = 0; i < cryptoList.length; i++) {
      var decodedData = await futureDecodedDataList[i];
      num tempNum = decodedData['rate'];
      double tempDouble = tempNum.toDouble();
      coinData[cryptoList[i]] = tempDouble.toStringAsFixed(2);
    }

    return coinData;
  }
}
