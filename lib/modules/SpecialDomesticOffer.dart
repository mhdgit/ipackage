class SpecialDomesticOffer {
  int id;
  int daysNumber;
  int countryId;
  int packageId;
  int addBy;
  String rating;
  int flight;
  int special;
  bool transfer;
  int status;
  int startPrice;
  String descriptionAR;
  String descriptionEN;
  String countryAR;
  String countryEN;
  String packageAR;
  String packageEN;
  String image;
  String imageSm;
  String imageMd;
  int airportGo;
  int airportBack;

  SpecialDomesticOffer({
    this.id,
    this.daysNumber,
    this.countryId,
    this.rating,
    this.status,
    this.addBy,
    this.packageId,
    this.flight,
    this.special,
    this.startPrice,
    this.transfer,
    this.descriptionAR,
    this.descriptionEN,
    this.countryAR,
    this.countryEN,
    this.packageAR,
    this.packageEN,
    this.image,
    this.imageSm,
    this.imageMd,
    this.airportGo,
    this.airportBack,
  });

  factory SpecialDomesticOffer.fromJson(Map<String, dynamic> json) {

    return SpecialDomesticOffer(
      id: json['id'] as int,
      daysNumber: json['days'] as int,
      addBy: json['add_by'] as int,
      countryId: json['countrie_id'] as int,
      packageId: json['package_id'] as int,
      flight: json['flight'] as int,
      rating: json['stars'] as String,
      special: json['special'] as int,
      startPrice: json['start_pirce'] as int,
      status: json['status'] as int,
      transfer: json['transfer'] as bool,
      descriptionAR: json['description_ar'] as String,
      descriptionEN: json['description_en'] as String,
      countryAR: json['country_ar'] as String,
      countryEN: json['country_en'] as String,
      packageAR: json['package_ar'] as String,
      packageEN: json['package_en'] as String,
      image: json['image'] as String,
      imageMd: json['image_md'] as String,
      imageSm: json['image_sm'] as String,
      airportGo: json['airpot_go'] as int,
      airportBack: json['airpot_back'] as int,
    );
  }
}
