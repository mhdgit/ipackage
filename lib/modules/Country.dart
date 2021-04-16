class Country {
  int id;
  int status;
  String isoCode;
  String videoUrl;
  String image;
  String imageSm;
  String imageMd;
  int continentId;
  String nameAR;
  String nameEN;

  Country({
    this.id,
    this.status,
    this.isoCode,
    this.videoUrl,
    this.image,
    this.imageSm,
    this.imageMd,
    this.continentId,
    this.nameAR,
    this.nameEN,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] as int,
      status: json['status'] as int,
      isoCode: json['iso_code'] as String,
      videoUrl: json['video_url'] as String,
      image: json['image'] as String,
      imageSm: json['image_sm'] as String,
      imageMd: json['image_md'] as String,
      continentId: json['continent_id'] as int,
      nameAR: json['name_ar'] as String,
      nameEN: json['name_en'] as String,
    );
  }
}
