
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
  double netRate = 0.0;

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

    if(json.containsKey('hotel_facilitys') && json.containsKey('hotel_rooms'))
      {
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
          mandatoryFee: json['mandatory_fee'].toString() != '' ?
          json['mandatory_fee'].toString().replaceAll(RegExp('&nbsp;'), ' ') : ' ',
          accommodationAR: json['accommodation_ar'] as String,
          accommodationEN: json['accommodation_en'] as String,
          nameAR: json['name_ar'] as String,
          nameEN: json['name_en'] as String,
          hotelFacilities: hfList,
          hotelRooms: hrList,
        );
      }
    else
      {
        List<HotelFacility> hfList = [];
        List<HotelRoom> hrList = [];

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
          mandatoryFee: json['mandatory_fee'].toString() != '' ?
          json['mandatory_fee'].toString().replaceAll(RegExp('&nbsp;'), ' ') : ' ',
          accommodationAR: json['accommodation_ar'] as String,
          accommodationEN: json['accommodation_en'] as String,
          nameAR: json['name_ar'] as String,
          nameEN: json['name_en'] as String,
          hotelFacilities: hfList,
          hotelRooms: hrList,
        );
      }

  }

  List hfToJson(List<HotelFacility> list) {
    List jsonList = [];
    if(list != null)
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  List hrToJson(List<HotelRoom> list) {
    List jsonList = [];
    if(list != null)
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['city_id'] = this.cityId;
    data['rating'] = this.rating;
    data['url'] = this.url;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['description'] = this.description;
    data['images'] = this.images;
    data['mandatory_fee'] = this.mandatoryFee;
    data['accommodation_ar'] = this.accommodationAR;
    data['accommodation_en'] = this.accommodationEN;
    data['name_ar'] = this.nameAR;
    data['name_en'] = this.nameEN;
    data['hotel_facilitys'] = hfToJson(this.hotelFacilities);
    data['hotel_rooms'] = hrToJson(this.hotelRooms);

    return data;
  }
}
