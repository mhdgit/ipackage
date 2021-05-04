
class FlightTotalFare {
  double baseFare;
  double totalFare;
  double totalCommission;
  double totalTax;
  double serviceTax;
  String currency;

  FlightTotalFare({
    this.baseFare,
    this.totalFare,
    this.totalCommission,
    this.totalTax,
    this.serviceTax,
    this.currency,
  });

  factory FlightTotalFare.fromJson(Map<String, dynamic> json) {

    return FlightTotalFare(
      baseFare: json['BaseFare'] as double,
      totalFare: json['TotalFare'] as double,
      totalCommission: json['TotalCommission'] as double,
      totalTax: json['TotalTax'] as double,
      serviceTax: json['ServiceTax'] as double,
      currency: json['Currency'] as String,
    );
  }
}
