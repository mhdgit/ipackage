import 'dart:convert';

import 'package:ipackage/modules/Country.dart';
import 'package:http/http.dart' as http;
import 'package:ipackage/modules/Package.dart';

class BetaApiAssistant
{

  List<Country> _countries = [];
  List<Package> _packages = [];

  Future<List<Country>> getCountries() async
  {
      var res = await http.get(Uri.parse('https://beta.ipackagetours.com/api/get/countries'),
          headers: {"Accept": "application/json"});
      var body = json.decode(res.body);
      // print(body);
      Country tCountry;

      for (var country in body['data']) {
        tCountry = Country.fromJson(country);
        _countries.add(tCountry);
      }
      // print('users length is : ' + _countries.length.toString());

      return _countries;
  }

  Future<List<Package>> getPackages() async
  {
    var res = await http.get(Uri.parse('https://beta.ipackagetours.com/api/get/packages'),
        headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    // print(body);
    Package tPackage;

    for (var pack in body['data']) {
      tPackage = Package.fromJson(pack);
      _packages.add(tPackage);
    }
    // print('users length is : ' + _countries.length.toString());

    return _packages;
  }
}