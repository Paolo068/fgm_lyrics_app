// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payunit_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayUnitInitializeRequest _$PayUnitInitializeRequestFromJson(
  Map<String, dynamic> json,
) => PayUnitInitializeRequest(
  totalAmount: (json['total_amount'] as num).toInt(),
  currency: json['currency'] as String,
  transactionId: json['transaction_id'] as String,
  returnUrl: json['return_url'] as String,
  notifyUrl: json['notify_url'] as String,
  paymentCountry: json['payment_country'] as String?,
);

Map<String, dynamic> _$PayUnitInitializeRequestToJson(
  PayUnitInitializeRequest instance,
) => <String, dynamic>{
  'total_amount': instance.totalAmount,
  'currency': instance.currency,
  'transaction_id': instance.transactionId,
  'return_url': instance.returnUrl,
  'notify_url': instance.notifyUrl,
  'payment_country': instance.paymentCountry,
};

PayUnitProvider _$PayUnitProviderFromJson(Map<String, dynamic> json) =>
    PayUnitProvider(
      id: (json['id'] as num?)?.toInt(),
      shortcode: json['shortcode'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String,
      status: json['status'] as String,
      providerType: json['provider_type'] as String?,
      currency: json['currency'] as String?,
      country: PayUnitCountry.fromJson(json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayUnitProviderToJson(PayUnitProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shortcode': instance.shortcode,
      'name': instance.name,
      'logo': instance.logo,
      'status': instance.status,
      'provider_type': instance.providerType,
      'currency': instance.currency,
      'country': instance.country,
    };

PayUnitCountry _$PayUnitCountryFromJson(Map<String, dynamic> json) =>
    PayUnitCountry(
      id: (json['id'] as num?)?.toInt(),
      countryName: json['country_name'] as String,
      countryCode: json['country_code'] as String,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PayUnitCountryToJson(PayUnitCountry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country_name': instance.countryName,
      'country_code': instance.countryCode,
      'status': instance.status,
    };

PayUnitInitializeData _$PayUnitInitializeDataFromJson(
  Map<String, dynamic> json,
) => PayUnitInitializeData(
  tId: json['t_id'] as String,
  tSum: json['t_sum'] as String,
  tUrl: json['t_url'] as String,
  transactionId: json['transaction_id'] as String,
  transactionUrl: json['transaction_url'] as String,
  providers: (json['providers'] as List<dynamic>)
      .map((e) => PayUnitProvider.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PayUnitInitializeDataToJson(
  PayUnitInitializeData instance,
) => <String, dynamic>{
  't_id': instance.tId,
  't_sum': instance.tSum,
  't_url': instance.tUrl,
  'transaction_id': instance.transactionId,
  'transaction_url': instance.transactionUrl,
  'providers': instance.providers,
};

PayUnitInitializeResponse _$PayUnitInitializeResponseFromJson(
  Map<String, dynamic> json,
) => PayUnitInitializeResponse(
  status: json['status'] as String,
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: PayUnitInitializeData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PayUnitInitializeResponseToJson(
  PayUnitInitializeResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

PayUnitMakePaymentRequest _$PayUnitMakePaymentRequestFromJson(
  Map<String, dynamic> json,
) => PayUnitMakePaymentRequest(
  gateway: json['gateway'] as String,
  amount: (json['amount'] as num).toInt(),
  transactionId: json['transaction_id'] as String,
  returnUrl: json['return_url'] as String,
  phoneNumber: json['phone_number'] as String,
  currency: json['currency'] as String,
  paymentType: json['paymentType'] as String,
  notifyUrl: json['notify_url'] as String,
);

Map<String, dynamic> _$PayUnitMakePaymentRequestToJson(
  PayUnitMakePaymentRequest instance,
) => <String, dynamic>{
  'gateway': instance.gateway,
  'amount': instance.amount,
  'transaction_id': instance.transactionId,
  'return_url': instance.returnUrl,
  'phone_number': instance.phoneNumber,
  'currency': instance.currency,
  'paymentType': instance.paymentType,
  'notify_url': instance.notifyUrl,
};

PayUnitMakePaymentData _$PayUnitMakePaymentDataFromJson(
  Map<String, dynamic> json,
) => PayUnitMakePaymentData(
  id: json['id'] as String?,
  transactionId: json['transaction_id'] as String,
  paymentStatus: json['payment_status'] as String,
  amount: (json['amount'] as num).toInt(),
  providerTransactionId: json['provider_transaction_id'] as String?,
);

Map<String, dynamic> _$PayUnitMakePaymentDataToJson(
  PayUnitMakePaymentData instance,
) => <String, dynamic>{
  'id': instance.id,
  'transaction_id': instance.transactionId,
  'payment_status': instance.paymentStatus,
  'amount': instance.amount,
  'provider_transaction_id': instance.providerTransactionId,
};

PayUnitMakePaymentResponse _$PayUnitMakePaymentResponseFromJson(
  Map<String, dynamic> json,
) => PayUnitMakePaymentResponse(
  status: json['status'] as String,
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: PayUnitMakePaymentData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PayUnitMakePaymentResponseToJson(
  PayUnitMakePaymentResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

PayUnitPaymentStatusData _$PayUnitPaymentStatusDataFromJson(
  Map<String, dynamic> json,
) => PayUnitPaymentStatusData(
  transactionAmount: (json['transaction_amount'] as num?)?.toInt(),
  transactionStatus: json['transaction_status'] as String,
  transactionId: json['transaction_id'] as String,
  purchaseRef: json['purchaseRef'] as String?,
  notifyUrl: json['notify_url'] as String,
  callbackUrl: json['callback_url'] as String,
  transactionCurrency: json['transaction_currency'] as String,
  transactionGateway: json['transaction_gateway'] as String?,
  fee: json['fee'] as String?,
  message: json['message'] as String,
);

Map<String, dynamic> _$PayUnitPaymentStatusDataToJson(
  PayUnitPaymentStatusData instance,
) => <String, dynamic>{
  'transaction_amount': instance.transactionAmount,
  'transaction_status': instance.transactionStatus,
  'transaction_id': instance.transactionId,
  'purchaseRef': instance.purchaseRef,
  'notify_url': instance.notifyUrl,
  'callback_url': instance.callbackUrl,
  'transaction_currency': instance.transactionCurrency,
  'transaction_gateway': instance.transactionGateway,
  'fee': instance.fee,
  'message': instance.message,
};

PayUnitPaymentStatusResponse _$PayUnitPaymentStatusResponseFromJson(
  Map<String, dynamic> json,
) => PayUnitPaymentStatusResponse(
  status: json['status'] as String,
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: PayUnitPaymentStatusData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PayUnitPaymentStatusResponseToJson(
  PayUnitPaymentStatusResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

PayUnitErrorResponse _$PayUnitErrorResponseFromJson(
  Map<String, dynamic> json,
) => PayUnitErrorResponse(
  status: json['status'] as String,
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: json['data'],
);

Map<String, dynamic> _$PayUnitErrorResponseToJson(
  PayUnitErrorResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};
