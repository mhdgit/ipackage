
class Transportation {
  int id;
  String nameAR;
  String nameEN;
  String image;
  String imageSm;
  String imageMd;
  int peopleNumber;


  Transportation({
    this.id,
    this.nameAR,
    this.nameEN,
    this.image,
    this.imageMd,
    this.imageSm,
    this.peopleNumber,
  });

  factory Transportation.fromJson(Map<String, dynamic> json) {

    return Transportation(
      id: json['id'] as int,
      nameAR: json['name_ar'] as String,
      nameEN: json['name_en'] as String,
      image: json['image'] as String,
      imageMd: json['image_md'] as String,
      imageSm: json['image_sm'] as String,
      peopleNumber: json['num_person'] as int,
    );
  }
}
