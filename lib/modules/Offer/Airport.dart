class Airport {
  int id;
  int cityId;
  String nameAR;
  String nameEN;
  String iata;

  Airport({
    this.id,
    this.cityId,
    this.nameAR,
    this.nameEN,
    this.iata,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {

    return Airport(
      id: json['id'] as int,
      cityId: json['city_id'] as int,
      nameAR: json['name_ar'] as String,
      nameEN: json['name_en'] as String,
      iata: json['iata'] as String,
    );
  }
}
