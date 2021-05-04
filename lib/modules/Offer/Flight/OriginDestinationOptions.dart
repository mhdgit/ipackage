import 'package:ipackage/modules/Offer/Flight/FlightSegment.dart';

class OriginDestinationOptions {
  int journeyDurationPerMinute;
  int connectionTimePerMinute;
  List<FlightSegment> flightSegments;

  OriginDestinationOptions({
    this.journeyDurationPerMinute,
    this.connectionTimePerMinute,
    this.flightSegments,
  });

  factory OriginDestinationOptions.fromJson(Map<String, dynamic> json) {

    var list2 = json['FlightSegments'] as List;
    List<FlightSegment> hrList = list2.map((e) => FlightSegment.fromJson(e)).toList();

    return OriginDestinationOptions(
      journeyDurationPerMinute: json['JourneyDurationPerMinute'] as int,
      connectionTimePerMinute: json['ItinTotalFare'] as int,
      flightSegments: hrList,
    );
  }
}
