import 'package:ipackage/modules/Offer/Flight/FlightTotalFare.dart';
import 'package:ipackage/modules/Offer/Flight/PricingFareBreakdown.dart';

class AirItineraryPricingInfo {
  int fareType;
  FlightTotalFare flightTotalFare;
  List<PricingFareBreakdown> pricingFareBreakdown;

  AirItineraryPricingInfo({
    this.fareType,
    this.flightTotalFare,
    this.pricingFareBreakdown,
  });

  factory AirItineraryPricingInfo.fromJson(Map<String, dynamic> json) {

    var list2 = json['PtcFareBreakdown'] as List;
    List<PricingFareBreakdown> hrList = list2.map((e) => PricingFareBreakdown.fromJson(e)).toList();

    return AirItineraryPricingInfo(
      fareType: json['FareType'] as int,
      flightTotalFare: FlightTotalFare.fromJson(json['ItinTotalFare']),
      pricingFareBreakdown: hrList,
    );
  }
}
