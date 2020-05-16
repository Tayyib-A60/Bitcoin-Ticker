import 'network_helper.dart';

const apiUrl = 'https://rest.coinapi.io/v1/exchangerate/';
const apiKey = 'A06866D6-B780-4265-A577-3AEF5870AE53';

class CoinConverter {
  CoinConverter();

  Future getExchangeRate(String crypto, String fiat) async {
    NetworkHelper _networkHelper = NetworkHelper('$apiUrl$crypto/$fiat?apikey=$apiKey');
    return _networkHelper.getCurrentExchange();
  }

}