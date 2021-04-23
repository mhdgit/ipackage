import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountsApi {

  Future get_nationalities() async
  {


    Uri uri = Uri.parse('https://ipackagetours.com/api/nationalities');
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

  Future new_account() async
  {

    Uri uri = Uri.parse('https://ipackagetours.com/api/offers?special=1');


  }
}