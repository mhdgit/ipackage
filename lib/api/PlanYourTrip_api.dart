import 'package:http/http.dart' as http;
import 'dart:convert';

class PlanYourTripApi {

  Future get_counteries() async
  {
    Uri uri = Uri.parse('https://beta.ipackagetours.com/api/get/countries');
    var res = await http.get(uri);

    //print('sending...');

    try {
      var body = json.decode(res.body);

      return body;

    } catch (e) {
      var body = '';

      return body;
    }


  }

  Future get_packages() async
  {
    Uri uri = Uri.parse('https://beta.ipackagetours.com/api/get/packages');
    var res = await http.get(uri);

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