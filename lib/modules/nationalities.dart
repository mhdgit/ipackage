class nationalities {
  int id;
  String iso;
  String name_ar;
  String name_en;
  String phone;
  String continent;
  String capital;
  String currency;
  String languages;

  nationalities({
    this.id,
    this.iso,
    this.name_ar,
    this.name_en,
    this.phone,
    this.continent,
    this.capital,
    this.currency,
    this.languages,
  });

  factory nationalities.fromJson(Map<String, dynamic> json) {

    return nationalities(
      id: json['id'] as int,
      iso: json['iso'] as String,
      name_ar: json['name_ar'] as String,
      name_en: json['name_en'] as String,
      phone: json['phone'] as String,
      continent: json['continent'] as String,
      capital: json['capital'] as String,
      currency: json['currency'] as String,
      languages: json['languages'] as String,
    );
  }
}
