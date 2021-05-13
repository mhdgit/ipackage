import 'package:ipackage/modules/Offer/Airport.dart';
import 'package:ipackage/modules/Offer/Day.dart';
import 'package:ipackage/modules/Offer/Excluded.dart';
import 'package:ipackage/modules/Offer/Included.dart';
import 'package:ipackage/modules/Offer/Transportations/MinTransportation.dart';

class Offer {
  int daysNumber;
  String descriptionAR;
  String descriptionEN;
  String countryAR;
  String countryEN;
  String packageAR;
  String packageEN;
  String image;
  String imageSm;
  String imageMd;
  Airport airportGo;
  Airport airportBack;
  List<Day> days;
  List<Included> includeds;
  List<Excluded> excludeds;
  List<MinTransportation> airportTransferGo;
  List<MinTransportation> airportTransferBack;

  Offer({
    this.daysNumber,
    this.descriptionAR,
    this.descriptionEN,
    this.countryAR,
    this.countryEN,
    this.packageAR,
    this.packageEN,
    this.image,
    this.imageSm,
    this.imageMd,
    this.airportGo,
    this.airportBack,
    this.days,
    this.includeds,
    this.excludeds,
    this.airportTransferGo,
    this.airportTransferBack,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {

    var list = json['days'] as List;
    List<Day> dList = list.map((e) => Day.fromJson(e)).toList();

    var list2 = json['includeds'] as List;
    List<Included> iList = list2.map((e) => Included.fromJson(e)).toList();

    var list3 = json['excludeds'] as List;
    List<Excluded> eList = list3.map((e) => Excluded.fromJson(e)).toList();

    var list4 = json['airport_transfers_go'] as List;
    List<MinTransportation> atgList = list4.map((e) => MinTransportation.fromJson(e)).toList();

    var list5 = json['airport_transfers_back'] as List;
    List<MinTransportation> atbList = list5.map((e) => MinTransportation.fromJson(e)).toList();

    return Offer(
      daysNumber: json['num_days'] as int,
      descriptionAR: json['description_ar'] as String,
      descriptionEN: json['description_en'] as String,
      countryAR: json['county_ar'] as String,
      countryEN: json['county_en'] as String,
      packageAR: json['package_ar'] as String,
      packageEN: json['package_en'] as String,
      image: json['image'] as String,
      imageMd: json['image_md'] as String,
      imageSm: json['image_sm'] as String,
      airportGo: Airport.fromJson(json['airpot_go']),
      airportBack: Airport.fromJson(json['airpot_back']),
      days: dList,
      includeds: iList,
      excludeds: eList,
      airportTransferGo: atgList,
      airportTransferBack: atbList,
    );
  }

  List dToJson(List<Day> list) {
    List jsonList = [];
    if(list != null)
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  List iToJson(List<Included> list) {
    List jsonList = [];
    if(list != null)
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  List eToJson(List<Excluded> list) {
    List jsonList = [];
    if(list != null)
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  List mtToJson(List<MinTransportation> list) {
    List jsonList = [];
    if(list != null)
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['num_days'] = this.daysNumber;
    data['description_ar'] = this.descriptionAR;
    data['description_en'] = this.descriptionEN;
    data['county_ar'] = this.countryAR;
    data['county_en'] = this.countryEN;
    data['package_ar'] = this.packageAR;
    data['package_en'] = this.packageEN;
    data['image'] = this.image;
    data['image_md'] = this.imageMd;
    data['image_sm'] = this.imageSm;
    data['airpot_go'] = this.airportGo.toJson();
    data['airpot_back'] = this.airportBack.toJson();
    data['days'] = dToJson(this.days);
    data['includeds'] = iToJson(this.includeds);
    data['excludeds'] = eToJson(this.excludeds);
    data['airport_transfers_go'] = mtToJson(this.airportTransferGo);
    data['airport_transfers_back'] = mtToJson(this.airportTransferBack);

    return data;
  }
}
