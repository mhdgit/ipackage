class HotelFacility {
  String nameAR;
  String nameEN;

  HotelFacility({
    this.nameAR,
    this.nameEN,
  });

  factory HotelFacility.fromJson(Map<String, dynamic> json) {
    return HotelFacility(
      nameAR: json['name_ar'] as String,
      nameEN: json['name_en'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name_ar'] = this.nameAR;
    data['name_en'] = this.nameEN;

    return data;
  }
}
