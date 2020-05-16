import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {

  NetworkHelper(this.url);
  final String url;

  Future getCurrentExchange() async {
    var res = await http.get(url);
    if(res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return res.statusCode;
    }
  }
}