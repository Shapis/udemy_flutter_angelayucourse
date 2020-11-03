import 'package:bitcoin_ticker/services/networking.dart';
import 'package:bitcoin_ticker/utilities/constants.dart';

class CoinModel {
  Future<dynamic> getCoinData(String coinType, String currencyType) async {
    NetworkHelper networkHelper =
        NetworkHelper('http://$kURL/$coinType/$currencyType?apikey=$kAPIKey');

    var coinData = await networkHelper.getData();
    return coinData;
  }
}
