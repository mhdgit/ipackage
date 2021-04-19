import 'package:ipackage/modules/Offer/Hotel/HotelFacility.dart';
import 'package:ipackage/modules/Offer/Hotel/HotelRoom.dart';

class Hotel {
  int id;
  int cityId;
  String rating;
  String url;
  String address;
  String latitude;
  String longitude;
  String phone;
  String fax;
  String description;
  String instructions;
  String specialInstructions;
  String beginTime;
  String endTime;
  String minAge;
  String checkoutTime;
  String images;
  String mandatoryFee;
  String accommodationAR;
  String accommodationEN;
  List<HotelFacility> hotelFacilities;
  List<HotelRoom> hotelRooms;
  String nameAR;
  String nameEN;

  Hotel({
    this.id,
    this.cityId,
    this.rating,
    this.url,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
    this.fax,
    this.description,
    this.images,
    this.mandatoryFee,
    this.accommodationAR,
    this.accommodationEN,
    this.hotelFacilities,
    this.hotelRooms,
    this.nameAR,
    this.nameEN,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {

    var list = json['hotel_facilitys'] as List;
    List<HotelFacility> hfList = list.map((e) => HotelFacility.fromJson(e)).toList();

    var list2 = json['hotel_rooms'] as List;
    List<HotelRoom> hrList = list2.map((e) => HotelRoom.fromJson(e)).toList();

    return Hotel(
      id: json['id'] as int,
      cityId: json['city_id'] as int,
      rating: json['rating'] as String,
      url: json['url'] as String,
      address: json['address'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      phone: json['phone'] as String,
      fax: json['fax'] as String,
      description: json['description'] as String,
      images: json['images'] as String,
      mandatoryFee: json['mandatory_fee'] as String,
      accommodationAR: json['accommodation_ar'] as String,
      accommodationEN: json['accommodation_en'] as String,
      nameAR: json['name_ar'] as String,
      nameEN: json['name_en'] as String,
      hotelFacilities: hfList,
      hotelRooms: hrList,
    );
  }
}
