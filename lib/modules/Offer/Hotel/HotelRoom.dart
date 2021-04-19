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
}
