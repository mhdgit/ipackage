import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeApi {

  Future getSpecialOffers() async
  {
    var uri =
    Uri.https('www.ipackagetours.com', '/api/offers?special=1');
    var res = await http.get(uri);
    //print(res.body);
    //print('sending...');

    try {
      var body = json.decode(res.body);

      return body;

    } catch (e) {
      var body = '';

      return body;
    }


  }
}