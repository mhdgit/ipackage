class Included {
  int id;
  String nameAR;
  String nameEN;

  Included({
    this.id,
    this.nameAR,
    this.nameEN,
  });

  factory Included.fromJson(Map<String, dynamic> json) {
    return Included(
      id: json['id'] as int,
      nameAR: json['name_ar'] as String,
      nameEN: json['name_en'] as String,
    );
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name_ar'] = this.nameAR;
    data['name_en'] = this.nameEN;

    return data;
  }
}
