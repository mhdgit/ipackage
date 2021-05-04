
import 'package:ipackage/modules/Offer/Flight/Tax.dart';

class PricingFareBreakdown {
  double baseFare;
  double totalFare;
  double commission;
  double serviceTax;
  List<Tax> taxes;
  String currency;

  PricingFareBreakdown({
    this.baseFare,
    this.totalFare,
    this.commission,
    this.serviceTax,
    this.taxes,
    this.currency,
  });

  factory PricingFareBreakdown.fromJson(Map<String, dynamic> json) {

    var list = json['PassengerFare']['Taxes'] as List;
    List<Tax> hfList = list.map((e) => Tax.fromJson(e)).toList();

    return PricingFareBreakdown(
      baseFare: json['PassengerFare']['BaseFare'] as double,
      totalFare: json['PassengerFare']['TotalFare'] as double,
      commission: json['PassengerFare']['Commission'] as double,
      serviceTax: json['PassengerFare']['ServiceTax'] as double,
      taxes: hfList,
      currency: json['PassengerFare']['Currency'] as String,
    );
  }
}
