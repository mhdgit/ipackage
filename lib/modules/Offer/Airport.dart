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

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['city_id'] = this.cityId;
    data['name_ar'] = this.nameAR;
    data['name_en'] = this.nameEN;
    data['iata'] = this.iata;

    return data;
  }
}
