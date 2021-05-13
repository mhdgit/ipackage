import 'package:http/http.dart' as http;
import 'dart:convert';

class MyBooksApi {
  Future get_books(String token) async
  {
    Uri uri = Uri.parse('https://ipackagetours.com/api/my/trips');

    final res = await http.post(uri,
        headers: {
          'Authorization': 'Bearer '+token,
        });

    //print(res.body);


    try {
      var body = json.decode(res.body);

      return body;

    } catch (e) {
      var body = '';

      return body;
    }


  }
}