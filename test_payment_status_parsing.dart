import 'dart:convert';

import 'lib/app/data/payunit_models.dart';

void main() {
  // Test with the actual payment status API response from the logs
  const String apiResponse = '''
{
  "status": "SUCCESS",
  "statusCode": 200,
  "message": "payment in progress",
  "data": {
    "transaction_amount": null,
    "transaction_status": "SUCCESS",
    "transaction_id": "pu-1759269247265-7265",
    "purchaseRef": null,
    "notify_url": "https://yourapp.com/payment/notify",
    "callback_url": "https://yourapp.com/payment/return",
    "transaction_currency": "XAF",
    "transaction_gateway": null,
    "fee": "0.000",
    "message": "payment in progress"
  }
}
''';

  try {
    final jsonResponse = jsonDecode(apiResponse) as Map<String, dynamic>;
    final response = PayUnitPaymentStatusResponse.fromJson(jsonResponse);

    print('✅ Successfully parsed PayUnit payment status response!');
    print('Status: ${response.status}');
    print('Message: ${response.message}');
    print('Transaction ID: ${response.data.transactionId}');
    print('Transaction Status: ${response.data.transactionStatus}');
    print('Transaction Amount: ${response.data.transactionAmount ?? "null"}');
    print('Transaction Currency: ${response.data.transactionCurrency}');
    print('Transaction Gateway: ${response.data.transactionGateway ?? "null"}');
    print('Fee: ${response.data.fee ?? "null"}');
    print('Purchase Ref: ${response.data.purchaseRef ?? "null"}');
    print('Data Message: ${response.data.message}');
  } catch (e, stackTrace) {
    print('❌ Error parsing PayUnit payment status response: $e');
    print('Stack trace: $stackTrace');
  }
}

