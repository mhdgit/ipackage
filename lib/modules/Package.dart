class Package {
  int id;
  int status;
  String image;
  String imageSm;
  String imageMd;
  String nameAR;
  String nameEN;

  Package({
    this.id,
    this.status,
    this.image,
    this.imageSm,
    this.imageMd,
    this.nameAR,
    this.nameEN,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'] as int,
      status: json['status'] as int,
      image: json['image'] as String,
      imageSm: json['image_sm'] as String,
      imageMd: json['image_md'] as String,
      nameAR: json['name_ar'] as String,
      nameEN: json['name_en'] as String,
    );
  }
}
