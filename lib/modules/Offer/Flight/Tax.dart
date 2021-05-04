
class Tax {
  double amount;
  String currency;

  Tax({
    this.amount,
    this.currency,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {

    return Tax(
      amount: json['Amount'] as double,
      currency: json['Currency'] as String,
    );
  }
}
