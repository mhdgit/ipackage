
import 'package:ipackage/modules/Offer/PartoHotel/PartoRoom.dart';

class PartoHotel {
  int id;
  String fareSourceCode;
  String offer;
  bool nonRefundable;
  String paymentDeadline;
  String currency;
  int availableRoom;
  String plainTextCancellationPolicy;
  double netRate;
  List<PartoRoom> rooms;
  List<String> cancellationPolicies;
  List<String> remarks;
  List<String> amenities;

  PartoHotel({
    this.id,
    this.fareSourceCode,
    this.offer,
    this.nonRefundable,
    this.paymentDeadline,
    this.currency,
    this.availableRoom,
    this.plainTextCancellationPolicy,
    this.netRate,
    this.rooms,
    this.cancellationPolicies,
    this.remarks,
    this.amenities,
  });

  factory PartoHotel.fromJson(Map<String, dynamic> json) {

    var list = json['Rooms'] as List;
    List<PartoRoom> hfList = list.map((e) => PartoRoom.fromJson(e)).toList();

    var list2 = json['CancellationPolicies'] as List<String>;
    List<String> cList = List.of(list2);

    var list3 = json['Remarks'] as List<String>;
    List<String> rList = List.of(list3);

    var list4 = json['Amenities'] as List<String>;
    List<String> aList = List.of(list4);

    return PartoHotel(
      id: json['HotelId'] as int,
      fareSourceCode: json['FareSourceCode'] as String,
      offer: json['Offer'] as String,
      nonRefundable: json['NonRefundable'] as bool,
      paymentDeadline: json['PaymentDeadline'] as String,
      currency: json['Currency'] as String,
      availableRoom: json['AvailableRoom'] as int,
      plainTextCancellationPolicy: json['PlainTextCancellationPolicy'] as String,
      netRate: json['NetRate'] as double,
      rooms: hfList,
      cancellationPolicies: cList,
      remarks: rList,
      amenities: aList,
    );
  }
}
