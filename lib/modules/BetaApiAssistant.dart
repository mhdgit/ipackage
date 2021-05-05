import 'dart:convert';

import 'package:ipackage/modules/Country.dart';
import 'package:http/http.dart' as http;
import 'package:ipackage/modules/Offer/Airport.dart';
import 'package:ipackage/modules/Offer/Flight/Flight.dart';
import 'package:ipackage/modules/Offer/Offer.dart';
import 'package:ipackage/modules/Package.dart';
import 'package:ipackage/modules/SpecialDomesticOffer.dart';
import 'package:ipackage/modules/SpecialForeignOffer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BetaApiAssistant {
  List<Country> _countries = [];
  List<Package> _packages = [];
  List<SpecialDomesticOffer> _sdo = [];
  List<SpecialForeignOffer> _sfo = [];
  List<Flight> _flights = [];
  List<Airport> _airports = [];
  Offer _offer;

  Future<List<Country>> getCountries() async {
    var res = await http.get(
        Uri.parse('https://beta.ipackagetours.com/api/get/countries'),
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

  Future<List<Package>> getPackages() async {
    var res = await http.get(
        Uri.parse('https://beta.ipackagetours.com/api/get/packages'),
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

  Future<Offer> getOffer(int offerId, String offerDate) async {
    var res = await http.get(
        Uri.parse('https://ipackagetours.com/api/offer?id=' +
            offerId.toString() +
            '&date=' +
            offerDate),
        headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    print(body);

    _offer = Offer.fromJson(body['data']);

    return _offer;
  }

  Future<List<SpecialDomesticOffer>> getSpecialDomesticOffers() async {
    var res = await http.get(
        Uri.parse('https://ipackagetours.com/api/offers?domestic=1'),
        headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    print(body);
    SpecialDomesticOffer tSpecialDomesticOffer;

    for (var sdo in body['data']) {
      tSpecialDomesticOffer = SpecialDomesticOffer.fromJson(sdo);
      _sdo.add(tSpecialDomesticOffer);
    }
    print('sdo length is : ' + _sdo.length.toString());

    return _sdo;
  }

  Future<List<SpecialForeignOffer>> getSpecialForeignOffers() async {
    var res = await http.get(
        Uri.parse('https://ipackagetours.com/api/offers?special=1'),
        headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    print(body);
    SpecialForeignOffer tSpecialForeignOffer;

    for (var sdo in body['data']) {
      tSpecialForeignOffer = SpecialForeignOffer.fromJson(sdo);
      _sfo.add(tSpecialForeignOffer);
    }
    print('sfo length is : ' + _sfo.length.toString());

    return _sfo;
  }

  Future<String> setupPartocrsSession() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'session_id';

    var res = await http.post(
        Uri.parse(
            'https://apidemo.partocrs.com/Rest/Authenticate/CreateSession'),
        body: json.encode({
          "OfficeId": "CRS001358",
          "UserName": "api",
          "Password":
          "F2A0B0D6B1F9652D2AB6B696F6421456984E63774F959169141EF220043E61FF9BC539547937CDE41C871C7E6922A417F3D09DB232DDB1D67CF6CE9E30ADA479"
        }),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });
    var body = json.decode(res.body);
    print(body);

    if(body['Error'] == null && body['Success'] == true)
      {
        prefs.setString(key, body['SessionId']);
        return body['SessionId'].toString();
      }
    else
      return 'Setup failed';
  }

  Future<List<Flight>> getFlightPath(String origin , String destination , String date) async {

    final prefs = await SharedPreferences.getInstance();
    final key = 'session_id';
    final value = prefs.getString(key);

    var res = await http.post(
        Uri.parse('https://apidemo.partocrs.com/Rest/Air/AirLowFareSearch'),
        body: json.encode({
          "PricingSourceType": 0,
          "RequestOption": 2,
          "SessionId": value.toString(),
          "AdultCount": 2,
          "ChildCount": 0,
          "InfantCount": 0,
          "TravelPreference": {
            "CabinType": 1,
            "MaxStopsQuantity": 0,
            "AirTripType": 1,
            "VendorExcludeCodes": [],
            "VendorPreferenceCodes": []
          },
          "OriginDestinationInformations": [
            {
              "DepartureDateTime": date+"T00:00:00",
              "DestinationLocationCode": destination.toString(),
              "DestinationType": 0,
              "OriginLocationCode": origin.toString(),
              "OriginType": 0
            }
          ]
        }),
        headers: {"Accept": "application/json" , "Content-Type": "application/json"});

    var body = json.decode(res.body);
    print(body);
    if(body['Success'] == false && body['Error']['Message'] == 'Invalid SessionID')
      {
        setupPartocrsSession();
        getFlightPath(origin, destination, date);
      }
    else if(body['Success'] == true)
      {
        Flight tFlight;

        for (var flight in body['PricedItineraries']) {
          tFlight = Flight.fromJson(flight);
          _flights.add(tFlight);
        }
      }
    print('_flights length is : ' + _flights.length.toString());

    return _flights;
  }

  Future<List<Airport>> getAirport(String keyword) async{
    var res = await http.get(
        Uri.parse('https://ipackagetours.com/api/airports?name='+ keyword),
        headers: {"Accept": "application/json"});
    var body = json.decode(res.body);
    print(body);
    Airport tAirport;

    try{
      _airports.clear();
      for (var airport in body['data']) {
        tAirport = Airport.fromJson(airport);

        _airports.add(tAirport);
      }
      print('_airports length is : ' + _airports.length.toString());
    }
    catch(e){
      return _airports;
    }

    return _airports;
  }
}
