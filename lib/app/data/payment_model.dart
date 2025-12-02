class Payment {
  final String name;
  final String email;
  final String phone;
  final String amount;
  final String currency;
  final String status;
  const Payment({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.amount = '',
    this.currency = '',
    this.status = '',
  });

  Payment copyWith({
    String? name,
    String? email,
    String? phone,
    String? amount,
    String? currency,
    String? status,
  }) {
    return Payment(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'amount': amount,
      'currency': currency,
      'status': status,
    };
  }

  @override
  String toString() {
    return '''Payment(name: $name, email: $email, phone: $phone, amount: $amount, currency: $currency, status: $status)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payment &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.amount == amount &&
        other.currency == currency &&
        other.status == status;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        status.hashCode;
  }
}
