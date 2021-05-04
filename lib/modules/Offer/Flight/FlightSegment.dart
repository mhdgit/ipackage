
class FlightSegment {
  String departureDateTime;
  String arrivalDateTime;
  int stopQuantity;
  String flightNumber;
  String resBookDesigCode;
  String journeyDuration;
  int journeyDurationPerMinute;
  int connectionTimePerMinute;
  String departureAirportLocationCode;
  String arrivalAirportLocationCode;
  String marketingAirlineCode;
  int cabinClassCode;

  FlightSegment({
    this.departureDateTime,
    this.arrivalDateTime,
    this.stopQuantity,
    this.flightNumber,
    this.resBookDesigCode,
    this.journeyDuration,
    this.journeyDurationPerMinute,
    this.connectionTimePerMinute,
    this.departureAirportLocationCode,
    this.arrivalAirportLocationCode,
    this.marketingAirlineCode,
    this.cabinClassCode,
  });

  factory FlightSegment.fromJson(Map<String, dynamic> json) {
    return FlightSegment(
      departureDateTime: json['DepartureDateTime'] as String,
      arrivalDateTime: json['ArrivalDateTime'] as String,
      stopQuantity: json['StopQuantity'] as int,
      flightNumber: json['FlightNumber'] as String,
      resBookDesigCode: json['ResBookDesigCode'] as String,
      journeyDuration: json['JourneyDuration'] as String,
      journeyDurationPerMinute: json['JourneyDurationPerMinute'] as int,
      connectionTimePerMinute: json['ConnectionTimePerMinute'] as int,
      departureAirportLocationCode: json['DepartureAirportLocationCode'] as String,
      arrivalAirportLocationCode: json['ArrivalAirportLocationCode'] as String,
      marketingAirlineCode: json['MarketingAirlineCode'] as String,
      cabinClassCode: json['CabinClassCode'] as int,
    );
  }
}
