class Excluded {
  int id;
  String nameAR;
  String nameEN;

  Excluded({
    this.id,
    this.nameAR,
    this.nameEN,
  });

  factory Excluded.fromJson(Map<String, dynamic> json) {
    return Excluded(
      id: json['id'] as int,
      nameAR: json['name_ar'] as String,
      nameEN: json['name_en'] as String,
    );
  }
}
