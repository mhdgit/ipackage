
import 'package:ipackage/modules/Offer/Transportations/Transportation.dart';

class MinTransportation {
  int id;
  int transportationCities;
  int airportTransfer;
  int transportationId;
  int carPrice;
  int priceChild;
  int priceIndividuals;
  Transportation transportation;

  MinTransportation({
    this.id,
    this.airportTransfer,
    this.transportationCities,
    this.transportationId,
    this.carPrice,
    this.priceChild,
    this.priceIndividuals,
    this.transportation,
  });

  factory MinTransportation.fromJson(Map<String, dynamic> json) {

    return MinTransportation(
      id: json['id'] as int,
      airportTransfer: json['airport_transfer'] as int,
      transportationCities: json['transportation_cities'] as int,
      transportationId: json['transportation_id'] as int,
      carPrice: json['car_price'] as int,
      priceChild: json['price_child'] as int,
      priceIndividuals: json['price_indv'] as int,
      transportation: Transportation.fromJson(json['transportation']) ?? new Transportation(),
    );
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['airport_transfer'] = this.airportTransfer;
    data['transportation_cities'] = this.transportationCities;
    data['transportation_id'] = this.transportationId;
    data['car_price'] = this.carPrice;
    data['price_child'] = this.priceChild;
    data['price_indv'] = this.priceIndividuals;
    data['transportation'] = this.transportation.toJson();

    return data;
  }
}
