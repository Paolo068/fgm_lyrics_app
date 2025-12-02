import 'package:json_annotation/json_annotation.dart';

part 'payunit_models.g.dart';

/// PayUnit Initialize Payment Request
@JsonSerializable()
class PayUnitInitializeRequest {
  @JsonKey(name: 'total_amount')
  final int totalAmount;
  final String currency;
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @JsonKey(name: 'return_url')
  final String returnUrl;
  @JsonKey(name: 'notify_url')
  final String notifyUrl;
  @JsonKey(name: 'payment_country')
  final String? paymentCountry;

  const PayUnitInitializeRequest({
    required this.totalAmount,
    required this.currency,
    required this.transactionId,
    required this.returnUrl,
    required this.notifyUrl,
    this.paymentCountry,
  });

  factory PayUnitInitializeRequest.fromJson(Map<String, dynamic> json) =>
      _$PayUnitInitializeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitInitializeRequestToJson(this);
}

/// PayUnit Provider Information
@JsonSerializable()
class PayUnitProvider {
  final int? id;
  final String shortcode;
  final String name;
  final String logo;
  final String status;
  @JsonKey(name: 'provider_type')
  final String? providerType;
  final String? currency;
  final PayUnitCountry country;

  const PayUnitProvider({
    this.id,
    required this.shortcode,
    required this.name,
    required this.logo,
    required this.status,
    this.providerType,
    this.currency,
    required this.country,
  });

  factory PayUnitProvider.fromJson(Map<String, dynamic> json) =>
      _$PayUnitProviderFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitProviderToJson(this);
}

/// PayUnit Country Information
@JsonSerializable()
class PayUnitCountry {
  final int? id;
  @JsonKey(name: 'country_name')
  final String countryName;
  @JsonKey(name: 'country_code')
  final String countryCode;
  final String? status;

  const PayUnitCountry({
    this.id,
    required this.countryName,
    required this.countryCode,
    this.status,
  });

  factory PayUnitCountry.fromJson(Map<String, dynamic> json) =>
      _$PayUnitCountryFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitCountryToJson(this);
}

/// PayUnit Initialize Payment Response Data
@JsonSerializable()
class PayUnitInitializeData {
  @JsonKey(name: 't_id')
  final String tId;
  @JsonKey(name: 't_sum')
  final String tSum;
  @JsonKey(name: 't_url')
  final String tUrl;
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @JsonKey(name: 'transaction_url')
  final String transactionUrl;
  final List<PayUnitProvider> providers;

  const PayUnitInitializeData({
    required this.tId,
    required this.tSum,
    required this.tUrl,
    required this.transactionId,
    required this.transactionUrl,
    required this.providers,
  });

  factory PayUnitInitializeData.fromJson(Map<String, dynamic> json) =>
      _$PayUnitInitializeDataFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitInitializeDataToJson(this);
}

/// PayUnit Initialize Payment Response
@JsonSerializable()
class PayUnitInitializeResponse {
  final String status;
  final int statusCode;
  final String message;
  final PayUnitInitializeData data;

  const PayUnitInitializeResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PayUnitInitializeResponse.fromJson(Map<String, dynamic> json) =>
      _$PayUnitInitializeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitInitializeResponseToJson(this);
}

/// PayUnit Make Payment Request
@JsonSerializable()
class PayUnitMakePaymentRequest {
  final String gateway;
  final int amount;
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @JsonKey(name: 'return_url')
  final String returnUrl;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String currency;
  @JsonKey(name: 'paymentType')
  final String paymentType;
  @JsonKey(name: 'notify_url')
  final String notifyUrl;

  const PayUnitMakePaymentRequest({
    required this.gateway,
    required this.amount,
    required this.transactionId,
    required this.returnUrl,
    required this.phoneNumber,
    required this.currency,
    required this.paymentType,
    required this.notifyUrl,
  });

  factory PayUnitMakePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$PayUnitMakePaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitMakePaymentRequestToJson(this);
}

/// PayUnit Make Payment Response Data
@JsonSerializable()
class PayUnitMakePaymentData {
  final String? id;
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @JsonKey(name: 'payment_status')
  final String paymentStatus;
  final int amount;
  @JsonKey(name: 'provider_transaction_id')
  final String? providerTransactionId;

  const PayUnitMakePaymentData({
    this.id,
    required this.transactionId,
    required this.paymentStatus,
    required this.amount,
    this.providerTransactionId,
  });

  factory PayUnitMakePaymentData.fromJson(Map<String, dynamic> json) =>
      _$PayUnitMakePaymentDataFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitMakePaymentDataToJson(this);
}

/// PayUnit Make Payment Response
@JsonSerializable()
class PayUnitMakePaymentResponse {
  final String status;
  final int statusCode;
  final String message;
  final PayUnitMakePaymentData data;

  const PayUnitMakePaymentResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PayUnitMakePaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PayUnitMakePaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitMakePaymentResponseToJson(this);
}

/// PayUnit Payment Status Response Data
@JsonSerializable()
class PayUnitPaymentStatusData {
  @JsonKey(name: 'transaction_amount')
  final int? transactionAmount;
  @JsonKey(name: 'transaction_status')
  final String transactionStatus;
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @JsonKey(name: 'purchaseRef')
  final String? purchaseRef;
  @JsonKey(name: 'notify_url')
  final String notifyUrl;
  @JsonKey(name: 'callback_url')
  final String callbackUrl;
  @JsonKey(name: 'transaction_currency')
  final String transactionCurrency;
  @JsonKey(name: 'transaction_gateway')
  final String? transactionGateway;
  final String? fee;
  final String message;

  const PayUnitPaymentStatusData({
    this.transactionAmount,
    required this.transactionStatus,
    required this.transactionId,
    this.purchaseRef,
    required this.notifyUrl,
    required this.callbackUrl,
    required this.transactionCurrency,
    this.transactionGateway,
    this.fee,
    required this.message,
  });

  factory PayUnitPaymentStatusData.fromJson(Map<String, dynamic> json) =>
      _$PayUnitPaymentStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitPaymentStatusDataToJson(this);
}

/// PayUnit Payment Status Response
@JsonSerializable()
class PayUnitPaymentStatusResponse {
  final String status;
  final int statusCode;
  final String message;
  final PayUnitPaymentStatusData data;

  const PayUnitPaymentStatusResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PayUnitPaymentStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$PayUnitPaymentStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitPaymentStatusResponseToJson(this);
}

/// PayUnit API Error Response
@JsonSerializable()
class PayUnitErrorResponse {
  final String status;
  final int statusCode;
  final String message;
  final dynamic data;

  const PayUnitErrorResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory PayUnitErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$PayUnitErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayUnitErrorResponseToJson(this);
}

/// Payment Status Enum
enum PaymentStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('SUCCESS')
  success,
  @JsonValue('FAILED')
  failed,
  @JsonValue('CANCELLED')
  cancelled,
}

/// PayUnit Gateway Enum for Cameroon
enum PayUnitGateway {
  @JsonValue('CM_ORANGE')
  orangeMoney,
  @JsonValue('CM_MTNMOMO')
  mtnMomo,
  @JsonValue('CM_EXPRESS_UNION')
  expressUnion,
}

extension PayUnitGatewayExtension on PayUnitGateway {
  String get displayName {
    switch (this) {
      case PayUnitGateway.orangeMoney:
        return 'Orange Money';
      case PayUnitGateway.mtnMomo:
        return 'MTN Mobile Money';
      case PayUnitGateway.expressUnion:
        return 'Express Union';
    }
  }

  String get value {
    switch (this) {
      case PayUnitGateway.orangeMoney:
        return 'CM_ORANGE';
      case PayUnitGateway.mtnMomo:
        return 'CM_MTNMOMO';
      case PayUnitGateway.expressUnion:
        return 'CM_EXPRESS_UNION';
    }
  }
}
