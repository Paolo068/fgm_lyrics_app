import 'dart:developer' as developer;

import 'package:fgm_lyrics_app/app/data/payment_model.dart';
import 'package:fgm_lyrics_app/app/data/payunit_api_service.dart';
import 'package:fgm_lyrics_app/app/data/payunit_models.dart';

/// Repository for handling payment operations
class PaymentRepository {
  final PayUnitApiService _apiService;

  PaymentRepository({PayUnitApiService? apiService})
    : _apiService = apiService ?? PayUnitApiService();

  /// Initialize a payment with PayUnit
  ///
  /// This creates a new transaction and returns the available payment providers
  Future<PayUnitInitializeResponse> initializePayment({
    required Payment payment,
    required String returnUrl,
    required String notifyUrl,
  }) async {
    try {
      // Convert amount to cents (PayUnit expects amount in smallest currency unit)
      final amountInCents = (double.parse(payment.amount) * 100).toInt();

      // Generate unique transaction ID
      final transactionId = PayUnitApiService.generateTransactionId();

      developer.log(
        'Initializing payment for ${payment.email} - Amount: $amountInCents ${payment.currency}',
        name: 'PaymentRepository',
      );

      final response = await _apiService.initializePayment(
        totalAmount: amountInCents,
        currency: payment.currency,
        transactionId: transactionId,
        returnUrl: returnUrl,
        notifyUrl: notifyUrl,
        paymentCountry: 'CM', // Cameroon
      );

      developer.log(
        'Payment initialized successfully: ${response.data.transactionId}',
        name: 'PaymentRepository',
      );

      return response;
    } catch (e) {
      developer.log(
        'Failed to initialize payment: $e',
        name: 'PaymentRepository',
        level: 1000,
      );
      rethrow;
    }
  }

  /// Process payment with selected gateway
  ///
  /// This confirms the payment using the selected payment method
  Future<PayUnitMakePaymentResponse> processPayment({
    required Payment payment,
    required String gateway,
    required String transactionId,
    required String returnUrl,
    required String notifyUrl,
  }) async {
    try {
      // Convert amount to cents
      final amountInCents = (double.parse(payment.amount) * 100).toInt();

      // Clean phone number (remove country code if present)
      String cleanPhone = payment.phone.replaceAll(RegExp(r'[^\d]'), '');
      if (cleanPhone.startsWith('237')) {
        cleanPhone = cleanPhone.substring(3);
      }

      // Validate phone number for the selected gateway
      if (!PayUnitApiService.isValidPhoneForGateway(cleanPhone, gateway)) {
        throw const PayUnitApiException(
          message:
              'Le numéro de téléphone n\'est pas compatible avec le mode de paiement sélectionné',
          statusCode: 400,
        );
      }

      developer.log(
        'Processing payment: $gateway - Phone: $cleanPhone - Amount: $amountInCents',
        name: 'PaymentRepository',
      );

      final response = await _apiService.makePayment(
        gateway: gateway,
        amount: amountInCents,
        transactionId: transactionId,
        returnUrl: returnUrl,
        phoneNumber: cleanPhone,
        currency: payment.currency,
        notifyUrl: notifyUrl,
      );

      developer.log(
        'Payment processed: ${response.data.paymentStatus}',
        name: 'PaymentRepository',
      );

      return response;
    } catch (e) {
      developer.log(
        'Failed to process payment: $e',
        name: 'PaymentRepository',
        level: 1000,
      );
      rethrow;
    }
  }

  /// Check payment status
  ///
  /// This verifies the current status of a payment transaction
  Future<PayUnitPaymentStatusResponse> checkPaymentStatus({
    required String transactionId,
  }) async {
    try {
      developer.log(
        'Checking payment status: $transactionId',
        name: 'PaymentRepository',
      );

      final response = await _apiService.getPaymentStatus(
        transactionId: transactionId,
      );

      developer.log(
        'Payment status: ${response.data.transactionStatus}',
        name: 'PaymentRepository',
      );

      return response;
    } catch (e) {
      developer.log(
        'Failed to check payment status: $e',
        name: 'PaymentRepository',
        level: 1000,
      );
      rethrow;
    }
  }

  /// Get recommended payment gateway based on phone number
  ///
  /// Returns the best payment method for the given phone number
  String? getRecommendedGateway(String phoneNumber) {
    return PayUnitApiService.getRecommendedGateway(phoneNumber);
  }

  /// Validate phone number for a specific gateway
  ///
  /// Returns true if the phone number is valid for the gateway
  bool isValidPhoneForGateway(String phoneNumber, String gateway) {
    return PayUnitApiService.isValidPhoneForGateway(phoneNumber, gateway);
  }

  /// Get all available payment gateways for Cameroon
  ///
  /// Returns a list of supported payment methods
  List<PayUnitGateway> getAvailableGateways() {
    return PayUnitGateway.values;
  }

  /// Convert payment status to user-friendly message
  ///
  /// Returns a localized message based on payment status
  String getStatusMessage(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return 'Paiement en cours de traitement...';
      case 'SUCCESS':
        return 'Paiement effectué avec succès !';
      case 'FAILED':
        return 'Le paiement a échoué. Veuillez réessayer.';
      case 'CANCELLED':
        return 'Paiement annulé par l\'utilisateur.';
      default:
        return 'Statut de paiement inconnu.';
    }
  }
}
