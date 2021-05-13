
class Transportation {
  int id;
  String nameAR;
  String nameEN;
  String image;
  String imageSm;
  String imageMd;
  int peopleNumber;
  bool visibility;


  Transportation({
    this.id,
    this.nameAR,
    this.nameEN,
    this.image,
    this.imageMd,
    this.imageSm,
    this.peopleNumber,
    this.visibility,
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
      visibility: true,
    );
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name_ar'] = this.nameAR;
    data['name_en'] = this.nameEN;
    data['image'] = this.image;
    data['image_md'] = this.imageMd;
    data['image_sm'] = this.imageSm;
    data['num_person'] = this.peopleNumber;

    return data;
  }
}
