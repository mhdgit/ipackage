import 'package:ipackage/modules/Offer/Hotel/Hotel.dart';
import 'package:ipackage/modules/Offer/Transportations/TransportationMethods.dart';
import 'package:ipackage/modules/Offer/Trip.dart';

class Day {
  int hotelId;
  int cityId;
  String cityAR;
  String cityEN;
  bool internalFlight;
  TransportationMethods transportationMethods;
  List<Hotel> hotels;
  List<Trip> trips;

  Day({
    this.hotelId,
    this.cityId,
    this.cityAR,
    this.cityEN,
    this.internalFlight,
    this.transportationMethods,
    this.hotels,
    this.trips,
  });

  factory Day.fromJson(Map<String, dynamic> json) {

    var list = json['hotel'] as List;
    List<Hotel> hList = list.map((e) => Hotel.fromJson(e)).toList();

    var list2 = json['trips'] as List;
    List<Trip> tList = list2.map((e) => Trip.fromJson(e)).toList();

    return Day(
      hotelId: json['hotel_id'] as int,
      cityId: json['city_id'] as int,
      cityAR: json['city_ar'] as String,
      cityEN: json['city_en'] as String,
      internalFlight: json['internal_flight'] as bool,
      transportationMethods: json.containsKey('transportations') ? TransportationMethods.fromJson(json['transportations']) : new TransportationMethods(),
      hotels: hList,
      trips: tList,
    );
  }
}
