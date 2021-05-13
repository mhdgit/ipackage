class HotelRoom {
  String nameAR;
  String nameEN;

  HotelRoom({
    this.nameAR,
    this.nameEN,
  });

  factory HotelRoom.fromJson(Map<String, dynamic> json) {
    return HotelRoom(
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
