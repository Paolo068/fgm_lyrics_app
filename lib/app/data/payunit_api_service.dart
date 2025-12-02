import 'dart:convert';
import 'dart:developer' as developer;

import 'package:fgm_lyrics_app/core/utils/payunit_config.dart';
import 'package:http/http.dart' as http;

import 'payunit_models.dart';

/// PayUnit API Service for handling all payment-related API calls
class PayUnitApiService {
  /// Get base64 encoded authorization header
  String get _authHeader {
    final credentials = '${PayUnitConfig.apiUser}:${PayUnitConfig.apiPassword}';
    final bytes = utf8.encode(credentials);
    final base64Credentials = base64Encode(bytes);
    return 'Basic $base64Credentials';
  }

  /// Common headers for all requests
  Map<String, String> get _headers => {
    'x-api-key': PayUnitConfig.apiKey,
    'mode': PayUnitConfig.mode,
    'Content-Type': 'application/json',
    'Authorization': _authHeader,
  };

  /// Initialize a payment transaction
  ///
  /// This creates a new transaction and returns the payment URL and providers
  Future<PayUnitInitializeResponse> initializePayment({
    required int totalAmount,
    required String currency,
    required String transactionId,
    required String returnUrl,
    required String notifyUrl,
    String? paymentCountry,
  }) async {
    try {
      final request = PayUnitInitializeRequest(
        totalAmount: totalAmount,
        currency: currency,
        transactionId: transactionId,
        returnUrl: returnUrl,
        notifyUrl: notifyUrl,
        paymentCountry: paymentCountry,
      );

      developer.log(
        'Initializing payment: ${request.toJson()}',
        name: 'PayUnitApiService',
      );

      final response = await http.post(
        Uri.parse('${PayUnitConfig.baseUrl}/initialize'),
        headers: _headers,
        body: jsonEncode(request.toJson()),
      );

      developer.log(
        'Initialize payment response: ${response.statusCode} - ${response.body}',
        name: 'PayUnitApiService',
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        try {
          return PayUnitInitializeResponse.fromJson(jsonResponse);
        } catch (parseError) {
          developer.log(
            'Error parsing initialize response: $parseError',
            name: 'PayUnitApiService',
            level: 1000,
          );
          developer.log(
            'Raw response: ${response.body}',
            name: 'PayUnitApiService',
          );
          rethrow;
        }
      } else {
        final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
        throw PayUnitApiException(
          message: errorResponse['message'] ?? 'Failed to initialize payment',
          statusCode: response.statusCode,
          errorResponse: PayUnitErrorResponse.fromJson(errorResponse),
        );
      }
    } catch (e) {
      developer.log(
        'Error initializing payment: $e',
        name: 'PayUnitApiService',
        level: 1000,
      );
      if (e is PayUnitApiException) rethrow;
      throw PayUnitApiException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  /// Make a payment using a specific gateway
  ///
  /// This confirms the payment request with the selected payment method
  Future<PayUnitMakePaymentResponse> makePayment({
    required String gateway,
    required int amount,
    required String transactionId,
    required String returnUrl,
    required String phoneNumber,
    required String currency,
    required String notifyUrl,
    String paymentType = 'button',
  }) async {
    try {
      final request = PayUnitMakePaymentRequest(
        gateway: gateway,
        amount: amount,
        transactionId: transactionId,
        returnUrl: returnUrl,
        phoneNumber: phoneNumber,
        currency: currency,
        paymentType: paymentType,
        notifyUrl: notifyUrl,
      );

      developer.log(
        'Making payment: ${request.toJson()}',
        name: 'PayUnitApiService',
      );

      final response = await http.post(
        Uri.parse('${PayUnitConfig.baseUrl}/makepayment'),
        headers: _headers,
        body: jsonEncode(request.toJson()),
      );

      developer.log(
        'Make payment response: ${response.statusCode} - ${response.body}',
        name: 'PayUnitApiService',
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        try {
          return PayUnitMakePaymentResponse.fromJson(jsonResponse);
        } catch (parseError) {
          developer.log(
            'Error parsing make payment response: $parseError',
            name: 'PayUnitApiService',
            level: 1000,
          );
          developer.log(
            'Raw response: ${response.body}',
            name: 'PayUnitApiService',
          );
          rethrow;
        }
      } else {
        final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
        throw PayUnitApiException(
          message: errorResponse['message'] ?? 'Failed to make payment',
          statusCode: response.statusCode,
          errorResponse: PayUnitErrorResponse.fromJson(errorResponse),
        );
      }
    } catch (e) {
      developer.log(
        'Error making payment: $e',
        name: 'PayUnitApiService',
        level: 1000,
      );
      if (e is PayUnitApiException) rethrow;
      throw PayUnitApiException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  /// Check the status of a payment transaction
  ///
  /// This verifies the current status of the payment
  Future<PayUnitPaymentStatusResponse> getPaymentStatus({
    required String transactionId,
  }) async {
    try {
      developer.log(
        'Checking payment status for: $transactionId',
        name: 'PayUnitApiService',
      );

      final response = await http.get(
        Uri.parse('${PayUnitConfig.baseUrl}/paymentstatus/$transactionId'),
        headers: _headers,
      );

      developer.log(
        'Payment status response: ${response.statusCode} - ${response.body}',
        name: 'PayUnitApiService',
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        try {
          return PayUnitPaymentStatusResponse.fromJson(jsonResponse);
        } catch (parseError) {
          developer.log(
            'Error parsing payment status response: $parseError',
            name: 'PayUnitApiService',
            level: 1000,
          );
          developer.log(
            'Raw response: ${response.body}',
            name: 'PayUnitApiService',
          );
          rethrow;
        }
      } else {
        final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
        throw PayUnitApiException(
          message: errorResponse['message'] ?? 'Failed to get payment status',
          statusCode: response.statusCode,
          errorResponse: PayUnitErrorResponse.fromJson(errorResponse),
        );
      }
    } catch (e) {
      developer.log(
        'Error getting payment status: $e',
        name: 'PayUnitApiService',
        level: 1000,
      );
      if (e is PayUnitApiException) rethrow;
      throw PayUnitApiException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  /// Generate a unique transaction ID
  ///
  /// Format: pu-{timestamp}-{random}
  static String generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return 'pu-$timestamp-$random';
  }

  /// Validate phone number for specific gateway
  ///
  /// Returns true if the phone number is valid for the gateway
  static bool isValidPhoneForGateway(String phoneNumber, String gateway) {
    // Remove any non-digit characters
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    switch (gateway) {
      case 'CM_ORANGE':
        // Orange Money numbers in Cameroon start with 69, 65, 66, 67
        return cleanPhone.length == 9 &&
            (cleanPhone.startsWith('69') ||
                cleanPhone.startsWith('65') ||
                cleanPhone.startsWith('66') ||
                cleanPhone.startsWith('67'));

      case 'CM_MTN':
        // MTN Mobile Money numbers in Cameroon start with 67, 68, 65, 66
        return cleanPhone.length == 9 &&
            (cleanPhone.startsWith('67') ||
                cleanPhone.startsWith('68') ||
                cleanPhone.startsWith('65') ||
                cleanPhone.startsWith('66'));

      case 'CM_EXPRESS_UNION':
        // Express Union accepts most Cameroon numbers
        return cleanPhone.length == 9 && cleanPhone.startsWith('6');

      default:
        return cleanPhone.length == 9 && cleanPhone.startsWith('6');
    }
  }

  /// Get recommended gateway based on phone number
  ///
  /// Returns the best gateway for the given phone number
  static String? getRecommendedGateway(String phoneNumber) {
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanPhone.length != 9 || !cleanPhone.startsWith('6')) {
      return null;
    }

    if (cleanPhone.startsWith('69') || cleanPhone.startsWith('65')) {
      return 'CM_ORANGE';
    } else if (cleanPhone.startsWith('67') || cleanPhone.startsWith('68')) {
      return 'CM_MTN';
    } else {
      return 'CM_EXPRESS_UNION'; // Fallback for other numbers
    }
  }
}

/// Custom exception for PayUnit API errors
class PayUnitApiException implements Exception {
  final String message;
  final int statusCode;
  final PayUnitErrorResponse? errorResponse;

  const PayUnitApiException({
    required this.message,
    required this.statusCode,
    this.errorResponse,
  });

  @override
  String toString() {
    return 'PayUnitApiException: $message (Status: $statusCode)';
  }
}
