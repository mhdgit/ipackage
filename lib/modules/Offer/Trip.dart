class Trip {
  int id;
  int cityId;
  int countryId;
  int districtId;
  int addBy;
  int tickets;
  int standardCar;
  int microBus;
  int pricePerson;
  int pricePerson2;
  int pricePerson3;
  int priceChild;
  int emptyDay;
  int status;
  int total;
  int pricePlus;
  String date;
  String dateISO;
  String image;
  String imageSm;
  String imageMd;
  String nameAR;
  String tripAR;
  String nameEN;
  String tripEN;
  bool visibility = true;

  Trip({
    this.id,
    this.cityId,
    this.countryId,
    this.districtId,
    this.addBy,
    this.tickets,
    this.standardCar,
    this.microBus,
    this.pricePerson,
    this.pricePerson2,
    this.pricePerson3,
    this.priceChild,
    this.emptyDay,
    this.status,
    this.total,
    this.pricePlus,
    this.date,
    this.dateISO,
    this.image,
    this.imageSm,
    this.imageMd,
    this.nameAR,
    this.tripAR,
    this.nameEN,
    this.tripEN,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {

    return Trip(
      id: json['id'] as int,
      cityId: json['city_id'] as int,
      countryId: json['countrie_id'] as int,
      districtId: json['district_id'] as int,
      addBy: json['add_by'] as int,
      tickets: json['tickets'] as int,
      standardCar: json['standard_car'] as int,
      microBus: json['micro_bus'] as int,
      pricePerson: json['price_person'] as int,
      pricePerson2: json['price_person2'] as int,
      pricePerson3: json['price_person3'] as int,
      priceChild: json['price_child'] as int,
      emptyDay: json['empty_date'] as int,
      status: json['status'] as int,
      total: json['total'] as int,
      pricePlus: json.containsKey('price_plus') ? json['price_plus'] as int : 0,
      date: json['date'] as String,
      dateISO: json['date_iso'] as String,
      image: json['image'] as String,
      imageSm: json['image_sm'] as String,
      imageMd: json['image_md'] as String,
      nameAR: json['name_ar'] as String,
      tripAR: json['trip_ar'] as String,
      nameEN: json['name_en'] as String,
      tripEN: json['trip_en'] as String,
    );
  }
}
