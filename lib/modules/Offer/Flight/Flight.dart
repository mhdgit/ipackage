import 'package:ipackage/modules/Offer/Flight/AirItineraryPricingInfo.dart';
import 'package:ipackage/modules/Offer/Flight/OriginDestinationOptions.dart';

class Flight {
  bool isPassportMandatory;
  bool isDestinationAddressMandatory;
  bool isPassportIssueDateMandatory;
  int directionInd;
  int refundMethod;
  String validatingAirlineCode;
  String fareSourceCode;
  AirItineraryPricingInfo airItineraryPricingInfo;
  List<OriginDestinationOptions> originDestinationOptions;
  bool visibility = true;

  Flight({
    this.isPassportMandatory,
    this.isDestinationAddressMandatory,
    this.isPassportIssueDateMandatory,
    this.directionInd,
    this.refundMethod,
    this.validatingAirlineCode,
    this.fareSourceCode,
    this.airItineraryPricingInfo,
    this.originDestinationOptions,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {

    var list = json['OriginDestinationOptions'] as List;
    List<OriginDestinationOptions> hfList = list.map((e) => OriginDestinationOptions.fromJson(e)).toList();

    return Flight(
      isPassportMandatory: json['IsPassportMandatory'] as bool,
      isDestinationAddressMandatory: json['IsDestinationAddressMandatory'] as bool,
      isPassportIssueDateMandatory: json['IsPassportIssueDateMandatory'] as bool,
      directionInd: json['DirectionInd'] as int,
      refundMethod: json['RefundMethod'] as int,
      validatingAirlineCode: json['ValidatingAirlineCode'] as String,
      fareSourceCode: json['FareSourceCode'] as String,
      airItineraryPricingInfo: AirItineraryPricingInfo.fromJson(json['AirItineraryPricingInfo']),
      originDestinationOptions: hfList,
    );
  }
}
